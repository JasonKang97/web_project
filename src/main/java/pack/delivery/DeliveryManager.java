package pack.delivery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DeliveryManager {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private DataSource ds;

    public DeliveryManager() {
        try {
            Context context = new InitialContext();
            ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
        } catch (Exception e) {
            System.out.println("DeliveryManager DB 연결 실패: " + e.getMessage());
        }
    }

    public DeliveryBean getDeliveryInfo(int ordernumber) {
        DeliveryBean bean = null;
        try {
            conn = ds.getConnection();
            String sql = "SELECT d.ordernumber, d.usernumber, d.trackingnumber, d.deliverystatus, d.shippingdate, " +
                         "d.shpaddress, d.shpdetailaddress, c.username, p.productname " +
                         "FROM delivery d " +
                         "JOIN orders o ON d.ordernumber = o.order_no " +
                         "JOIN customer c ON o.user_no = c.user_no " +
                         "JOIN product p ON o.product_no = p.product_no " +
                         "WHERE d.ordernumber = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ordernumber);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                bean = new DeliveryBean();
                bean.setOrdernumber(rs.getInt("ordernumber"));
                bean.setUsernumber(rs.getInt("usernumber"));
                bean.setTrackingnumber(rs.getString("trackingnumber"));
                bean.setDeliverystatus(rs.getInt("deliverystatus"));
                bean.setShippingdate(rs.getTimestamp("shippingdate"));
                bean.setShpaddress(rs.getString("shpaddress"));
                bean.setShpdetailaddress(rs.getString("shpdetailaddress"));
                bean.setUsername(rs.getString("username"));
                bean.setProductname(rs.getString("productname"));
            }
        } catch (Exception e) {
            System.out.println("getDeliveryInfo 오류: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return bean;
    }
    
    public List<DeliveryBean> getDeliveryDetail() {
        List<DeliveryBean> list = new ArrayList<>();
        try {
            conn = ds.getConnection();
            String sql = "SELECT d.ordernumber, d.usernumber, d.trackingnumber, d.deliverystatus, d.shippingdate, " +
                         "d.shpaddress, d.shpdetailaddress, c.username, p.productname " +
                         "FROM delivery d " +
                         "JOIN orders o ON d.ordernumber = o.order_no " +
                         "JOIN customer c ON o.user_no = c.user_no " +
                         "JOIN product p ON o.product_no = p.product_no " +
                         "WHERE o.cancelednot = '주문' " +
                         "ORDER BY d.ordernumber DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                DeliveryBean bean = new DeliveryBean();
                bean.setOrdernumber(rs.getInt("ordernumber"));
                bean.setUsernumber(rs.getInt("usernumber"));
                bean.setTrackingnumber(rs.getString("trackingnumber"));
                bean.setDeliverystatus(rs.getInt("deliverystatus"));
                bean.setShippingdate(rs.getTimestamp("shippingdate"));
                bean.setShpaddress(rs.getString("shpaddress"));
                bean.setShpdetailaddress(rs.getString("shpdetailaddress"));
                bean.setUsername(rs.getString("username"));
                bean.setProductname(rs.getString("productname"));
                list.add(bean);
            }
        } catch (Exception e) {
            System.out.println("getDeliveryDetail 오류: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return list;
    }
    
    public boolean updateStatus(int ordernumber, int newStatus, String shippingdate) {
        boolean result = false;
        try {
            conn = ds.getConnection();

            String sql;
            if (newStatus == 3 && shippingdate != null && !shippingdate.isEmpty()) {
                sql = "UPDATE delivery SET deliverystatus = ?, shippingdate = ? WHERE ordernumber = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, newStatus);
                pstmt.setString(2, shippingdate);  // 'YYYY-MM-DD HH:mm:ss' 형식
                pstmt.setInt(3, ordernumber);
            } else {
                sql = "UPDATE delivery SET deliverystatus = ? WHERE ordernumber = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, newStatus);
                pstmt.setInt(2, ordernumber);
            }

            result = pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("updateStatus 오류: " + e.getMessage());
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        return result;
    }

}