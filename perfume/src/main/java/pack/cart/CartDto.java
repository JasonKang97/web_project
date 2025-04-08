package pack.cart;

import lombok.Data;

@Data
public class CartDto {
    private String username, product_name;
    private int product_no, quantity, total_price;
}
