package pack.delivery;

import java.sql.Timestamp;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DeliveryBean {
	private int order_no;
	private int usern_no;
	private String trackingnumber;
	private int deliverystatus;
	private Timestamp shippingdate;
	private String shpaddress;
	private String shpdetailaddress;
	private String username;
	private String productname;

}
