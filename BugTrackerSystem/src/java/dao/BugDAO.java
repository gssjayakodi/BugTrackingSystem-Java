package dao;

import model.Bug;

import java.sql.*;
import java.util.*;

public class BugDAO {
    private Connection conn;

    public BugDAO(Connection conn) {
        this.conn = conn;
    }

    public int countBugsByStatus(String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM bugs WHERE status = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }

    public List<Bug> getRecentBugs(int limit) throws SQLException {
        List<Bug> bugs = new ArrayList<>();
        String sql = "SELECT b.*, d.name AS assigned_to_name " +
                     "FROM bugs b LEFT JOIN developers d ON b.assigned_to = d.id " +
                     "ORDER BY b.created_at DESC LIMIT ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, limit);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Bug bug = extractBug(rs);
            bugs.add(bug);
        }
        return bugs;
    }

    public List<Bug> getAllBugs() throws SQLException {
        List<Bug> bugs = new ArrayList<>();
        String sql = "SELECT b.*, d.name AS assigned_to_name " +
                     "FROM bugs b LEFT JOIN developers d ON b.assigned_to = d.id " +
                     "ORDER BY b.created_at DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Bug bug = extractBug(rs);
            bugs.add(bug);
        }
        return bugs;
    }

    public List<Bug> searchBugs(String searchKeyword, String filterPriority, String filterStatus, String filterAssignee) throws SQLException {
        List<Bug> bugs = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT b.*, d.name AS assigned_to_name ")
           .append("FROM bugs b LEFT JOIN developers d ON b.assigned_to = d.id WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append(" AND (b.title LIKE ? OR b.id = ?)");
            params.add("%" + searchKeyword.trim() + "%");
            try {
                params.add(Integer.parseInt(searchKeyword.trim()));
            } catch (NumberFormatException e) {
                params.add(-1);
            }
        }

        if (filterPriority != null && !filterPriority.equals("All")) {
            sql.append(" AND b.priority = ?");
            params.add(filterPriority);
        }

        if (filterStatus != null && !filterStatus.equals("All")) {
            sql.append(" AND b.status = ?");
            params.add(filterStatus);
        }

        if (filterAssignee != null && !filterAssignee.equals("All")) {
            sql.append(" AND d.name = ?");
            params.add(filterAssignee);
        }

        sql.append(" ORDER BY b.created_at DESC");

        PreparedStatement ps = conn.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Bug bug = extractBug(rs);
            bugs.add(bug);
        }
        return bugs;
    }

    public Bug getBugById(int id) throws SQLException {
        String sql = "SELECT b.*, d.name AS assigned_to_name " +
                     "FROM bugs b LEFT JOIN developers d ON b.assigned_to = d.id WHERE b.id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return extractBug(rs);
        }
        return null;
    }

    public void updateBug(int id, String title, String description, String steps, String expected,
                          String actual, String environment, String priority, String severity, String assignedTo) throws SQLException {
        String sql = "UPDATE bugs SET title = ?, description = ?, steps = ?, expected = ?, actual = ?, " +
                     "environment = ?, priority = ?, severity = ?, assigned_to = ? WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, title);
        ps.setString(2, description);
        ps.setString(3, steps);
        ps.setString(4, expected);
        ps.setString(5, actual);
        ps.setString(6, environment);
        ps.setString(7, priority);
        ps.setString(8, severity);
        ps.setString(9, assignedTo);
        ps.setInt(10, id);
        ps.executeUpdate();
    }

    public void updateBugStatus(int id, String status) throws SQLException {
        String sql = "UPDATE bugs SET status = ? WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, id);
        ps.executeUpdate();
    }

    // ✅ Common method to reduce redundancy
    private Bug extractBug(ResultSet rs) throws SQLException {
        Bug bug = new Bug();
        bug.setId(rs.getInt("id"));
        bug.setTitle(rs.getString("title"));
        bug.setDescription(rs.getString("description"));
        bug.setSteps(rs.getString("steps"));
        bug.setExpected(rs.getString("expected"));
        bug.setActual(rs.getString("actual"));
        bug.setEnvironment(rs.getString("environment"));
        bug.setPriority(rs.getString("priority"));
        bug.setSeverity(rs.getString("severity"));
        bug.setStatus(rs.getString("status"));
        bug.setReporter(rs.getString("reporter"));
        bug.setAssignedTo(rs.getString("assigned_to"));
        bug.setAssignedToName(rs.getString("assigned_to_name"));
        bug.setCreatedAt(rs.getTimestamp("created_at"));
        return bug;
    }
}
