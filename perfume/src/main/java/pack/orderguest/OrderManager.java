package pack.orderguest;

import pack.orderguest.OrderBean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class OrderManager {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public OrderManager() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("Driver 로딩 실패: " + e.getMessage());
		}
	}
	
	public ArrayList<pack.orderguest.OrderBean> getOrder(String user_no){	// 로그인한 고객의 주문 정보
		ArrayList<pack.orderguest.OrderBean> list = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			String sql = "select * from orders where user_no=? order by user_no desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_no);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				pack.orderguest.OrderBean orderBean = new pack.orderguest.OrderBean();
				orderBean.setOrder_no(rs.getString("order_no"));
				orderBean.setProduct_no(rs.getString("product_no"));
				orderBean.setOrderquantity(rs.getString("orderquantity"));
				orderBean.setCancelednot(rs.getString("cancelednot"));
				orderBean.setTotalprice(rs.getString("totalprice"));
				orderBean.setOrderdate(rs.getString("orderdate"));
				list.add(orderBean);
			}
		} catch (Exception e) {
			System.out.println("getOrder err: " + e);
		} finally {
			try {
				if(rs != null)pstmt.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return list;
	}
	
	public ArrayList<OrderBean> getOrderAll(){    // 로그인한 고객의 주문 정보
        ArrayList<OrderBean> list = new ArrayList<OrderBean>();

        try {
            conn = ds.getConnection();
            String sql = "select * from orders order by order_no desc";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                OrderBean orderBean = new OrderBean();
                orderBean.setOrder_no(rs.getString("order_no"));
                orderBean.setUser_no(rs.getString("user_no"));
                orderBean.setProduct_no(rs.getString("product_no"));
                orderBean.setOrderquantity(rs.getString("orderquantity"));
                orderBean.setCancelednot(rs.getString("cancelednot"));
                orderBean.setTotalprice(rs.getString("totalprice"));
                orderBean.setOrderdate(rs.getString("orderdate"));
                list.add(orderBean);
            }
        } catch (Exception e) {
            System.out.println("getOrder err: " + e);
        } finally {
            try {
                if(rs != null)pstmt.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (Exception e2) {
                // TODO: handle exception
            }
        }
        return list;
    }
	
	public pack.orderguest.OrderBean getOrderDetail(String order_no) {	// 주문 상품 낱개 읽기
		pack.orderguest.OrderBean bean = null;
		try {
			conn = ds.getConnection();
			String sql = "select * from orders where order_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean = new OrderBean();
				bean.setOrder_no(rs.getString("order_no"));
				bean.setUser_no(rs.getString("user_no"));
				bean.setProduct_no(rs.getString("product_no"));
				bean.setOrderquantity(rs.getString("orderquantity"));
				bean.setCancelednot(rs.getString("cancelednot"));
				bean.setTotalprice(rs.getString("totalprice"));
				bean.setOrderdate(rs.getString("orderdate"));
			}
		} catch (Exception e) {
			System.out.println("getOrderDetail err: " + e);
		} finally {
			try {
				if(rs != null)pstmt.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return bean;
	}
	
}
