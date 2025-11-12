package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Product Model Class
 * Lớp Model cho sản phẩm
 */
public class Product {
    private int pId;
    private String pName;
    private String brand;
    private BigDecimal price;
    private int stock;
    private String description;
    private String imageUrl;
    private int catId;
    private String catName; // For display
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Constructors
    public Product() {
    }
    
    public Product(String pName, String brand, BigDecimal price, int stock, String description, String imageUrl, int catId) {
        this.pName = pName;
        this.brand = brand;
        this.price = price;
        this.stock = stock;
        this.description = description;
        this.imageUrl = imageUrl;
        this.catId = catId;
    }
    
    // Getters and Setters
    public int getPId() {
        return pId;
    }
    
    public void setPId(int pId) {
        this.pId = pId;
    }
    
    public String getPName() {
        return pName;
    }
    
    public void setPName(String pName) {
        this.pName = pName;
    }
    
    public String getBrand() {
        return brand;
    }
    
    public void setBrand(String brand) {
        this.brand = brand;
    }
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public int getStock() {
        return stock;
    }
    
    public void setStock(int stock) {
        this.stock = stock;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public int getCatId() {
        return catId;
    }
    
    public void setCatId(int catId) {
        this.catId = catId;
    }
    
    public String getCatName() {
        return catName;
    }
    
    public void setCatName(String catName) {
        this.catName = catName;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public boolean isInStock() {
        return stock > 0;
    }
}

