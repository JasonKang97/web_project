package pack.mybatis;

import java.util.List;
import pack.order.OrderDto;

public interface OrderMapper {
    List<OrderDto> getAllOrders();
    OrderDto selectOrderByNo(int order_no);
    int insertOrder(OrderDto dto);
    int updateCanceledNot(OrderDto dto);
    int deleteOrder(int order_no);
}
