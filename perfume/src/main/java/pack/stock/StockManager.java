package pack.stock;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class StockManager {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private DataSource ds;

    public StockManager() {
        try {
            Context context = new InitialContext();
            ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
        } catch (Exception e) {
            System.out.println("Stock Manager Driver 로딩 실패 : " + e.getMessage());
        }
    }

    public ArrayList<StockDto> getStockAll() {
        ArrayList<StockDto> list = new ArrayList<>();

        try {
            conn = ds.getConnection();
            String sql = "SELECT stock_no, productnum, productname, productquantity, createdate, lastmodifieddate FROM stock JOIN product ON product_no=productnum";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                StockDto stockDto = new StockDto();
                stockDto.setStock_no(rs.getInt("stock_no"));
                stockDto.setProduct_no(rs.getInt("productnum"));
                stockDto.setProduct_name(rs.getString("productname"));
                stockDto.setProduct_quantity(rs.getInt("productquantity"));
                stockDto.setCreate_date(rs.getTimestamp("createdate"));
                stockDto.setLastmodified_date(rs.getTimestamp("lastmodifieddate"));
                list.add(stockDto);
            }
        } catch (Exception e) {
            System.out.println("getStock err : " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                System.out.println("closing err : " + e2);
            }
        }
        return list;
    }

    public ArrayList<StockDto> getStockPart(String keyword) {
        ArrayList<StockDto> list = new ArrayList<>();

        try {
            conn = ds.getConnection();
            String sql = "SELECT stock_no, productnum, productname, productquantity, createdate, lastmodifieddate FROM stock JOIN product ON product_no=productnum";
            sql += " where productname like ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%"); // 일부 검색 가능하게 설정
            rs = pstmt.executeQuery();

            while (rs.next()) {
                StockDto dto = new StockDto();
                dto.setStock_no(rs.getInt("stock_no"));
                dto.setProduct_no(rs.getInt("productnum"));
                dto.setProduct_name(rs.getString("productname"));
                dto.setProduct_quantity(rs.getInt("productquantity"));
                dto.setCreate_date(rs.getTimestamp("createdate"));
                dto.setLastmodified_date(rs.getTimestamp("lastmodifieddate"));
                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("getStock err : " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                System.out.println("closing err : " + e2);
            }
        }

        return list;
    }

    public StockDto getStockByNo(int stockNo) {
        StockDto dto = null;

        try {
            conn = ds.getConnection();
            String sql = "SELECT stock_no, productnum, productname, productquantity, createdate, lastmodifieddate" +
                    " FROM stock JOIN product ON product_no = productnum WHERE stock_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, stockNo);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new StockDto();
                dto.setStock_no(rs.getInt("stock_no"));
                dto.setProduct_no(rs.getInt("productnum"));
                dto.setProduct_name(rs.getString("productname"));
                dto.setProduct_quantity(rs.getInt("productquantity"));
                dto.setCreate_date(rs.getTimestamp("createdate"));
                dto.setLastmodified_date(rs.getTimestamp("lastmodifieddate"));
            }
        } catch (Exception e) {
            System.out.println("getStockByNo err : " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                System.out.println("closing err : " + e2);
            }
        }

        return dto;
    }

    public boolean updateStockQuantity(int stockNo, int quantity) {
        boolean result = false;

        try {
            conn = ds.getConnection();
            String sql = "UPDATE stock SET productquantity = ?, lastmodifieddate = NOW() WHERE stock_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, quantity);
            pstmt.setInt(2, stockNo);
            result = pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("updateStockQuantity err : " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                System.out.println("closing err : " + e2);
            }
        }

        return result;
    }

    public boolean insertStock(int product_no) {
        boolean result = false;

        try {
            conn = ds.getConnection();
            String sql = "insert into stock(productnum, productquantity, createdate, lastmodifieddate)"
            		+ " values(?,0,now(),now())";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, product_no);
            result = pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("updateStockQuantity err : " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                System.out.println("closing err : " + e2);
            }
        }

        return result;
    }

}
