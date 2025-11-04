package dao;

import model.User;
import java.util.List;

/**
 * User DAO Interface
 * Giao diện DAO cho người dùng
 */
public interface UserDAO {
    User getUserById(int userId);
    User getUserByEmail(String email);
    User getUserByUsername(String username); // Get user by username (stored in email field)
    List<User> getAllUsers();
    boolean createUser(User user);
    boolean updateUser(User user);
    boolean deleteUser(int userId);
    boolean authenticate(String email, String password);
    boolean authenticateByUsername(String username, String password); // Authenticate by username
}

