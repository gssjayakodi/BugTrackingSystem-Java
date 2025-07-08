import dao.BugDAO;
import dao.DeveloperDAO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Bug;
import model.Developer;

@WebServlet("/viewBugs")
public class ViewBugsServlet extends HttpServlet {

    private Object search;
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bug_tracker_db", "root", "");

            BugDAO bugDAO = new BugDAO(conn);
            DeveloperDAO developerDAO = new DeveloperDAO(conn);

            String search = request.getParameter("search");
            String priority = request.getParameter("priority");
            String status = request.getParameter("status");
            String assignee = request.getParameter("assignee");

            List<Bug> bugs;

            if ((search == null || search.trim().isEmpty()) &&
                (priority == null || priority.equals("All")) &&
                (status == null || status.equals("All")) &&
                (assignee == null || assignee.equals("All"))) {

                bugs = bugDAO.getAllBugs();
            } else {
                bugs = bugDAO.searchBugs(search, priority, status, assignee);
            }

            List<Developer> developers = developerDAO.getAllDevelopers();

            // Set attributes for JSP
            request.setAttribute("bugs", bugs);
            request.setAttribute("developers", developers);

            request.setAttribute("searchKeyword", search);
            request.setAttribute("filterPriority", priority);
            request.setAttribute("filterStatus", status);
            request.setAttribute("filterAssignee", assignee);

            RequestDispatcher rd = request.getRequestDispatcher("viewBugs.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
    e.printStackTrace();
    response.setContentType("text/plain");
    response.getWriter().println("Error loading bug list: " + e.getMessage());
}
 finally {
            if (conn != null) {
                try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
    }
}

