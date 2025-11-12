package service;

import model.Product;
import java.math.BigDecimal;
import java.util.List;

/**
 * Product Service Interface
 * Giao diện Service cho sản phẩm
 */
public interface ProductService {
    Product getProductById(int pId);
    List<Product> getAllProducts();
    List<Product> getProductsByCategory(int catId);
    List<Product> getProductsByBrand(String brand);
    List<Product> searchProducts(String keyword);
    List<Product> getProductsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice);
    List<Product> getBestSellers(int limit);
    boolean createProduct(Product product);
    boolean updateProduct(Product product);
    boolean deleteProduct(int pId);
}

