<%@page import="model.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Bug" %>
<%@ page import="java.util.List" %>
<%
    Integer totalAttr = (Integer) request.getAttribute("totalBugs");
    Integer openAttr = (Integer) request.getAttribute("openBugs");
    Integer inProgressAttr = (Integer) request.getAttribute("inProgressBugs");
    Integer resolvedAttr = (Integer) request.getAttribute("resolvedBugs");

    int total = (totalAttr != null) ? totalAttr : 0;
    int open = (openAttr != null) ? openAttr : 0;
    int inProgress = (inProgressAttr != null) ? inProgressAttr : 0;
    int resolved = (resolvedAttr != null) ? resolvedAttr : 0;

    List<Bug> recentBugs = (List<Bug>) request.getAttribute("recentBugs");
%>

<%-- Session check at the top --%>
<%
    model.User user = (model.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Dashboard - BugTracker Pro</title>
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

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
            padding: 0 20px;
        }
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 25px;
    margin-bottom: 40px;
    padding: 0 20px;
}

.card {
    background: #ffffff;
    padding: 25px 20px;
    border-radius: 14px;
    text-align: center;
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
    transition: transform 0.3s, box-shadow 0.3s;
}

.card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
}

.card .icon {
    font-size: 32px;
    margin-bottom: 10px;
}

.card.total .icon       { color: #3e8ed0; }
.card.open .icon        { color: #e74c3c; }
.card.progress .icon    { color: #f1c40f; }
.card.resolved .icon    { color: #2ecc71; }

.card h3 {
    font-size: 18px;
    color: #003366;
    margin-bottom: 8px;
}

.card p {
    font-size: 28px;
    font-weight: bold;
    color: #222;
}
.recent {
    background: #fff;
    padding: 25px;
    border-radius: 12px;
    max-width: 900px;
    margin: 0 auto 40px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.recent h3 {
    font-size: 22px;
    margin-bottom: 20px;
    color: #003366;
    text-align: center;
}

.bug-list {
    list-style: none;
    padding: 0;
    margin: 0;
}

.bug-item {
    padding: 14px 16px;
    border-bottom: 1px solid #eee;
}

.bug-item:last-child {
    border-bottom: none;
}

.bug-item .title {
    font-size: 16px;
    color: #222;
    margin-bottom: 6px;
}

.bug-item .title i {
    color: #007BFF;
    margin-right: 6px;
}

.bug-item .meta {
    font-size: 13px;
    color: #666;
}

.bug-item .status {
    font-weight: 500;
    color: #333;
}

.bug-item .time {
    color: #888;
}

.bug-item.no-bugs {
    text-align: center;
    font-style: italic;
    color: #888;
}



        @media (max-width: 768px) {
            .nav {
                flex-direction: column;
                align-items: center;
            }

            .nav a {
                width: 200px;
                text-align: center;
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
        <a href="dashboard" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="ReportBugServlet"><i class="fas fa-plus-circle"></i> Report Bug</a>
        <a href="viewBugs.jsp"><i class="fas fa-list"></i> View Bugs</a>
        <a href="manage.jsp"><i class="fas fa-cog"></i> Manage</a>
    </div>

    <!-- Dashboard Stats Grid -->
<div class="stats-grid">
    <div class="card total">
        <div class="icon"><i class="fas fa-bug"></i></div>
        <h3>Total Bugs</h3>
        <p><%= total %></p>
    </div>
    <div class="card open">
        <div class="icon"><i class="fas fa-exclamation-triangle"></i></div>
        <h3>Open</h3>
        <p><%= open %></p>
    </div>
    <div class="card progress">
        <div class="icon"><i class="fas fa-spinner"></i></div>
        <h3>In Progress</h3>
        <p><%= inProgress %></p>
    </div>
    <div class="card resolved">
        <div class="icon"><i class="fas fa-check-circle"></i></div>
        <h3>Resolved</h3>
        <p><%= resolved %></p>
    </div>
</div>


    <!-- Recent Activity -->
<div class="recent">
    <h3><i class="fas fa-clock"></i> Recent Bug Reports</h3>
    <ul class="bug-list">
        <% if (recentBugs != null && !recentBugs.isEmpty()) {
            for (Bug bug : recentBugs) { %>
                <li class="bug-item">
                    <div class="title">
                        <i class="fas fa-bug"></i> <strong><%= bug.getTitle() %></strong>
                    </div>
                    <div class="meta">
                        Reported by <%= bug.getReporter() %> · 
                        <span class="status"><%= bug.getStatus() %></span> · 
                        <span class="time"><%= bug.getCreatedAt() %></span>
                    </div>
                </li>
        <% }
        } else { %>
            <li class="bug-item no-bugs">No recent bugs reported.</li>
        <% } %>
    </ul>
</div>



</body>
</html>
