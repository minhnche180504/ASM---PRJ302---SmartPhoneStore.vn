package dao;

import model.Category;
import java.util.List;

/**
 * Category DAO Interface
 * Giao diện DAO cho danh mục
 */
public interface CategoryDAO {
    Category getCategoryById(int catId);
    Category getCategoryByName(String catName);
    List<Category> getAllCategories();
    boolean createCategory(Category category);
    boolean updateCategory(Category category);
    boolean deleteCategory(int catId);
}

