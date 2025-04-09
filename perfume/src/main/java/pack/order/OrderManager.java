package pack.order;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;

public class OrderManager {
	private Connection conn;
	private PreparedStatement insertOrderPstmt;
	private PreparedStatement updateStockPstmt;
	private PreparedStatement deleteCartPstmt;
	private DataSource ds;

	public OrderManager() {
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("OrderManager DB 연결 실패: " + e.getMessage());
		}
	}

	public boolean insertOrdersWithTransaction(int user_no) {
		Connection conn = null;
		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false); // 트랜잭션 시작

			pack.cart.CartManager cartManager = new pack.cart.CartManager();
			ArrayList<pack.cart.CartDto> cartList = cartManager.getCartsByCustomer(user_no);

			String insertOrderSql = "INSERT INTO orders (user_no, product_no, orderquantity, cancelednot, totalprice, orderdate) VALUES (?, ?, ?, '정상', ?, NOW())";
			insertOrderPstmt = conn.prepareStatement(insertOrderSql);

			String updateStockSql = "UPDATE stock SET productquantity = productquantity - ? WHERE productnum = ?";
			updateStockPstmt = conn.prepareStatement(updateStockSql);

			for (pack.cart.CartDto dto : cartList) {
				// 1. 주문 정보 등록
				insertOrderPstmt.setInt(1, user_no);
				insertOrderPstmt.setInt(2, dto.getProduct_no());
				insertOrderPstmt.setInt(3, dto.getQuantity());
				insertOrderPstmt.setInt(4, dto.getTotal_price());
				insertOrderPstmt.executeUpdate();

				// 2. 재고 차감
				updateStockPstmt.setInt(1, dto.getQuantity());
				updateStockPstmt.setInt(2, dto.getProduct_no());
				updateStockPstmt.executeUpdate();
			}

			// 3. 장바구니 비우기
			String deleteCartSql = "DELETE FROM cart WHERE user_no = ?";
			deleteCartPstmt = conn.prepareStatement(deleteCartSql);
			deleteCartPstmt.setInt(1, user_no);
			deleteCartPstmt.executeUpdate();

			conn.commit();
			return true;

		} catch (Exception e) {
			try {
				if (conn != null)
					conn.rollback();
			} catch (SQLException rollbackEx) {
				rollbackEx.printStackTrace();
			}
			System.out.println("insertOrdersWithTransaction 오류: " + e.getMessage());
			return false;

		} finally {
			try {
				if (insertOrderPstmt != null)
					insertOrderPstmt.close();
			} catch (Exception e) {
			}
			try {
				if (updateStockPstmt != null)
					updateStockPstmt.close();
			} catch (Exception e) {
			}
			try {
				if (deleteCartPstmt != null)
					deleteCartPstmt.close();
			} catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
	}
}
