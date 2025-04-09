package pack.mybatis;

import java.util.List;
import pack.delivery.DeliveryBean;

public interface DeliveryMapper {
    List<DeliveryBean> selectAll();
    DeliveryBean selectOne(int ordernumber);
    List<DeliveryBean> selectByUser(int user_no);
    int updateStatus(DeliveryBean bean);
    List<DeliveryBean> selectMyDelivery(int user_no);
}
