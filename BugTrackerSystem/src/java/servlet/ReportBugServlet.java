package servlet;

import model.Developer;
import dao.DeveloperDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/ReportBugServlet")
public class ReportBugServlet extends HttpServlet {

    // Handle GET request: show the bug report form with developer list
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bug_tracker_db", "root", "");

            DeveloperDAO devDAO = new DeveloperDAO(conn);
            List<Developer> developers = devDAO.getAllDevelopers();
            request.setAttribute("developers", developers);

            conn.close();

            RequestDispatcher rd = request.getRequestDispatcher("report_bug.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error loading developers");
        }
    }

    // Handle POST request: submit the bug report
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

 String title = request.getParameter("title");
String description = request.getParameter("description");
String priority = request.getParameter("priority");
String severity = request.getParameter("severity");
String steps = request.getParameter("steps");
String expected = request.getParameter("expected");
String actual = request.getParameter("actual");
String environment = request.getParameter("environment");
int assignedTo = Integer.parseInt(request.getParameter("developer")); // developer ID
String reporter = "Anonymous"; // Or get from session if available

// Insert using BugDAO or your DB connection with parameters as above


    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bug_tracker_db", "root", "");

        String sql = "INSERT INTO bugs (title, description, steps, expected, actual, environment, " +
                     "priority, severity, status, reporter, assigned_to) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'New', ?, ?)";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, title);
        ps.setString(2, description);
        ps.setString(3, steps);
        ps.setString(4, expected);
        ps.setString(5, actual);
        ps.setString(6, environment);
        ps.setString(7, priority);
        ps.setString(8, severity);
        ps.setString(9, reporter);
        ps.setInt(10, assignedTo);

        ps.executeUpdate();
        conn.close();

        response.sendRedirect("dashboard"); // Or success.jsp
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().println("Error while reporting bug.");
    }
}


}
