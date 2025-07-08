<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Bug" %>
<%@ page import="model.Developer" %>


<%
    List<Bug> bugs = (List<Bug>) request.getAttribute("bugs");
%>

<html>
<head>
    <title>View Bugs - BugTracker Pro</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
            * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #e0f0ff, #f5faff);
            padding: 30px;
            color: #333;
        }

        .header {
    background: linear-gradient(135deg, #003366, #0055aa);
    padding: 60px 30px 40px;
    border-radius: 20px;
    text-align: center;
    color: #ffffff;
    margin-bottom: 40px;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
    position: relative;
    overflow: hidden;
}

.header::after {
    content: "";
    position: absolute;
    bottom: -30px;
    left: 0;
    width: 100%;
    height: 60px;
    background: #f5faff;
    border-top-left-radius: 100% 40px;
    border-top-right-radius: 100% 40px;
    z-index: 1;
}

.header-content {
    position: relative;
    z-index: 2;
}

.header h1 {
    font-size: 42px;
    font-weight: 800;
    margin-bottom: 10px;
    color: #fff;
    letter-spacing: 1px;
}

.header h1 i {
    margin-right: 10px;
    color: #ffcc00;
}

.header h1 span {
    color: #ffcc00;
}

.header p {
    font-size: 18px;
    color: #e0ecff;
    font-weight: 400;
}


        .nav {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 40px;
        }

        .nav a {
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
            color: #003366;
            font-weight: 600;
            transition: background 0.3s, color 0.3s, transform 0.2s;
        }

        .nav a:hover, .nav a.active {
            background: #003366;
            color: white;
            transform: translateY(-2px);
        }

        .filter-form {
            background: white;
            padding: 20px 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
        }

        .filter-form label {
            font-weight: 600;
            color: #003366;
        }

        .filter-form input,
        .filter-form select {
            padding: 8px 10px;
            border-radius: 6px;
            border: 1.5px solid #ccc;
        }

        .filter-form button {
            padding: 10px 16px;
            background: #003366;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 12px 16px;
            border-bottom: 1px solid #eee;
        }

        th {
            background: #003366;
            color: white;
            text-align: left;
        }

        tr:nth-child(even) {
            background: #f5faff;
        }

        .action-btn {
            color: #0055aa;
            text-decoration: none;
            font-weight: 600;
        }

        .action-btn:hover {
            text-decoration: underline;
        }

        select[name="status"] {
            padding: 5px;
            border-radius: 4px;
        }

        @media (max-width: 768px) {
            .nav {
                flex-direction: column;
                align-items: center;
            }

            .filter-form {
                flex-direction: column;
                align-items: stretch;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <div class="header">
    <div class="header-content">
        <h1><i class="fas fa-bug"></i> BugTracker <span>Pro</span></h1>
        <p>Streamlined Bug Reporting & Tracking System</p>
    </div>
</div>


    <!-- Navigation -->
    <div class="nav">
        <a href="dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="ReportBugServlet"><i class="fas fa-plus-circle"></i> Report Bug</a>
        <a href="viewBugsServlet" class="active"><i class="fas fa-list"></i> View Bugs</a>
        <a href="manage.jsp"><i class="fas fa-cog"></i> Manage</a>
    </div>

<!-- Enhanced Filter Form -->
<form method="get" action="viewBugs" class="filter-form">
    <div style="flex: 1;">
        <label for="search">Search</label><br>
        <input type="text" id="search" name="search" value="${searchKeyword != null ? searchKeyword : ''}" placeholder="Search by ID or Title" style="width: 100%;">
    </div>

    <div>
        <label>Priority</label><br>
        <select name="priority">
            <option value="All">All</option>
            <option value="Low" ${filterPriority == 'Low' ? 'selected' : ''}>Low</option>
            <option value="Medium" ${filterPriority == 'Medium' ? 'selected' : ''}>Medium</option>
            <option value="High" ${filterPriority == 'High' ? 'selected' : ''}>High</option>
            <option value="Critical" ${filterPriority == 'Critical' ? 'selected' : ''}>Critical</option>
        </select>
    </div>

    <div>
        <label>Status</label><br>
        <select name="status">
            <option value="All">All</option>
            <option value="New" ${filterStatus == 'New' ? 'selected' : ''}>New</option>
            <option value="Open" ${filterStatus == 'Open' ? 'selected' : ''}>Open</option>
            <option value="In Progress" ${filterStatus == 'In Progress' ? 'selected' : ''}>In Progress</option>
            <option value="Resolved" ${filterStatus == 'Resolved' ? 'selected' : ''}>Resolved</option>
            <option value="Closed" ${filterStatus == 'Closed' ? 'selected' : ''}>Closed</option>
        </select>
    </div>

    <div>
        <label>Assignee</label><br>
        <select name="assignee">
            <option value="All">All</option>
            <%
                List<Developer> developers = (List<Developer>) request.getAttribute("developers");
                String filterAssignee = (String) request.getAttribute("filterAssignee");
                if (developers != null) {
                    for (Developer d : developers) {
            %>
            <option value="<%= d.getName() %>" <%= d.getName().equals(filterAssignee) ? "selected" : "" %>><%= d.getName() %></option>
            <%
                    }
                }
            %>
        </select>
    </div>

    <div style="align-self: flex-end;">
        <button type="submit"><i class="fas fa-spinner"></i> Search</button>
    </div>
</form>

<!-- Enhanced Bug Table -->
<table>
    <thead>
        <tr>
            <th>#ID</th>
            <th>Title</th>
            <th>Priority</th>
            <th>Status</th>
            <th>Assignee</th>
            <th>Created</th>
            <th>Action</th>
        </tr>
    </thead>
<tbody>
<%
    if (bugs != null && !bugs.isEmpty()) {
        for (Bug b : bugs) {
            String priority = b.getPriority();
            String status = b.getStatus();

            // Badge Colors
            String priorityColor = "#cccccc"; // default
            if ("Low".equals(priority)) priorityColor = "#66bb6a";
            else if ("Medium".equals(priority)) priorityColor = "#ffa726";
            else if ("High".equals(priority)) priorityColor = "#ef5350";
            else if ("Critical".equals(priority)) priorityColor = "#d32f2f";

            String statusColor = "#999999"; // default
            if ("New".equals(status)) statusColor = "#607d8b";
            else if ("Open".equals(status)) statusColor = "#42a5f5";
            else if ("In Progress".equals(status)) statusColor = "#ffca28";
            else if ("Resolved".equals(status)) statusColor = "#66bb6a";
            else if ("Closed".equals(status)) statusColor = "#616161";
%>
    <tr>
        <td><%= b.getId() %></td>
        <td><strong><%= b.getTitle() %></strong></td>

        <!-- Priority with color badge -->
        <td>
            <span style="background-color: <%= priorityColor %>; color: #fff; padding: 4px 10px; border-radius: 10px; font-size: 13px; font-weight: 600; display: inline-block;">
                <%= priority != null ? priority : "-" %>
            </span>
        </td>

        <!-- Status with color badge -->
        <td>
            <span style="background-color: <%= statusColor %>; color: #fff; padding: 4px 10px; border-radius: 10px; font-size: 13px; font-weight: 600; display: inline-block;">
                <%= status != null ? status : "-" %>
            </span>
        </td>

        <td><%= b.getAssignedToName() != null ? b.getAssignedToName() : "-" %></td>
        <td><%= b.getCreatedAt() %></td>
        <td>
           
            <a href="EditBugServlet?id=<%= b.getId() %>" class="action-btn"><i class="fas fa-edit"></i> Edit</a>
            <form action="updateStatus" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= b.getId() %>" />
                <select name="status" onchange="this.form.submit()" style="margin-top: 6px;">
                    <option value="New" <%= "New".equals(status) ? "selected" : "" %>>New</option>
                    <option value="Open" <%= "Open".equals(status) ? "selected" : "" %>>Open</option>
                    <option value="In Progress" <%= "In Progress".equals(status) ? "selected" : "" %>>In Progress</option>
                    <option value="Resolved" <%= "Resolved".equals(status) ? "selected" : "" %>>Resolved</option>
                    <option value="Closed" <%= "Closed".equals(status) ? "selected" : "" %>>Closed</option>
                </select>
            </form>
        </td>
    </tr>
<%
        }
    } else {
%>
    <tr>
        <td colspan="7" style="text-align:center; color: gray;">🚫 No bugs found matching your filters.</td>
    </tr>
<% } %>
</tbody>

</table>


</body>
</html>
