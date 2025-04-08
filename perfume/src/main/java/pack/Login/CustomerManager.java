package pack.Login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CustomerManager {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public CustomerManager() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("LoginManager Driver 로딩 실패 : " + e.getMessage());
		}
	}
	
	
	// 관리자 : 전체 고객 읽기
	public ArrayList<CusLoginDto> getCustomerAll() {
		ArrayList<CusLoginDto> list = new ArrayList<CusLoginDto>();
		
		try {
			conn = ds.getConnection();
			String sql = "select * from customer order by user_no asc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CusLoginDto dto = new CusLoginDto();
				dto.setUsername(rs.getString("username"));
				dto.setEmail(rs.getString("email")); 
				dto.setGender(rs.getString("gender"));
				dto.setPhonenumber(rs.getString("Phonenumber"));
				dto.setAddress(rs.getString("address"));
				dto.setDetailaddress(rs.getString("detailaddress"));
				
				list.add(dto);
				
			}
			
		} catch (Exception e) {
			System.out.println("겟멤버올 err : " + e.getMessage());
		}try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		} catch (Exception e2) {
			// TODO: handle exception
		}
		return list;

	}
	
	// 고객 정보 검색시 사용
	public ArrayList<CusLoginDto> getCustomerPart(String customsearch) {
	    ArrayList<CusLoginDto> list = new ArrayList<>();

	    try {
	        conn = ds.getConnection();
	        String sql = "SELECT * FROM customer WHERE username LIKE ? OR email LIKE ? OR phonenumber LIKE ?";
	        pstmt = conn.prepareStatement(sql);
	        String pattern = "%" + customsearch + "%";
	        pstmt.setString(1, pattern);
	        pstmt.setString(2, pattern);
	        pstmt.setString(3, pattern);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            CusLoginDto dto = new CusLoginDto();
	            dto.setUser_no(rs.getString("user_no"));
	            dto.setUsername(rs.getString("username"));
	            dto.setUserpassword(rs.getString("userpassword"));
	            dto.setGender(rs.getString("gender"));
	            dto.setEmail(rs.getString("email"));
	            dto.setAddress(rs.getString("address"));
	            dto.setDetailaddress(rs.getString("detailaddress"));
	            dto.setPhonenumber(rs.getString("phonenumber"));
	            dto.setCreatedate(rs.getString("createdate"));
	            dto.setBirthdate(rs.getString("birthdate"));
	            dto.setMembershiptype(rs.getString("membershiptype"));
	            list.add(dto);
	        }
	    } catch (Exception e) {
	        System.out.println("getCustomerPart err: " + e.getMessage());
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) {
	            // 예외 무시
	        }
	    }

	    return list;
	}

	//관리자가 고객정보 수정 클릭시 발생 이벤트
	public CusLoginDto getCustomerByEmail(String email) {
	    CusLoginDto dto = null;
	    try {
	        conn = ds.getConnection();
	        String sql = "SELECT * FROM customer WHERE email = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, email);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            dto = new CusLoginDto();
	            dto.setUser_no(rs.getString("user_no"));
	            dto.setUsername(rs.getString("username"));
	            dto.setUserpassword(rs.getString("userpassword"));
	            dto.setGender(rs.getString("gender"));
	            dto.setEmail(rs.getString("email"));
	            dto.setAddress(rs.getString("address"));
	            dto.setDetailaddress(rs.getString("detailaddress"));
	            dto.setPhonenumber(rs.getString("phonenumber"));
	            dto.setCreatedate(rs.getString("createdate"));
	            dto.setBirthdate(rs.getString("birthdate"));
	            dto.setMembershiptype(rs.getString("membershiptype"));
	        }
	    } catch (Exception e) {
	        System.out.println("getCustomerByEmail err: " + e.getMessage());
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) {}
	    }
	    return dto;
	}

	
	// 관리자가 고객 정보 수정
	public boolean customerUpdateByEmail(CusLoginBean bean, String email) {
	    boolean b = false;

	    try {
	        conn = ds.getConnection();
	        String sql = "UPDATE customer SET username=?, userpassword=?, gender=?, address=?, detailaddress=?, phonenumber=?, birthdate=?, membershiptype=? WHERE email=?";
	        pstmt = conn.prepareStatement(sql);

	        pstmt.setString(1, bean.getUsername());
	        pstmt.setString(2, bean.getUserpassword());
	        pstmt.setString(3, bean.getGender());
	        pstmt.setString(4, bean.getAddress());
	        pstmt.setString(5, bean.getDetailaddress());
	        pstmt.setString(6, bean.getPhonenumber());
	        pstmt.setString(7, bean.getBirthdate());
	        pstmt.setString(8, bean.getMembershiptype());
	        pstmt.setString(9, email); 

	        if (pstmt.executeUpdate() > 0) b = true;

	    } catch (Exception e) {
	        System.out.println("customerUpdateByEmail err : " + e.getMessage());
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) {}
	    }

	    return b;
	}
	
	public CusLoginDto getCustomerByUserNo(int userNo) {
	    CusLoginDto dto = null;
	    try {
	        conn = ds.getConnection();
	        String sql = "SELECT * FROM customer WHERE user_no = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, userNo);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            dto = new CusLoginDto();
	            dto.setUser_no(rs.getString("user_no"));
	            dto.setUsername(rs.getString("username"));
	            dto.setUserpassword(rs.getString("userpassword"));
	            dto.setGender(rs.getString("gender"));
	            dto.setEmail(rs.getString("email"));
	            dto.setAddress(rs.getString("address"));
	            dto.setDetailaddress(rs.getString("detailaddress"));
	            dto.setPhonenumber(rs.getString("phonenumber"));
	            dto.setCreatedate(rs.getString("createdate"));
	            dto.setBirthdate(rs.getString("birthdate"));
	            dto.setMembershiptype(rs.getString("membershiptype"));
	        }
	    } catch (Exception e) {
	        System.out.println("getCustomerByUserNo err : " + e.getMessage());
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) { }
	    }
	    return dto;
	}


	
}
