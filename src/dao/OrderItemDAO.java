package dao;

import model.OrderItem;
import java.util.List;

/**
 * Order Item DAO Interface
 * Giao diện DAO cho chi tiết đơn hàng
 */
public interface OrderItemDAO {
    List<OrderItem> getOrderItemsByOrderId(int orderId);
    boolean createOrderItem(OrderItem orderItem);
    boolean deleteOrderItemsByOrderId(int orderId);
}

