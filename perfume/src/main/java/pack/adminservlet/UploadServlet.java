package pack.adminservlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import pack.product.ProductDto;
import pack.product.ProductFormBean;
import pack.product.ProductManager;

@WebServlet("/product/upload")
@MultipartConfig(
	fileSizeThreshold = 1024*1024*5, // 메모리 임계값
	maxFileSize = 1024*1024*50,  //최대 파일 사이즈
	maxRequestSize = 1024*1024*60 //최대 요청 사이즈
)

public class UploadServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //업로드될 실제 경로 얻어내기
        String uploadPath = null;
        uploadPath = getServletContext().getRealPath("/upload");
        File uploadDir = new File(uploadPath);
        //만일 upload 폴더가 존재 하지 않으면
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); //실제로 폴더 만들기
        }

        // input type="text"에 입력한 문자열 얻어내기
        String productname = req.getParameter("productname");
        String productbrand = req.getParameter("productbrand");
        String topnote = req.getParameter("topnote");
        String middlenote = req.getParameter("middlenote");
        String basenote = req.getParameter("basenote");
        String majorcustomer = req.getParameter("majorcustomer");
        String releasedate = req.getParameter("releasedate");
        String productprice = req.getParameter("productprice");
        String otherdescription = req.getParameter("otherdescription");

        // 이미지 파일명이 겹치지 않게 저장하기 위한 랜덤한 문자열 얻어내기
        // 무작위로 고유한 UUID를 생성. .toString()을 붙이면 UUID 객체를 String으로 변환
        String uid = UUID.randomUUID().toString();

        String orgFileName = null;
        String saveFileName = null;

        // 이미지 파일 데이터 처리
        Part filePart = req.getPart("imagelink");
        if (filePart != null && filePart.getSize() > 0) {
            // 원본 파일의 이름 얻어내기
            orgFileName = filePart.getSubmittedFileName();
            // 저장될 파일의 이름 구성하기
            saveFileName = uid + orgFileName;
            // 저장할 파일의 경로 구성하기
            String filePath = uploadPath + File.separator + saveFileName;

            // 업로드된 파일은 임시 폴더에 임시 파일로 저장이 된다.
            // 해당 파일에서 byte data를 읽어 들일 수 있는 InputStream 객체를 생성해서
            InputStream is = filePart.getInputStream();
            // 원하는 목적지에 copy를 해야 한다
            Files.copy(is, Paths.get(filePath));
        } else {
            saveFileName = null;    // 이미지 없는 상품
        }
        // 이제 image 필드에 saveFileName을 저장하면 된다.

        // 파일의 크기 얻어내기 (큰 정수이기 때문에 long type 이다)
        // long fileSize = filePart.getSize();

        //DB에 저장
        ProductFormBean bean = new ProductFormBean();
        bean.setProductname(productname);
        bean.setProductbrand(productbrand);
        bean.setTopnote(topnote);
        bean.setMiddlenote(middlenote);
        bean.setBasenote(basenote);
        bean.setMajorcustomer(majorcustomer);
        bean.setReleasedate(releasedate);
        bean.setProductprice(productprice);
        bean.setOtherdescription(otherdescription);
        bean.setImagelink(saveFileName);    // null도 허용됨

        ProductManager manager = new ProductManager();
        boolean success = manager.insertProduct(bean);

        if (success) {
            System.out.println("상품이 등록되었습니다.");
        } else {
            System.out.println("상품 등록 중 에러가 발생하였습니다");
        }

        resp.sendRedirect("/perfume/admin_orderlist/productmanager.jsp");
    }
}
