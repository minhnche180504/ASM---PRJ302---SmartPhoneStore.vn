package model;

import java.sql.Timestamp;

/**
 * Category Model Class
 * Lớp Model cho danh mục sản phẩm
 */
public class Category {
    private int catId;
    private String catName;
    private String description;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Constructors
    public Category() {
    }
    
    public Category(String catName, String description) {
        this.catName = catName;
        this.description = description;
    }
    
    // Getters and Setters
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
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
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
}

