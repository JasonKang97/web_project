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
	private int orderquantity;
	private int totalprice;
	private String cancelednot;
	private Date orderdate;

	// 조인 결과용
	private String user_name;      // customer.username
	private String productname;    // product.productname
	private int productprice;      // product.productprice
}