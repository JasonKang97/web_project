package pack.Login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class LoginManager {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public LoginManager() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("LoginManager Driver 로딩 실패 : " + e.getMessage());
		}
	}
	
	
	// 이메일 중복 확인
	public boolean isEmailDuplicate(String email) {
	    boolean b = false;
	    
	    try {
	        conn = ds.getConnection();
	        String sql = "SELECT * FROM customer WHERE email = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, email);
	        rs = pstmt.executeQuery();
	        b = rs.next();
	    } catch (Exception e) {
	        System.out.println("isEmailDuplicate err : " + e.getMessage());
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) {
	        	
	        }
	    }
	    
	    return b;
	}

	// 회원가입
	public boolean memberInsert(CusLoginBean cbean) {
	    boolean b = false;

	    try {
	        conn = ds.getConnection();
	        String sql = "INSERT INTO customer(username, userpassword, gender, email, address, detailaddress, phonenumber, createdate, birthdate, membershiptype) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	        pstmt = conn.prepareStatement(sql);

	        pstmt.setString(1, cbean.getUsername());
	        pstmt.setString(2, cbean.getUserpassword());
	        pstmt.setString(3, cbean.getGender());

	        // 이메일 처리: 공백 방지
	        String email = cbean.getEmail();
	        pstmt.setString(4, (email != null && !email.trim().equals("@")) ? email : null);

	        pstmt.setString(5, cbean.getAddress());
	        pstmt.setString(6, cbean.getDetailaddress());
	        pstmt.setString(7, cbean.getPhonenumber());
	        pstmt.setString(8, cbean.getCreatedate());

	        // 생년월일 처리: 공백 또는 빈 값일 경우 null 처리
	        String birth = cbean.getBirthdate();
	        pstmt.setString(9, (birth != null && !birth.trim().isEmpty()) ? birth : null);

	        pstmt.setString(10, cbean.getMembershiptype());

	        if(pstmt.executeUpdate() > 0) b = true;
	    } catch (Exception e) {
	        System.out.println("memberInsert err : " + e.getMessage());
	    } finally {
	        try {
	            if(rs != null) rs.close();
	            if(pstmt != null) pstmt.close();
	            if(conn != null) conn.close();
	        } catch (Exception e2) {
	            // 예외 무시
	        }
	    }

	    return b;
	}

	// 고객로그인 id를 db에서 체크 (이메일)
	public boolean loginCheck(String email, String passwd) {
	    boolean b = false;
	    try {
	        conn = ds.getConnection();
	        String sql = "SELECT * FROM customer WHERE email=? AND userpassword=?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, email);
	        pstmt.setString(2, passwd);
	        rs = pstmt.executeQuery();
	        b = rs.next();
	    } catch (Exception e) {
	        System.out.println("loginCheck err : " + e.getMessage());
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) {}
	    }
	    return b;
	}
	
	// 고객 로그인시 user_no 세션값에 저장.
	public int getUser_no(String email) {
		int userNo = -1;
		try {
			conn = ds.getConnection();
			String sql = "SELECT user_no FROM customer WHERE email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userNo = rs.getInt("user_no");
			}
		} catch (Exception e) {
			System.out.println("getUserNoByEmail err : " + e.getMessage());
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {
				
			}
		}
		return userNo;
	}

	// 관리자 로그인 체크용
	public boolean adminLoginCheck(String adminid, String adminpasswd) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "select * from admin_user where admin_id=? and admin_pwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, adminid);
			pstmt.setString(2, adminpasswd);
			rs = pstmt.executeQuery();
			b = rs.next();
		} catch (Exception e) {
			System.out.println("adminLoginCheck err : " + e.getMessage());
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
	
}
