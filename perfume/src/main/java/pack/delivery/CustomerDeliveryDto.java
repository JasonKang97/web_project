package pack.delivery;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class CustomerDeliveryDto {
    private int order_no;              // 주문번호
    private String product_name;       // 상품명
    private int product_no;
    private int order_quantity;        // 주문 수량
    private Date order_date;           // 주문 날짜
    private int deliverystatus;        // 배송 상태 (1~4)
    private String trackingnumber;     // 송장번호
    private String shpaddress;         // 주소
    private String shpdetailaddress;   // 상세주소
}
