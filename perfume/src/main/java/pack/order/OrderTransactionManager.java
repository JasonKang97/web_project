package pack.order;

import pack.cart.CartManager;
import pack.cart.CartDto;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.UUID;

public class OrderTransactionManager {
    private DataSource ds;

    public OrderTransactionManager() {
        try {
            Context context = new InitialContext();
            ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
        } catch (Exception e) {
            System.out.println("OrderTransactionManager DB 연결 실패: " + e.getMessage());
        }
    }

    public boolean processOrderTransaction(int user_no) {
        Connection conn = null;
        PreparedStatement insertOrderPstmt = null;
        PreparedStatement updateStockPstmt = null;
        PreparedStatement deleteCartPstmt = null;
        PreparedStatement insertDeliveryPstmt = null;
        PreparedStatement getAddressPstmt = null;
        ResultSet generatedKeys = null;
        ResultSet addressRs = null;

        try {
            conn = ds.getConnection();
            conn.setAutoCommit(false);

            // 1. 사용자 주소 정보 조회
            String userAddress = "";
            String userDetailAddress = "";

            String addressSql = "SELECT address, detailaddress FROM customer WHERE user_no = ?";
            getAddressPstmt = conn.prepareStatement(addressSql);
            getAddressPstmt.setInt(1, user_no);
            addressRs = getAddressPstmt.executeQuery();
            if (addressRs.next()) {
                userAddress = addressRs.getString("address");
                userDetailAddress = addressRs.getString("detailaddress");
            }

            // 2. 장바구니 목록 조회
            CartManager cartManager = new CartManager();
            ArrayList<CartDto> cartList = cartManager.getCartsByCustomer(user_no);

            String insertOrderSql = "INSERT INTO orders (user_no, product_no, orderquantity, cancelednot, totalprice, orderdate) VALUES (?, ?, ?, '정상', ?, NOW())";
            insertOrderPstmt = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS);

            String updateStockSql = "UPDATE stock SET productquantity = productquantity - ?, lastmodifieddate = NOW() WHERE productnum = ?";
            updateStockPstmt = conn.prepareStatement(updateStockSql);

            String insertDeliverySql = "INSERT INTO delivery (ordernumber, usernumber, trackingnumber, deliverystatus, shippingdate, shpaddress, shpdetailaddress) VALUES (?, ?, ?, ?, NULL, ?, ?)";
            insertDeliveryPstmt = conn.prepareStatement(insertDeliverySql);

            for (CartDto dto : cartList) {
                // 3-1. 주문 등록
                insertOrderPstmt.setInt(1, user_no);
                insertOrderPstmt.setInt(2, dto.getProduct_no());
                insertOrderPstmt.setInt(3, dto.getQuantity());
                insertOrderPstmt.setInt(4, dto.getTotal_price());
                insertOrderPstmt.executeUpdate();

                generatedKeys = insertOrderPstmt.getGeneratedKeys();
                int orderNo = 0;
                if (generatedKeys.next()) {
                    orderNo = generatedKeys.getInt(1);
                }
                generatedKeys.close();

                // 3-2. 재고 차감
                updateStockPstmt.setInt(1, dto.getQuantity());
                updateStockPstmt.setInt(2, dto.getProduct_no());
                updateStockPstmt.executeUpdate();

                // 3-3. 배송 등록
                insertDeliveryPstmt.setInt(1, orderNo);
                insertDeliveryPstmt.setInt(2, user_no);
                insertDeliveryPstmt.setString(3, UUID.randomUUID().toString().substring(0, 13)); // 송장번호
                insertDeliveryPstmt.setInt(4, 1); // 관리자 확인 전
                insertDeliveryPstmt.setString(5, userAddress);
                insertDeliveryPstmt.setString(6, userDetailAddress);
                insertDeliveryPstmt.executeUpdate();
            }

            // 4. 장바구니 비우기
            String deleteCartSql = "DELETE FROM cart WHERE user_no = ?";
            deleteCartPstmt = conn.prepareStatement(deleteCartSql);
            deleteCartPstmt.setInt(1, user_no);
            deleteCartPstmt.executeUpdate();

            conn.commit();
            return true;

        } catch (Exception e) {
            System.out.println("processOrderTransaction err : " + e);
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { System.out.println("rollback err : " + ex); }
            }
            return false;

        } finally {
            try {
                if (addressRs != null) addressRs.close();
                if (generatedKeys != null) generatedKeys.close();
                if (getAddressPstmt != null) getAddressPstmt.close();
                if (insertOrderPstmt != null) insertOrderPstmt.close();
                if (updateStockPstmt != null) updateStockPstmt.close();
                if (deleteCartPstmt != null) deleteCartPstmt.close();
                if (insertDeliveryPstmt != null) insertDeliveryPstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                System.out.println("close err : " + e);
            }
        }
    }

}
