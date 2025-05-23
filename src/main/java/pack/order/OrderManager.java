package pack.order;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;

public class OrderManager {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private DataSource ds;

    public OrderManager() {
        try {
            Context context = new InitialContext();
            ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
        } catch (Exception e) {
            System.out.println("OrderManager DB 연결 실패: " + e.getMessage());
        }
    }

    public ArrayList<OrderDto> getAllOrders() {
        ArrayList<OrderDto> list = new ArrayList<>();
        try {
            conn = ds.getConnection();
            String sql = "SELECT o.*, c.username, p.productname, p.productprice " +
                         "FROM orders o " +
                         "JOIN customer c ON o.user_no = c.user_no " +
                         "JOIN product p ON o.product_no = p.product_no " +
                         "ORDER BY o.order_no DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                OrderDto bean = new OrderDto();
                bean.setOrder_no(rs.getInt("order_no"));
                bean.setUser_no(rs.getInt("user_no"));
                bean.setProduct_no(rs.getInt("product_no"));
                bean.setOrder_quantity(rs.getInt("orderquantity"));
                bean.setCanceled_not(rs.getString("cancelednot"));
                bean.setTotal_price(rs.getInt("totalprice"));
                bean.setOrder_date(rs.getDate("orderdate"));
                bean.setUser_name(rs.getString("username"));
                bean.setProduct_name(rs.getString("productname"));
                bean.setProduct_price(rs.getInt("productprice"));
                list.add(bean);
            }
        } catch (Exception e) {
            System.out.println("getAllOrders 오류: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); if (pstmt != null) pstmt.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return list;
    }

    public OrderDto getOrder(String order_no) {
        OrderDto bean = null;
        try {
            conn = ds.getConnection();
            String sql = "SELECT o.*, c.username, p.productname, p.productprice " +
                         "FROM orders o " +
                         "JOIN customer c ON o.user_no = c.user_no " +
                         "JOIN product p ON o.product_no = p.product_no " +
                         "WHERE o.order_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, order_no);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                bean = new OrderDto();
                bean.setOrder_no(rs.getInt("order_no"));
                bean.setUser_no(rs.getInt("user_no"));
                bean.setProduct_no(rs.getInt("product_no"));
                bean.setOrder_quantity(rs.getInt("orderquantity"));
                bean.setCanceled_not(rs.getString("cancelednot"));
                bean.setTotal_price(rs.getInt("totalprice"));
                bean.setOrder_date(rs.getDate("orderdate"));
                bean.setUser_name(rs.getString("username"));
                bean.setProduct_name(rs.getString("productname"));
                bean.setProduct_price(rs.getInt("productprice"));
            }
        } catch (Exception e) {
            System.out.println("getOrder 오류: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); if (pstmt != null) pstmt.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return bean;
    }

    public boolean updateOrderState(String order_no, String canceled_not) {
        boolean result = false;
        try {
            conn = ds.getConnection();
            String sql = "UPDATE orders SET cancelednot=? WHERE order_no=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, canceled_not);
            pstmt.setString(2, order_no);
            result = pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("updateOrderState 오류: " + e.getMessage());
        } finally {
            try { if (pstmt != null) pstmt.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return result;
    }

    public boolean insertOrdersWithTransaction(int user_no) {
        Connection conn = null;
        PreparedStatement insertOrderPstmt = null;
        PreparedStatement updateStockPstmt = null;
        PreparedStatement deleteCartPstmt = null;

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
                if (conn != null) conn.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            System.out.println("insertOrdersWithTransaction 오류: " + e.getMessage());
            return false;

        } finally {
            try { if (insertOrderPstmt != null) insertOrderPstmt.close(); } catch (Exception e) {}
            try { if (updateStockPstmt != null) updateStockPstmt.close(); } catch (Exception e) {}
            try { if (deleteCartPstmt != null) deleteCartPstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
