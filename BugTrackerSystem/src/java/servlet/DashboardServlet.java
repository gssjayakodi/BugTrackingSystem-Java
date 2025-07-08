package servlet;

import dao.BugDAO;
import model.Bug;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("✅ DashboardServlet triggered");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bug_tracker_db", "root", "");
            System.out.println("✅ Database connected");

            BugDAO bugDAO = new BugDAO(conn);

            // Fetch counts individually for debugging and then calculate total
            int openCount = bugDAO.countBugsByStatus("Open");
            int inProgressCount = bugDAO.countBugsByStatus("In Progress");
            int resolvedCount = bugDAO.countBugsByStatus("Resolved");
            int newCount = bugDAO.countBugsByStatus("New");
            int closedCount = bugDAO.countBugsByStatus("Closed");

            int totalBugs = newCount + openCount + inProgressCount + resolvedCount + closedCount;

            System.out.println("Bug counts -> Total: " + totalBugs +
                               ", New: " + newCount +
                               ", Open: " + openCount +
                               ", In Progress: " + inProgressCount +
                               ", Resolved: " + resolvedCount +
                               ", Closed: " + closedCount);

            request.setAttribute("totalBugs", totalBugs);
            request.setAttribute("openBugs", openCount);
            request.setAttribute("inProgressBugs", inProgressCount);
            request.setAttribute("resolvedBugs", resolvedCount);

            List<Bug> recentBugs = bugDAO.getRecentBugs(5);
            System.out.println("Recent bugs fetched: " + recentBugs.size());

            request.setAttribute("recentBugs", recentBugs);

            conn.close();

            RequestDispatcher rd = request.getRequestDispatcher("dashboard.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("❌ Error in servlet: " + e.getMessage());
        }
    }
}
