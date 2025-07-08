<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Bug" %>
<%@ page import="model.Developer" %>
<%@ page import="java.util.List" %>
<%
    Bug bug = (Bug) request.getAttribute("bug");
    List<Developer> developers = (List<Developer>) request.getAttribute("developers");
%>
<html>
<head>
    <title>Edit Bug - BugTracker Pro</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        /* --- Reuse your CSS from report_bug.jsp --- */
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f0f4ff, #d9e4ff);
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

        .header h1 span { color: #ffcc00; }

        .nav {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 30px;
        }

        .nav a {
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.3);
            color: #003366;
            font-weight: 600;
            transition: background 0.3s;
        }

        .nav a:hover, .nav a.active {
            background: #003366;
            color: white;
        }

        .bug-form {
            max-width: 700px;
            margin: 0 auto;
            background: #fff;
            padding: 30px 35px;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        }

        .bug-form h2 {
            font-size: 26px;
            margin-bottom: 30px;
            color: #003366;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-row {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .form-row .half {
            flex: 1 1 45%;
            min-width: 250px;
        }

        label {
            font-weight: 600;
            margin-bottom: 8px;
            display: block;
        }

        input[type="text"],
        select,
        textarea {
            width: 100%;
            padding: 10px 12px;
            font-size: 14px;
            border: 1.8px solid #ccc;
            border-radius: 6px;
            resize: vertical;
        }

        input:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #0055aa;
            box-shadow: 0 0 6px rgba(0, 85, 170, 0.4);
        }

        textarea {
            min-height: 80px;
        }

        .submit-btn {
            width: 100%;
            background-color: #003366;
            color: white;
            border: none;
            padding: 14px 0;
            font-size: 18px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 700;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background-color: #0055aa;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <div class="header">
        <div class="header-content">
            <h1><i class="fas fa-bug"></i> BugTracker <span>Pro</span></h1>
            <p>Update Existing Bug Report</p>
        </div>
    </div>

    <!-- Navigation -->
    <div class="nav">
        <a href="dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="ReportBugsServlet"><i class="fas fa-plus-circle"></i> Report Bug</a>
        <a href="viewBugs.jsp" class="active"><i class="fas fa-list"></i> View Bugs</a>
        <a href="manage.jsp"><i class="fas fa-cog"></i> Manage</a>
    </div>

    <!-- Form -->
    <form action="UpdateBugServlet" method="post" class="bug-form">
        <h2><i class="fas fa-edit"></i> Edit Bug Report</h2>
        <input type="hidden" name="id" value="<%= bug.getId() %>">

        <div class="form-group">
            <label for="title">Bug Title</label>
            <input type="text" id="title" name="title" value="<%= bug.getTitle() %>" required>
        </div>

        <div class="form-row">
            <div class="form-group half">
                <label for="priority">Priority</label>
                <select id="priority" name="priority">
                    <option value="Low" <%= "Low".equals(bug.getPriority()) ? "selected" : "" %>>Low</option>
                    <option value="Medium" <%= "Medium".equals(bug.getPriority()) ? "selected" : "" %>>Medium</option>
                    <option value="High" <%= "High".equals(bug.getPriority()) ? "selected" : "" %>>High</option>
                    <option value="Critical" <%= "Critical".equals(bug.getPriority()) ? "selected" : "" %>>Critical</option>
                </select>
            </div>

            <div class="form-group half">
                <label for="status">Status</label>
                <select id="status" name="status">
                    <option value="New" <%= "New".equals(bug.getStatus()) ? "selected" : "" %>>New</option>
                    <option value="Open" <%= "Open".equals(bug.getStatus()) ? "selected" : "" %>>Open</option>
                    <option value="In Progress" <%= "In Progress".equals(bug.getStatus()) ? "selected" : "" %>>In Progress</option>
                    <option value="Resolved" <%= "Resolved".equals(bug.getStatus()) ? "selected" : "" %>>Resolved</option>
                    <option value="Closed" <%= "Closed".equals(bug.getStatus()) ? "selected" : "" %>>Closed</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <textarea id="description" name="description"><%= bug.getDescription() %></textarea>
        </div>

        <div class="form-group">
            <label for="steps">Steps to Reproduce</label>
            <textarea id="steps" name="steps"><%= bug.getSteps() %></textarea>
        </div>

        <div class="form-row">
            <div class="form-group half">
                <label for="expected">Expected Result</label>
                <textarea id="expected" name="expected"><%= bug.getExpected() %></textarea>
            </div>

            <div class="form-group half">
                <label for="actual">Actual Result</label>
                <textarea id="actual" name="actual"><%= bug.getActual() %></textarea>
            </div>
        </div>

        <div class="form-group">
            <label for="environment">Environment</label>
            <input type="text" id="environment" name="environment" value="<%= bug.getEnvironment() %>">
        </div>

        <div class="form-group">
            <label for="assignedTo">Assign to Developer</label>
            <select id="assignedTo" name="assignedTo">
                <% 
                    for (Developer dev : developers) {
                        boolean isSelected = String.valueOf(dev.getId()).equals(bug.getAssignedTo());
                %>
                    <option value="<%= dev.getId() %>" <%= isSelected ? "selected" : "" %>>
                        <%= dev.getName() %> (<%= dev.getEmail() %>)
                    </option>
                <% } %>
            </select>
        </div>

        <button type="submit" class="submit-btn"><i class="fas fa-save"></i> Update Bug</button>
    </form>

</body>
</html>
