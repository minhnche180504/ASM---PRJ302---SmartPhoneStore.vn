package model;

/**
 * Class đại diện cho một item trong giỏ hàng
 * Bao gồm sản phẩm và số lượng
 * 
 * @author SmartPhone Store Team
 * @version 1.0
 */
public class CartItem {
    private Product product;  // Sản phẩm
    private int quantity;      // Số lượng
    
    /**
     * Constructor mặc định
     */
    public CartItem() {
        this.quantity = 1;  // Mặc định số lượng là 1
    }
    
    /**
     * Constructor với product
     * @param product Sản phẩm
     */
    public CartItem(Product product) {
        this.product = product;
        this.quantity = 1;
    }
    
    /**
     * Constructor đầy đủ
     * @param product Sản phẩm
     * @param quantity Số lượng
     */
    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }
    
    // Getters and Setters
    public Product getProduct() {
        return product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        // Đảm bảo số lượng luôn >= 1
        this.quantity = quantity > 0 ? quantity : 1;
    }
    
    /**
     * Tăng số lượng lên 1
     */
    public void incrementQuantity() {
        this.quantity++;
    }
    
    /**
     * Giảm số lượng đi 1 (tối thiểu là 1)
     */
    public void decrementQuantity() {
        if (this.quantity > 1) {
            this.quantity--;
        }
    }
    
    /**
     * Tính tổng giá cho item này (giá x số lượng)
     * @return Tổng giá
     */
    public double getSubtotal() {
        return product.getPrice() * quantity;
    }
    
    @Override
    public String toString() {
        return "CartItem{" +
                "product=" + (product != null ? product.getName() : "null") +
                ", quantity=" + quantity +
                ", subtotal=" + getSubtotal() +
                '}';
    }
}

