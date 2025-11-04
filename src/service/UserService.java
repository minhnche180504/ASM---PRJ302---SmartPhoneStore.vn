package service;

import model.User;
import java.util.List;

/**
 * User Service Interface
 * Giao diện Service cho người dùng
 */
public interface UserService {
    User getUserById(int userId);
    User getUserByEmail(String email);
    User getUserByUsername(String username); // Get user by username
    List<User> getAllUsers();
    boolean registerUser(User user);
    boolean updateUser(User user);
    boolean deleteUser(int userId);
    User login(String email, String password); // Login using email/username
}

