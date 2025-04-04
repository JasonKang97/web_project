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
}
