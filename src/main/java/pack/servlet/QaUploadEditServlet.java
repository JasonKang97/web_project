package pack.servlet;

import java.io.*;
import java.nio.file.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

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

        String no = req.getParameter("no");
        String currentImage = req.getParameter("currentImage");
        String writer = req.getParameter("writer");
        String postpassword = req.getParameter("postpassword");
        String title = req.getParameter("title");
        String postcontent = req.getParameter("postcontent");
        int secretYN = req.getParameter("secretYN") == null ? 0 : 1;

        String uploadPath = getServletContext().getRealPath("/upload");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // 이미지 처리
        Part filePart = req.getPart("qaimagelink");
        String newImageName = null;
        if (filePart != null && filePart.getSize() > 0) {
            String orgFileName = filePart.getSubmittedFileName();
            newImageName = UUID.randomUUID().toString() + orgFileName;
            String filePath = uploadPath + File.separator + newImageName;

            try (InputStream is = filePart.getInputStream()) {
                Files.copy(is, Paths.get(filePath));
            }

            // 기존 이미지 삭제
            if (currentImage != null && !currentImage.isEmpty()) {
                Files.deleteIfExists(Paths.get(uploadPath + File.separator + currentImage));
            }
        } else {
            newImageName = currentImage; // 새 이미지 없으면 기존 이미지 유지
        }

        // DTO에 저장
        QaBean bean = new QaBean();
        bean.setPublish_no(Integer.parseInt(no));
        bean.setWriter(writer);
        bean.setPostpassword(postpassword);
        bean.setTitle(title);
        bean.setPostcontent(postcontent);
        bean.setSecretYN(secretYN);
        bean.setPostcreatedate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        bean.setQaimagelink(newImageName); // 이미지 파일명만 저장

        QaManager manager = new QaManager();
        manager.saveEdit(bean);

        resp.sendRedirect("qa_detail.jsp?no=" + no);
    }
}
