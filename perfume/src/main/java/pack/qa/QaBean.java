package pack.qa;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class QaBean {
	  // 문자열 타입 컬럼들을 한 줄로 선언
    private String writer, postpassword, title, postcontent,
                   postcreatedate, adminid, replycontent, replyday, qaimagelink;

    // 숫자(또는 tinyint 등) 타입 컬럼들을 한 줄로 선언
    private int publish_no, secretYN;
    
    public void setPostcreatedate() { // 연도 계산 오버로딩
        LocalDate now = LocalDate.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        this.postcreatedate = year + "-" + month + "-" + day;
    }

}