package pack.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class ProductManager {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public ProductManager() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("Driver 로딩 실패: " + e.getMessage());
		}
	}
	
	public ArrayList<ProductDto> getProductAll(){
		ArrayList<ProductDto> list = new ArrayList<ProductDto>();
		try {
			conn = ds.getConnection();
			String sql = "select * from product order by product_no desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setProduct_no(rs.getString("product_no"));
				dto.setProductname(rs.getString("productname"));
				dto.setProductbrand(rs.getString("productbrand"));
				dto.setTopnote(rs.getString("topnote"));
				dto.setMiddlenote(rs.getString("middlenote"));
				dto.setBasenote(rs.getString("basenote"));
				dto.setMajorcustomer(rs.getString("majorcustomer"));
				dto.setReleasedate(rs.getString("releasedate"));
				dto.setProductprice(rs.getString("productprice"));
				dto.setOtherdescription(rs.getString("otherdescription"));
				dto.setImagelink(rs.getString("imagelink"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getProductAll err: " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return list;
	}	
	
	public boolean insertProduct(ProductFormBean bean) {
		boolean b=false;
		try {
			conn = ds.getConnection();
			String sql = "INSERT INTO product (productname, productbrand, topnote, middlenote, "
					+ "basenote, majorcustomer, releasedate, productprice, otherdescription, imagelink) VALUES(?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getProductname());
			pstmt.setString(2, bean.getProductbrand());
			pstmt.setString(3, bean.getTopnote());
			pstmt.setString(4, bean.getMiddlenote());
			pstmt.setString(5, bean.getBasenote());
			pstmt.setString(6, bean.getMajorcustomer());
			pstmt.setString(7, bean.getReleasedate());
			pstmt.setString(8, bean.getProductprice());
			pstmt.setString(9, bean.getOtherdescription());
			pstmt.setString(10, bean.getImagelink());

			int result = pstmt.executeUpdate();
			if(result>0) b=true;
		} catch (Exception e) {
			System.out.println("insertProduct err: " + e);
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
	
	public ProductDto getProduct(String product_no) {
		ProductDto dto = null;
		try {
			conn = ds.getConnection();
			String sql = "select * from product where product_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new ProductDto();
				dto.setProduct_no(rs.getString("product_no"));
				dto.setProductname(rs.getString("productname"));
				dto.setProductbrand(rs.getString("productbrand"));
				dto.setTopnote(rs.getString("topnote"));
				dto.setMiddlenote(rs.getString("middlenote"));
				dto.setBasenote(rs.getString("basenote"));
				dto.setMajorcustomer(rs.getString("majorcustomer"));
				dto.setReleasedate(rs.getString("releasedate"));
				dto.setProductprice(rs.getString("productprice"));
				dto.setOtherdescription(rs.getString("otherdescription"));
				dto.setImagelink(rs.getString("imagelink"));
			}
		} catch (Exception e) {
			System.out.println("getProduct err: " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return dto;
	}
	
	public boolean updateProduct(ProductFormBean bean) {
		boolean b=false;
		try {
			conn = ds.getConnection();
			String sql = "update product set productname=?, productbrand=?, topnote=?, middlenote=?, basenote=?, "
					+ "majorcustomer=?, releasedate=?, productprice=?, otherdescription=?, imagelink=? where product_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getProductname());
			pstmt.setString(2, bean.getProductbrand());
			pstmt.setString(3, bean.getTopnote());
			pstmt.setString(4, bean.getMiddlenote());
			pstmt.setString(5, bean.getBasenote());
			pstmt.setString(6, bean.getMajorcustomer());
			pstmt.setString(7, bean.getReleasedate());
			pstmt.setString(8, bean.getProductprice());
			pstmt.setString(9, bean.getOtherdescription());
			pstmt.setString(10, bean.getImagelink());
			pstmt.setString(11, bean.getProduct_no());

			int result = pstmt.executeUpdate();
			if(result>0) b=true;
			
		} catch (Exception e) {
			System.out.println("updateProduct err: " + e);
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return b;
	}
	
	public boolean deleteProduct(String product_no) {
		boolean b = false;
		try {
			conn = ds.getConnection();
			String sql = "delete from product where product_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_no);
			if(pstmt.executeUpdate()>0) b=true;
			int result = pstmt.executeUpdate();
			if(result>0) b=true;
		} catch (Exception e) {
			System.out.println("updateProduct err: " + e);
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return b;
	}
	
	public ArrayList<ProductDto> getProductNew(){
		ArrayList<ProductDto> list = new ArrayList<ProductDto>();
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM product WHERE releasedate >= '2025-01-01' ORDER BY releasedate DESC;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setProduct_no(rs.getString("product_no"));
				dto.setProductname(rs.getString("productname"));
				dto.setProductbrand(rs.getString("productbrand"));
				dto.setTopnote(rs.getString("topnote"));
				dto.setMiddlenote(rs.getString("middlenote"));
				dto.setBasenote(rs.getString("basenote"));
				dto.setMajorcustomer(rs.getString("majorcustomer"));
				dto.setReleasedate(rs.getString("releasedate"));
				dto.setProductprice(rs.getString("productprice"));
				dto.setOtherdescription(rs.getString("otherdescription"));
				dto.setImagelink(rs.getString("imagelink"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getProductAll err: " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return list;
	}
	
	public ArrayList<ProductDto> getProductMan(){
		ArrayList<ProductDto> list = new ArrayList<ProductDto>();
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM product WHERE majorcustomer='남성' ORDER BY product_no DESC;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setProduct_no(rs.getString("product_no"));
				dto.setProductname(rs.getString("productname"));
				dto.setProductbrand(rs.getString("productbrand"));
				dto.setTopnote(rs.getString("topnote"));
				dto.setMiddlenote(rs.getString("middlenote"));
				dto.setBasenote(rs.getString("basenote"));
				dto.setMajorcustomer(rs.getString("majorcustomer"));
				dto.setReleasedate(rs.getString("releasedate"));
				dto.setProductprice(rs.getString("productprice"));
				dto.setOtherdescription(rs.getString("otherdescription"));
				dto.setImagelink(rs.getString("imagelink"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getProductAll err: " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return list;
	}
	
	public ArrayList<ProductDto> getProductWoman(){
		ArrayList<ProductDto> list = new ArrayList<ProductDto>();
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM product WHERE majorcustomer='여성' ORDER BY product_no DESC;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setProduct_no(rs.getString("product_no"));
				dto.setProductname(rs.getString("productname"));
				dto.setProductbrand(rs.getString("productbrand"));
				dto.setTopnote(rs.getString("topnote"));
				dto.setMiddlenote(rs.getString("middlenote"));
				dto.setBasenote(rs.getString("basenote"));
				dto.setMajorcustomer(rs.getString("majorcustomer"));
				dto.setReleasedate(rs.getString("releasedate"));
				dto.setProductprice(rs.getString("productprice"));
				dto.setOtherdescription(rs.getString("otherdescription"));
				dto.setImagelink(rs.getString("imagelink"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getProductAll err: " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return list;
	}
	
	public ArrayList<ProductDto> getProductTop(){
		ArrayList<ProductDto> list = new ArrayList<ProductDto>();
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM product ORDER BY topnote;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setProduct_no(rs.getString("product_no"));
				dto.setProductname(rs.getString("productname"));
				dto.setProductbrand(rs.getString("productbrand"));
				dto.setTopnote(rs.getString("topnote"));
				dto.setMiddlenote(rs.getString("middlenote"));
				dto.setBasenote(rs.getString("basenote"));
				dto.setMajorcustomer(rs.getString("majorcustomer"));
				dto.setReleasedate(rs.getString("releasedate"));
				dto.setProductprice(rs.getString("productprice"));
				dto.setOtherdescription(rs.getString("otherdescription"));
				dto.setImagelink(rs.getString("imagelink"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getProductAll err: " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return list;
	}
	
	public ArrayList<ProductDto> getProductMiddle(){
		ArrayList<ProductDto> list = new ArrayList<ProductDto>();
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM product ORDER BY middlenote;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setProduct_no(rs.getString("product_no"));
				dto.setProductname(rs.getString("productname"));
				dto.setProductbrand(rs.getString("productbrand"));
				dto.setTopnote(rs.getString("topnote"));
				dto.setMiddlenote(rs.getString("middlenote"));
				dto.setBasenote(rs.getString("basenote"));
				dto.setMajorcustomer(rs.getString("majorcustomer"));
				dto.setReleasedate(rs.getString("releasedate"));
				dto.setProductprice(rs.getString("productprice"));
				dto.setOtherdescription(rs.getString("otherdescription"));
				dto.setImagelink(rs.getString("imagelink"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getProductAll err: " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return list;
	}
	
	public ArrayList<ProductDto> getProductBase(){
		ArrayList<ProductDto> list = new ArrayList<ProductDto>();
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM product ORDER BY basenote;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setProduct_no(rs.getString("product_no"));
				dto.setProductname(rs.getString("productname"));
				dto.setProductbrand(rs.getString("productbrand"));
				dto.setTopnote(rs.getString("topnote"));
				dto.setMiddlenote(rs.getString("middlenote"));
				dto.setBasenote(rs.getString("basenote"));
				dto.setMajorcustomer(rs.getString("majorcustomer"));
				dto.setReleasedate(rs.getString("releasedate"));
				dto.setProductprice(rs.getString("productprice"));
				dto.setOtherdescription(rs.getString("otherdescription"));
				dto.setImagelink(rs.getString("imagelink"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getProductAll err: " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return list;
	}
}
