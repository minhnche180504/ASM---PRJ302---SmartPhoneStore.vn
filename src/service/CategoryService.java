package service;

import model.Category;
import java.util.List;

/**
 * Category Service Interface
 * Giao diện Service cho danh mục
 */
public interface CategoryService {
    Category getCategoryById(int catId);
    List<Category> getAllCategories();
    boolean createCategory(Category category);
    boolean updateCategory(Category category);
    boolean deleteCategory(int catId);
}

