package service.impl;

import dao.CategoryDAO;
import dao.impl.CategoryDAOImpl;
import model.Category;
import service.CategoryService;
import java.util.List;

/**
 * Category Service Implementation
 * Triển khai Service cho danh mục
 */
public class CategoryServiceImpl implements CategoryService {
    
    private CategoryDAO categoryDAO;
    
    public CategoryServiceImpl() {
        this.categoryDAO = new CategoryDAOImpl();
    }
    
    @Override
    public Category getCategoryById(int catId) {
        return categoryDAO.getCategoryById(catId);
    }
    
    @Override
    public List<Category> getAllCategories() {
        return categoryDAO.getAllCategories();
    }
    
    @Override
    public boolean createCategory(Category category) {
        return categoryDAO.createCategory(category);
    }
    
    @Override
    public boolean updateCategory(Category category) {
        return categoryDAO.updateCategory(category);
    }
    
    @Override
    public boolean deleteCategory(int catId) {
        return categoryDAO.deleteCategory(catId);
    }
}

