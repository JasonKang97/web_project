package pack.servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import pack.qa.QaBean;
import pack.qa.QaManager;

@WebServlet("/qa/QaUploadServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 5,
    maxFileSize = 1024 * 1024 * 50,
    maxRequestSize = 1024 * 1024 * 60
)
public class QaUploadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // 실제 업로드 경로 (이클립스 환경에서 톰캣에 배포된 upload 폴더)
        String uploadPath = getServletContext().getRealPath("/upload");

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // 업로드 폴더 없으면 생성
        }

        // 텍스트 파라미터 수집
        String writer = req.getParameter("writer");
        String postpassword = req.getParameter("postpassword");
        String title = req.getParameter("title");
        String postcontent = req.getParameter("postcontent");
        int secretYN = req.getParameter("secretYN") == null ? 0 : 1;

        // 이미지 처리
        Part filePart = req.getPart("qaimagelink");
        String saveFileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            String orgFileName = filePart.getSubmittedFileName();
            saveFileName = UUID.randomUUID().toString() + orgFileName;
            String filePath = uploadPath + File.separator + saveFileName;

            try (InputStream is = filePart.getInputStream()) {
                Files.copy(is, Paths.get(filePath));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // DTO에 데이터 담기
        QaBean bean = new QaBean();
        bean.setWriter(writer);
        bean.setPostpassword(postpassword);
        bean.setTitle(title);
        bean.setPostcontent(postcontent);
        bean.setSecretYN(secretYN);
        bean.setPostcreatedate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        bean.setQaimagelink(saveFileName); // ✅ 이미지 파일명 저장
        

        // DB 저장
        QaManager manager = new QaManager();
        manager.saveData(bean);

        // 작성 후 목록으로 이동
        resp.sendRedirect("qa_list.jsp");
    }
}
