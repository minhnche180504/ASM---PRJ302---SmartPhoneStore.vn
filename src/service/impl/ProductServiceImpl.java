package service.impl;

import dao.ProductDAO;
import dao.impl.ProductDAOImpl;
import model.Product;
import service.ProductService;
import java.math.BigDecimal;
import java.util.List;

/**
 * Product Service Implementation
 * Triển khai Service cho sản phẩm
 */
public class ProductServiceImpl implements ProductService {
    
    private ProductDAO productDAO;
    
    public ProductServiceImpl() {
        this.productDAO = new ProductDAOImpl();
    }
    
    @Override
    public Product getProductById(int pId) {
        return productDAO.getProductById(pId);
    }
    
    @Override
    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }
    
    @Override
    public List<Product> getProductsByCategory(int catId) {
        return productDAO.getProductsByCategory(catId);
    }
    
    @Override
    public List<Product> getProductsByBrand(String brand) {
        return productDAO.getProductsByBrand(brand);
    }
    
    @Override
    public List<Product> searchProducts(String keyword) {
        return productDAO.searchProducts(keyword);
    }
    
    @Override
    public List<Product> getProductsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice) {
        return productDAO.getProductsByPriceRange(minPrice, maxPrice);
    }
    
    @Override
    public List<Product> getBestSellers(int limit) {
        return productDAO.getBestSellers(limit);
    }
    
    @Override
    public boolean createProduct(Product product) {
        return productDAO.createProduct(product);
    }
    
    @Override
    public boolean updateProduct(Product product) {
        return productDAO.updateProduct(product);
    }
    
    @Override
    public boolean deleteProduct(int pId) {
        return productDAO.deleteProduct(pId);
    }
}

