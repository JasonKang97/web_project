package pack.qa;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QaDto {
    // 문자열 타입 컬럼들을 한 줄로 선언
    private String writer, postpassword, title, postcontent,
                   postcreatedate, adminid, replycontent, replyday, qaimagelink;

    // 숫자(또는 tinyint 등) 타입 컬럼들을 한 줄로 선언
    private int publish_no, secretYN;

}