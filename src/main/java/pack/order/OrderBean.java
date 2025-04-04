package pack.order;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class OrderBean {
    private int order_no;
    private int user_no;
    private int product_no;
    private int order_quantity;
    private int total_price;
    private String canceled_not;
    private Date order_date;
}