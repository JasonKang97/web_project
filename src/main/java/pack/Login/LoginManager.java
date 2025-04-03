package pack.Login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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
	
	// 동이름으로 우편자료 검색
//	public ArrayList<ZipcodeDto> zipcodeRead(String dongName){
//		System.out.println(dongName);
//		ArrayList<ZipcodeDto> list = new ArrayList<ZipcodeDto>();
//		
//		try {
//			conn = ds.getConnection();
//			String sql = "select * from ziptab where area3 like ?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, dongName + "%");
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()) {
//				ZipcodeDto zipcodeDto = new ZipcodeDto();
//				zipcodeDto.setZipcode(rs.getString("zipcode"));
//				zipcodeDto.setArea1(rs.getString("area1"));
//				zipcodeDto.setArea2(rs.getString("area2"));
//				zipcodeDto.setArea3(rs.getString("area3"));
//				zipcodeDto.setArea4(rs.getString("area4"));
//				list.add(zipcodeDto);
//			}
//		} catch (Exception e) {
//			System.out.println("zipcodeRead err : " + e.getMessage());
//		} finally {
//			try {
//				if(rs != null) rs.close();
//				if(pstmt != null) pstmt.close();
//				if(conn != null) conn.close();
//			} catch (Exception e2) {
//				// TODO: handle exception
//			}
//		}
//		return list;
//	}
	
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

	
	public boolean loginCheck(String id, String passwd) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "select * from member where id=? and passwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();
			b = rs.next();
		} catch (Exception e) {
			System.out.println("loginCheck err : " + e.getMessage());
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
	
//	public AdminDto getMember(String id) {
//		AdminDto memberDto = null;
//		
//		try {
//			conn = ds.getConnection();
//			String sql = "select * from member where id=?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, id);
//			rs = pstmt.executeQuery();
//			if(rs.next()) {
//				memberDto = new AdminDto();
//				memberDto.setId(rs.getString("id"));
//				memberDto.setPasswd(rs.getString("passwd"));
//				memberDto.setName(rs.getString("name"));
//				memberDto.setEmail(rs.getString("email"));
//				memberDto.setPhone(rs.getString("phone"));
//				memberDto.setZipcode(rs.getString("zipcode"));
//				memberDto.setAddress(rs.getString("address"));
//				memberDto.setJob(rs.getString("job"));
//			}
//		} catch (Exception e) {
//			System.out.println("getMember err : " + e.getMessage());
//		} finally {
//			try {
//				if(rs != null) rs.close();
//				if(pstmt != null) pstmt.close();
//				if(conn != null) conn.close();
//			} catch (Exception e2) {
//				// TODO: handle exception
//			}
//		}
//		return memberDto;
//	}
	
//	public boolean memberUpdate(AdminBean bean, String id) {
//		boolean b = false;
//		try {
//			conn = ds.getConnection();
//			String sql = "update member set passwd=?,name=?,email=?,phone=?,zipcode=?,address=?,job=? where id=?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, bean.getPasswd());
//			pstmt.setString(2, bean.getName());
//			pstmt.setString(3, bean.getEmail());
//			pstmt.setString(4, bean.getPhone());
//			pstmt.setString(5, bean.getZipcode());
//			pstmt.setString(6, bean.getAddress());
//			pstmt.setString(7, bean.getJob());
//			pstmt.setString(8, id);
//			
//			if(pstmt.executeUpdate() > 0) b = true;
//		} catch (Exception e) {
//			System.out.println("memberUpdate err : " + e.getMessage());
//		} finally {
//			try {
//				if(rs != null) rs.close();
//				if(pstmt != null) pstmt.close();
//				if(conn != null) conn.close();
//			} catch (Exception e2) {
//				// TODO: handle exception
//			}
//		}
//		return b;
//	}
	
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
	
	// 관리자 : 전체 고객 읽기
	
//	public ArrayList<AdminDto> getMemberAll() {
//		ArrayList<AdminDto> list = new ArrayList<AdminDto>();
//		
//		try {
//			conn = ds.getConnection();
//			String sql = "select * from member order by id  asc";
//			pstmt = conn.prepareStatement(sql);
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				AdminDto dto = new AdminDto();
//				dto.setId(rs.getString("id"));
//				dto.setName(rs.getString("name"));
//				dto.setEmail(rs.getString("email"));
//				dto.setPhone(rs.getString("phone"));
//				list.add(dto);
//				
//			}
//			
//		} catch (Exception e) {
//			System.out.println("겟멤버올 err : " + e.getMessage());
//		}try {
//			if(rs != null) rs.close();
//			if(pstmt != null) pstmt.close();
//			if(conn != null) conn.close();
//		} catch (Exception e2) {
//			// TODO: handle exception
//		}
//		return list;
//
//	}
	
}
