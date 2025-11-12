package service.impl;

import dao.OrderDAO;
import dao.OrderItemDAO;
import dao.ProductDAO;
import dao.impl.OrderDAOImpl;
import dao.impl.OrderItemDAOImpl;
import dao.impl.ProductDAOImpl;
import model.Order;
import model.OrderItem;
import service.OrderService;
import java.util.List;

/**
 * Order Service Implementation
 * Triển khai Service cho đơn hàng
 */
public class OrderServiceImpl implements OrderService {
    
    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;
    private ProductDAO productDAO;
    
    public OrderServiceImpl() {
        this.orderDAO = new OrderDAOImpl();
        this.orderItemDAO = new OrderItemDAOImpl();
        this.productDAO = new ProductDAOImpl();
    }
    
    @Override
    public Order getOrderById(int orderId) {
        Order order = orderDAO.getOrderById(orderId);
        if (order != null) {
            order.setOrderItems(orderItemDAO.getOrderItemsByOrderId(orderId));
        }
        return order;
    }
    
    @Override
    public List<Order> getAllOrders() {
        List<Order> orders = orderDAO.getAllOrders();
        for (Order order : orders) {
            order.setOrderItems(orderItemDAO.getOrderItemsByOrderId(order.getOrderId()));
        }
        return orders;
    }
    
    @Override
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = orderDAO.getOrdersByUserId(userId);
        for (Order order : orders) {
            order.setOrderItems(orderItemDAO.getOrderItemsByOrderId(order.getOrderId()));
        }
        return orders;
    }
    
    @Override
    public List<Order> getOrdersByStatus(String status) {
        List<Order> orders = orderDAO.getOrdersByStatus(status);
        for (Order order : orders) {
            order.setOrderItems(orderItemDAO.getOrderItemsByOrderId(order.getOrderId()));
        }
        return orders;
    }
    
    @Override
    public boolean createOrder(Order order) {
        if (orderDAO.createOrder(order)) {
            // Create order items and update stock
            if (order.getOrderItems() != null) {
                for (OrderItem item : order.getOrderItems()) {
                    item.setOrderId(order.getOrderId());
                    orderItemDAO.createOrderItem(item);
                    // Update product stock
                    productDAO.updateStock(item.getProductId(), item.getQuantity());
                }
            }
            return true;
        }
        return false;
    }
    
    @Override
    public boolean updateOrder(Order order) {
        return orderDAO.updateOrder(order);
    }
    
    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        return orderDAO.updateOrderStatus(orderId, status);
    }
    
    @Override
    public boolean deleteOrder(int orderId) {
        return orderDAO.deleteOrder(orderId);
    }
}

