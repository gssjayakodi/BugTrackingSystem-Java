package servlet;

import dao.BugDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/updateStatus")
public class UpdateStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bugId = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bug_tracker_db", "root", "");

            BugDAO bugDAO = new BugDAO(conn);
            bugDAO.updateBugStatus(bugId, status);

            conn.close();

            response.sendRedirect("viewBugs");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error updating status.");
        }
    }
}
