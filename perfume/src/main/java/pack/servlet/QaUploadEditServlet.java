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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import pack.qa.QaBean;
import pack.qa.QaManager;

@WebServlet("/qa/QaUploadEditServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 5,
    maxFileSize = 1024 * 1024 * 50,
    maxRequestSize = 1024 * 1024 * 60
)
public class QaUploadEditServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // 업로드 경로 (UpdateServlet과 동일한 실제 경로로 고정)
        String uploadPath = getServletContext().getRealPath("/upload");

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // 폴더 없으면 생성
        }

        // 파라미터 수신
        String no = req.getParameter("no");
        String writer = req.getParameter("writer");
        String postpassword = req.getParameter("postpassword");
        String title = req.getParameter("title");
        String postcontent = req.getParameter("postcontent");
        String currentImage = req.getParameter("currentImage");
        int secretYN = req.getParameter("secretYN") == null ? 0 : 1;

        String uid = UUID.randomUUID().toString();
        String orgFileName = null;
        String saveFileName = null;

        // 이미지 처리
        Part filePart = req.getPart("qaimagelink");
        if (filePart != null && filePart.getSize() > 0) {
            orgFileName = filePart.getSubmittedFileName();
            saveFileName = uid + orgFileName;
            String filePath = uploadPath + File.separator + saveFileName;

            try (InputStream is = filePart.getInputStream()) {
                Files.copy(is, Paths.get(filePath));
            }

            // 기존 이미지 삭제
            if (currentImage != null && !currentImage.isEmpty()) {
                File oldFile = new File(uploadPath + File.separator + currentImage);
                if (oldFile.exists()) oldFile.delete();
            }
        } else {
            saveFileName = currentImage; // 새 이미지 없으면 기존 이미지 유지
        }

        System.out.println(saveFileName);

        // DTO 저장
        QaBean bean = new QaBean();
        bean.setPublish_no(Integer.parseInt(no));
        bean.setWriter(writer);
        bean.setPostpassword(postpassword);
        bean.setTitle(title);
        bean.setPostcontent(postcontent);
        bean.setSecretYN(secretYN);
        bean.setPostcreatedate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        bean.setQaimagelink(saveFileName); // 이미지 파일명 저장

        // DB 저장
        QaManager manager = new QaManager();
        manager.saveEdit(bean);

        resp.sendRedirect("qa_detail.jsp?no=" + no);
    }
}