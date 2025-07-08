package servlet;

import dao.BugDAO;
import dao.DeveloperDAO;
import model.Bug;
import model.Developer;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/EditBugServlet")
public class EditBugServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bugId = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bug_tracker_db", "root", "");

            BugDAO bugDAO = new BugDAO(conn);
            DeveloperDAO developerDAO = new DeveloperDAO(conn);

            Bug bug = bugDAO.getBugById(bugId);
            List<Developer> developers = developerDAO.getAllDevelopers();

            request.setAttribute("bug", bug);
            request.setAttribute("developers", developers);

            conn.close();

            RequestDispatcher rd = request.getRequestDispatcher("edit_bug.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Failed to load bug.");
        }
    }
}
