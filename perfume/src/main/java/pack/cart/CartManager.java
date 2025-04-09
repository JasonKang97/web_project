package pack.cart;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CartManager {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private DataSource ds;

    public CartManager(){
        try {
            Context context = new InitialContext();
            ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
        } catch (Exception e) {
            System.out.println("Product Manager Driver 로딩 실패 : " + e.getMessage());
        }
    }

    public ArrayList<CartDto> getCartsByCustomer(int customer_no) {
        ArrayList<CartDto> list = new ArrayList<>();

        try {
            conn = ds.getConnection();
            String sql = "SELECT username, productname, product.product_no, quantity, quantity*productprice as tot FROM cart";
            sql += " JOIN customer ON cart.user_no=customer.user_no";
            sql += " JOIN product ON cart.product_no=product.product_no";
            sql += " WHERE customer.user_no=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, customer_no);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CartDto dto = new CartDto();
                dto.setUsername(rs.getString("username"));
                dto.setProduct_name(rs.getString("productname"));
                dto.setProduct_no(rs.getInt("product.product_no"));
                dto.setQuantity(rs.getInt("quantity"));
                dto.setTotal_price(rs.getInt("tot"));

                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("getAllCarts err : " + e);
        } finally {
            try {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (Exception e2) {
                System.out.println("closing err : " + e2);
            }
        }
        return list;
    }
    
    public boolean changeCart(int user_no, int product_no, int quantity) {
    	boolean b = false;
    	try {
			conn = ds.getConnection();
			String sql = "select * from cart where user_no=? and product_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_no);
			pstmt.setInt(2, product_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				try {
					conn = ds.getConnection();
					String sql1 = "update cart set quantity = quantity+? where user_no=? and product_no=?";
					pstmt = conn.prepareStatement(sql1);
					pstmt.setInt(1, quantity);
					pstmt.setInt(2, user_no);
					pstmt.setInt(3, product_no);
					if(pstmt.executeUpdate()>0) b=true;
				} catch (Exception e) {
					System.out.println("updateCart err: " + e);
				} finally {
					try {
						if(rs != null) rs.close();
						if(pstmt != null) pstmt.close();
						if(conn != null) conn.close();
					} catch (Exception e2) {
						// TODO: handle exception
					}
				}
			}else {
		    	try {
					conn = ds.getConnection();
					String sql2 = "INSERT INTO cart VALUES(?,?,?)";
					pstmt = conn.prepareStatement(sql2);
					pstmt.setInt(1, user_no);
					pstmt.setInt(2, product_no);
					pstmt.setInt(3, quantity);
					if(pstmt.executeUpdate()>0) b=true;
				} catch (Exception e) {
					System.out.println("insertCart err: " + e);
				} finally {
					try {
						if(rs != null) rs.close();
						if(pstmt != null) pstmt.close();
						if(conn != null) conn.close();
					} catch (Exception e2) {
						// TODO: handle exception
					}
				}
			}
		} catch (Exception e) {
			System.out.println("insertCart err: " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return b;

    }
    
    public boolean deleteAll(int user_no) {
        boolean success = false;
        try {
            conn = ds.getConnection();
            String sql = "DELETE FROM cart WHERE user_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, user_no);
            success = pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("deleteAll err : " + e);
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                System.out.println("deleteAll close err : " + e2);
            }
        }
        return success;
    }
}
