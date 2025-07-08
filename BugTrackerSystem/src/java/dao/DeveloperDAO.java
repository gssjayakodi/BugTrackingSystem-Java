package dao;

import java.sql.*;
import java.util.*;
import model.Developer;

public class DeveloperDAO {
    private Connection conn;

    public DeveloperDAO(Connection conn) {
        this.conn = conn;
    }

   public List<Developer> getAllDevelopers() throws SQLException {
    List<Developer> developers = new ArrayList<>();
    String sql = "SELECT id, name, email FROM developers";

    try (PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            Developer dev = new Developer();
            dev.setId(rs.getInt("id"));
            dev.setName(rs.getString("name"));
            dev.setEmail(rs.getString("email"));
            developers.add(dev);
        }
    }
    return developers;
}

}
