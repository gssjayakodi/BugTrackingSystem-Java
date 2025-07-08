package dao;

import model.User;
import java.sql.*;

public class UserDAO {
private final String jdbcURL = "jdbc:mysql://localhost:3306/bug_tracker_db";
private final String jdbcUsername = "root";
private final String jdbcPassword = "";


    public User validateUser(String username, String password) {
        User user = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
    public boolean registerUser(User user) {
    boolean success = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword); // ✅ use class-level

        String sql = "INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);

        stmt.setString(1, user.getUsername());
        stmt.setString(2, user.getPassword()); // Plain text (for now)
        stmt.setString(3, user.getEmail());
        stmt.setString(4, user.getRole());

        int rowsInserted = stmt.executeUpdate();
        success = (rowsInserted > 0);

        stmt.close();
        conn.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return success;
}


}
