package pack.delivery;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;

public class CustomerDeliveryManager {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private DataSource ds;

    public CustomerDeliveryManager() {
        try {
            Context ctx = new InitialContext();
            ds = (DataSource) ctx.lookup("java:comp/env/jdbc_maria");
        } catch (Exception e) {
            System.out.println("CustomerDeliveryManager DB 연결 오류: " + e.getMessage());
        }
    }

    public List<CustomerDeliveryDto> getMyDeliveries(int user_no) {
        List<CustomerDeliveryDto> list = new ArrayList<>();
        try {
            conn = ds.getConnection();
            String sql = "SELECT o.order_no, p.productname, p.product_no, o.orderquantity, o.orderdate, " +
                         "d.deliverystatus, d.trackingnumber, d.shpaddress, d.shpdetailaddress " +
                         "FROM orders o " +
                         "JOIN delivery d ON o.order_no = d.ordernumber " +
                         "JOIN product p ON o.product_no = p.product_no " +
                         "WHERE o.user_no = ? " +
                         "ORDER BY o.order_no DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, user_no);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CustomerDeliveryDto dto = new CustomerDeliveryDto();
                dto.setOrder_no(rs.getInt("order_no"));
                dto.setProduct_name(rs.getString("productname"));
                dto.setProduct_no(rs.getInt("product_no"));
                dto.setOrder_quantity(rs.getInt("orderquantity"));
                dto.setOrder_date(rs.getDate("orderdate"));
                dto.setDeliverystatus(rs.getInt("deliverystatus"));
                dto.setTrackingnumber(rs.getString("trackingnumber"));
                dto.setShpaddress(rs.getString("shpaddress"));
                dto.setShpdetailaddress(rs.getString("shpdetailaddress"));
                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("getMyDeliveries 오류: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); if (pstmt != null) pstmt.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return list;
    }

    public List<CustomerDeliveryDto> getMyDeliveriesByUsername(String username) {
        List<CustomerDeliveryDto> list = new ArrayList<>();
        try {
            conn = ds.getConnection();
            String sql = "SELECT o.order_no, p.productname, p.product_no, o.orderquantity, o.orderdate, " +
                         "d.deliverystatus, d.trackingnumber, d.shpaddress, d.shpdetailaddress " +
                         "FROM orders o " +
                         "JOIN delivery d ON o.order_no = d.ordernumber " +
                         "JOIN product p ON o.product_no = p.product_no " +
                         "JOIN customer c ON o.user_no = c.user_no " +
                         "WHERE c.username = ? AND o.cancelednot = '주문' " +
                         "ORDER BY o.order_no DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CustomerDeliveryDto dto = new CustomerDeliveryDto();
                dto.setOrder_no(rs.getInt("order_no"));
                dto.setProduct_name(rs.getString("productname"));
                dto.setOrder_quantity(rs.getInt("orderquantity"));
                dto.setOrder_date(rs.getDate("orderdate"));
                dto.setDeliverystatus(rs.getInt("deliverystatus"));
                dto.setTrackingnumber(rs.getString("trackingnumber"));
                dto.setShpaddress(rs.getString("shpaddress"));
                dto.setShpdetailaddress(rs.getString("shpdetailaddress"));
                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("getMyDeliveriesByUsername 오류: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); if (pstmt != null) pstmt.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return list;
    }
}
