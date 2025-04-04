package pack.stock;

import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;
import java.util.Date;

@Getter
@Setter
public class StockBean {
    private int stock_no, product_no,product_quantity;
    private String product_name;
    private Timestamp create_date, lastmodified_date;
}
