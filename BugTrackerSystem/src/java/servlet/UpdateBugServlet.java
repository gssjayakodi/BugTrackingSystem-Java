package servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/UpdateBugServlet")
public class UpdateBugServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bugId = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String priority = request.getParameter("priority");
        String status = request.getParameter("status");
        int assignedTo = Integer.parseInt(request.getParameter("assignedTo"));

        String description = request.getParameter("description");
        String steps = request.getParameter("steps");
        String expected = request.getParameter("expected");
        String actual = request.getParameter("actual");
        String environment = request.getParameter("environment");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bug_tracker_db", "root", "");

            String sql = "UPDATE bugs SET title = ?, description = ?, priority = ?, status = ?, assigned_to = ?, steps = ?, expected = ?, actual = ?, environment = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, priority);
            ps.setString(4, status);
            ps.setInt(5, assignedTo);
            ps.setString(6, steps);
            ps.setString(7, expected);
            ps.setString(8, actual);
            ps.setString(9, environment);
            ps.setInt(10, bugId);

            ps.executeUpdate();
            conn.close();

            response.sendRedirect("viewBugs.jsp"); // redirect to bug list or detail page
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error updating bug.");
        }
    }
}
