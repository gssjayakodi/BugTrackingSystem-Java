<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage - BugTracker Pro</title>
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
            color: #fff;
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

        .manage-container {
            max-width: 900px;
            margin: 0 auto;
        }

        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 28px;
            margin-bottom: 40px;
        }

        .card {
            background: #fff;
            padding: 25px 30px;
            border-radius: 14px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.07);
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: default;
        }

        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 28px rgba(0,0,0,0.12);
        }

        .card .icon {
            font-size: 36px;
            margin-bottom: 15px;
            color: #0055aa;
        }

        .card h3 {
            font-size: 20px;
            color: #003366;
            margin-bottom: 12px;
            font-weight: 700;
        }

        .card p {
            font-size: 15px;
            color: #444;
            margin-bottom: 18px;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            background: #003366;
            color: white;
            font-weight: 600;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            text-decoration: none;
            font-size: 15px;
            transition: background 0.3s;
        }

        .btn:hover {
            background: #0055aa;
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
            <h1><i class="fas fa-cog"></i> Manage <span>BugTracker</span></h1>
            <p>Admin & System Controls</p>
        </div>
    </div>

    <!-- Navigation -->
    <div class="nav">
        <a href="dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="ReportBugServlet"><i class="fas fa-plus-circle"></i> Report Bug</a>
        <a href="viewBugs.jsp"><i class="fas fa-list"></i> View Bugs</a>
        <a href="manage.jsp" class="active"><i class="fas fa-cog"></i> Manage</a>
    </div>

    <!-- Manage Content -->
    <div class="manage-container">

        <div class="cards-grid">


            <div class="card">
                <div class="icon"><i class="fas fa-file-export"></i></div>
                <h3>Export Reports</h3>
                <p>Export bug data as CSV or PDF for offline analysis.</p>
                <button class="btn" disabled>Export Data (Coming Soon)</button>
            </div>

            <div class="card">
                <div class="icon"><i class="fas fa-users-cog"></i></div>
                <h3>Manage Users</h3>
                <p>Add, remove or modify users and assign roles.</p>
                <button class="btn" disabled>Manage Users (Coming Soon)</button>
            </div>

            <!-- ✅ Logout Card -->
            <div class="card">
                <div class="icon"><i class="fas fa-sign-out-alt"></i></div>
                <h3>Logout</h3>
                <p>Sign out of your current session safely.</p>
                <a href="LogoutServlet" class="btn">Logout</a>
            </div>

        </div>

    </div>

</body>
</html>
