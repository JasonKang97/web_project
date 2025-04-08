package pack.orderguest;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderBean {
	private String order_no, user_no, product_no, orderquantity, cancelednot, totalprice, orderdate;
}
