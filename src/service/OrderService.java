package service;

import model.Order;
import java.util.List;

/**
 * Order Service Interface
 * Giao diện Service cho đơn hàng
 */
public interface OrderService {
    Order getOrderById(int orderId);
    List<Order> getAllOrders();
    List<Order> getOrdersByUserId(int userId);
    List<Order> getOrdersByStatus(String status);
    boolean createOrder(Order order);
    boolean updateOrder(Order order);
    boolean updateOrderStatus(int orderId, String status);
    boolean deleteOrder(int orderId);
}

