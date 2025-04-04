package pack.order;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class OrderDto {
    private int order_no;
    private int user_no;
    private int product_no;
    private int order_quantity;
    private int total_price;
    private String canceled_not;
    private Date order_date;

    // 조인 결과용
    private String user_name;        // 고객명
    private String product_name;     // 상품명
    private int product_price;       // 상품 가격
}