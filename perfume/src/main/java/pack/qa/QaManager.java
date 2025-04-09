package pack.qa;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class QaManager {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private DataSource ds;

    private int recTot;
    private int pageList = 5;
    private int pageTot;

    // 생성자: DBCP(DataSource)를 통해 DB 연결 설정
    public QaManager() {
        try {
            Context context = new InitialContext();
            ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
        } catch (Exception e) {
            System.out.println("드라이버 로딩 실패 : " + e);
        }
    }

    // 전체 게시글 수 반환
    public int getTotalCount() {
        return recTot;
    }

    // DB에서 전체 게시글 수를 조회하여 recTot에 저장
    public void totalList() {
        String sql = "SELECT COUNT(*) FROM qa";
        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            rs.next();
            recTot = rs.getInt(1);
        } catch (Exception e) {
            System.out.println("totalList err " + e);
        }
    }

    // 총 페이지 수 계산하여 반환
    public int getPageSu() {
        pageTot = recTot / pageList;
        if (recTot % pageList > 0) {
            pageTot++;
        }
        return pageTot;
    }

    // 특정 페이지의 게시글 목록을 검색 조건과 함께 조회
    public ArrayList<QaDto> getDataAll(int page, String searchType, String searchWord) {
        ArrayList<QaDto> list = new ArrayList<>();
        String sql = "SELECT * FROM qa";

        try {
            conn = ds.getConnection();

            if (searchWord == null || searchWord.trim().isEmpty()) {
                sql += " ORDER BY publish_no DESC";
                pstmt = conn.prepareStatement(sql);
            } else {
                sql += " WHERE " + searchType + " LIKE ? ORDER BY publish_no DESC";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, "%" + searchWord + "%");
            }

            rs = pstmt.executeQuery();

            for (int i = 0; i < (page - 1) * pageList; i++) {
                if (!rs.next()) break;
            }

            int k = 0;
            while (rs.next() && k < pageList) {
                QaDto dto = new QaDto();
                dto.setPublish_no(rs.getInt("publish_no"));
                dto.setWriter(rs.getString("writer"));
                dto.setPostpassword(rs.getString("postpassword"));
                dto.setTitle(rs.getString("title"));
                dto.setPostcontent(rs.getString("postcontent"));
                dto.setPostcreatedate(rs.getString("postcreatedate"));
                dto.setSecretYN(rs.getInt("secretYN"));
                dto.setAdminid(rs.getString("adminid"));
                dto.setReplycontent(rs.getString("replycontent"));
                dto.setReplyday(rs.getString("replyday"));
                dto.setQaimagelink(rs.getString("qaimagelink")); // 추가
                list.add(dto);
                k++;
            }
        } catch (Exception e) {
            System.out.println("getDataAll err : " + e);
        } finally {
            closeResource();
        }
        return list;
    }

    // 게시글 저장 (INSERT)
    public void saveData(QaBean bean) {
        String sql = "INSERT INTO qa (writer, postpassword, title, postcontent, "
        			+ "postcreatedate, secretYN, adminid, replycontent, replyday, qaimagelink) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, bean.getWriter());
            pstmt.setString(2, bean.getPostpassword());
            pstmt.setString(3, bean.getTitle());
            pstmt.setString(4, bean.getPostcontent());
            pstmt.setString(5, bean.getPostcreatedate());
            pstmt.setInt(6, bean.getSecretYN());
            pstmt.setString(7, bean.getAdminid());
            pstmt.setString(8, bean.getReplycontent());
            pstmt.setString(9, bean.getReplyday());
            pstmt.setString(10, bean.getQaimagelink()); // ✅ 이미지 파일명 추가

            pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("saveData err : " + e.getMessage());
        }
    }

    // 특정 게시글 번호로 게시글 조회 (상세보기용)
    public QaDto getData(String publishNo) {
        String sql = "SELECT * FROM qa WHERE publish_no=?";
        QaDto dto = null;

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, publishNo);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    dto = new QaDto();
                    dto.setPublish_no(rs.getInt("publish_no"));
                    dto.setWriter(rs.getString("writer"));
                    dto.setPostpassword(rs.getString("postpassword"));
                    dto.setTitle(rs.getString("title"));
                    dto.setPostcontent(rs.getString("postcontent"));
                    dto.setPostcreatedate(rs.getString("postcreatedate"));
                    dto.setSecretYN(rs.getInt("secretYN"));
                    dto.setAdminid(rs.getString("adminid"));
                    dto.setReplycontent(rs.getString("replycontent"));
                    dto.setReplyday(rs.getString("replyday"));
                    dto.setQaimagelink(rs.getString("qaimagelink")); // 추가
                }
            }
        } catch (Exception e) {
            System.out.println("getData err : " + e.getMessage());
        }
        return dto;
    }

    // 비밀번호 확인 (비교 후 일치 여부 반환)
    public boolean checkPassword(int publishNo, String newPass) {
        boolean b = false;
        String sql = "SELECT postpassword FROM qa WHERE publish_no=?";
        System.out.println("checkPassword nepass : " + newPass);
        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, publishNo);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (newPass.equals(rs.getString("postpassword"))) {
                    b = true;
                }
            }
        } catch (Exception e) {
            System.out.println("checkPassword err : " + e);
        } finally {
            closeResource();
        }
        return b;
    }

    // 게시글 수정 처리
    public void saveEdit(QaBean bean) {
        String sql = "UPDATE qa SET writer=?, postpassword=?, title=?, postcontent=?, postcreatedate=?, secretYN=?, qaimagelink=? WHERE publish_no=?";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, bean.getWriter());
            pstmt.setString(2, bean.getPostpassword());
            pstmt.setString(3, bean.getTitle());
            pstmt.setString(4, bean.getPostcontent());
            pstmt.setString(5, bean.getPostcreatedate());
            pstmt.setInt(6, bean.getSecretYN());
            pstmt.setString(7, bean.getQaimagelink()); // 추가
            pstmt.setInt(8, bean.getPublish_no());

            pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("saveEdit err : " + e);
        } finally {
            closeResource();
        }
    }

    // 게시글 삭제 처리
    public void delData(String publishNo) {
        String sql = "DELETE FROM qa WHERE publish_no=?";
        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, publishNo);
            pstmt.executeUpdate();
        } catch (Exception e) {
        } finally {
            closeResource();
        }
    }

    // DB 연결 리소스 해제
    private void closeResource() {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e2) {
        }
    }

    // 관리자 답변만 따로 저장 (답변 등록용)
    public void saveReplyOnly(QaBean bean) {
        String sql = "UPDATE qa SET replycontent=?, replyday=?, adminid=? WHERE publish_no=?";
        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, bean.getReplycontent());
            pstmt.setString(2, bean.getReplyday());
            pstmt.setString(3, bean.getAdminid());
            pstmt.setInt(4, bean.getPublish_no());

            pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("saveReplyOnly err : " + e.getMessage());
        }
    }

    // 전체 게시글 수 반환 (getter)
    public int getRecTot() {
        return recTot;
    }

    // 작성자 이름을 마스킹 처리 (예: 홍길동 → 홍*동)
    public String maskName(String name) {
        if (name == null || name.trim().length() < 2) return name;
        if (name.length() == 2) return name.substring(0, 1) + "*";
        return name.charAt(0) + "*" + name.substring(name.length() - 1);
    }
}
