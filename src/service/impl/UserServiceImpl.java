package service.impl;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import model.User;
import service.UserService;
import java.util.List;

/**
 * User Service Implementation
 * Triển khai Service cho người dùng
 */
public class UserServiceImpl implements UserService {
    
    private UserDAO userDAO;
    
    public UserServiceImpl() {
        this.userDAO = new UserDAOImpl();
    }
    
    @Override
    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }
    
    @Override
    public User getUserByEmail(String email) {
        return userDAO.getUserByEmail(email);
    }
    
    @Override
    public User getUserByUsername(String username) {
        return userDAO.getUserByUsername(username);
    }
    
    @Override
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }
    
    @Override
    public boolean registerUser(User user) {
        // Check if email/username already exists
        if (userDAO.getUserByEmail(user.getEmail()) != null) {
            return false;
        }
        return userDAO.createUser(user);
    }
    
    @Override
    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }
    
    @Override
    public boolean deleteUser(int userId) {
        return userDAO.deleteUser(userId);
    }
    
    @Override
    public User login(String email, String password) {
        if (userDAO.authenticate(email, password)) {
            return userDAO.getUserByEmail(email);
        }
        return null;
    }
}

