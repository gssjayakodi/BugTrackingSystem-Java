
<%@ page import="java.util.List" %>
<%@ page import="model.Developer" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Report New Bug - BugTracker Pro</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        /* Same styles as your dashboard, plus form-specific styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

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
            margin-bottom: 30px;
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

        .bug-form {
        max-width: 700px;
        margin: 0 auto 40px;
        background: #fff;
        padding: 30px 35px;
        border-radius: 12px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #222;
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

    .bug-form label {
        display: block;
        font-weight: 600;
        margin-bottom: 8px;
        color: #002244;
    }

    .required {
        color: #e74c3c;
    }

    input[type="text"],
    select,
    textarea {
        width: 100%;
        padding: 10px 12px;
        font-size: 14px;
        border: 1.8px solid #ccc;
        border-radius: 6px;
        font-family: inherit;
        resize: vertical;
        transition: border-color 0.3s;
        box-sizing: border-box;
    }

    input[type="text"]:focus,
    select:focus,
    textarea:focus {
        outline: none;
        border-color: #0055aa;
        box-shadow: 0 0 6px rgba(0, 85, 170, 0.4);
    }

    textarea {
        min-height: 80px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-row {
        display: flex;
        gap: 20px;
        flex-wrap: wrap;
        margin-bottom: 20px;
    }

    .form-row .half {
        flex: 1 1 45%;
        min-width: 250px;
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

    @media (max-width: 600px) {
        .form-row {
            flex-direction: column;
        }

        .form-row .half {
            min-width: 100%;
        }
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
        <a href="dashboard" > <!-- Remove class active from dashboard here -->
            <i class="fas fa-tachometer-alt"></i>
            Dashboard
        </a>
        <a href="ReportBugsServlet" class="active"> <!-- active on Report Bug -->
            <i class="fas fa-plus-circle"></i>
            Report Bug
        </a>
        <a href="viewBugs.jsp">
            <i class="fas fa-list"></i>
            View Bugs
        </a>
        <a href="manage.jsp">
            <i class="fas fa-cog"></i>
            Manage
        </a>
    </div>

    <!-- Bug Report Form -->
    <form action="ReportBugServlet" method="post" class="bug-form">
    <h2><i class="fas fa-file-alt"></i> Report New Bug</h2>

    <div class="form-group">
        <label for="title">Bug Title <span class="required">*</span></label>
        <input type="text" id="title" name="title" placeholder="Enter a clear, descriptive title" required>
    </div>

    <div class="form-row">
        <div class="form-group half">
            <label for="priority">Priority <span class="required">*</span></label>
            <select id="priority" name="priority" required>
                <option value="" disabled selected>Select Priority</option>
                <option value="Low">Low</option>
                <option value="Medium">Medium</option>
                <option value="High">High</option>
                <option value="Critical">Critical</option>
            </select>
        </div>

        <div class="form-group half">
            <label for="severity">Severity</label>
            <select id="severity" name="severity">
                <option value="" disabled selected>Select Severity</option>
                <option value="Minor">Minor</option>
                <option value="Major">Major</option>
                <option value="Critical">Critical</option>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label for="description">Description <span class="required">*</span></label>
        <textarea id="description" name="description" placeholder="Provide a detailed description of the bug" required></textarea>
    </div>

    <div class="form-group">
        <label for="steps">Steps to Reproduce <span class="required">*</span></label>
        <textarea id="steps" name="steps" placeholder="1. Go to...&#10;2. Click on...&#10;3. Observe..." required></textarea>
    </div>

    <div class="form-row">
        <div class="form-group half">
            <label for="expected">Expected Result</label>
            <textarea id="expected" name="expected" placeholder="What should happen?"></textarea>
        </div>

        <div class="form-group half">
            <label for="actual">Actual Result</label>
            <textarea id="actual" name="actual" placeholder="What actually happened?"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label for="environment">Environment</label>
        <input type="text" id="environment" name="environment" placeholder="Browser, OS, Device">
    </div>

    <div class="form-group">
        <label for="developer">Assign to Developer <span class="required">*</span></label>
        <select id="developer" name="developer" required>
            <option value="" disabled selected>Select Developer</option>
            <% 
                List<Developer> developers = (List<Developer>) request.getAttribute("developers");
                if (developers != null && !developers.isEmpty()) {
                    for (Developer dev : developers) { 
            %>
                <option value="<%= dev.getId() %>"><%= dev.getName() %> (<%= dev.getEmail() %>)</option>
            <% 
                    } 
                } else { 
            %>
                <option disabled>No developers available</option>
            <% } %>
        </select>
    </div>

    <button type="submit" class="submit-btn"><i class="fas fa-paper-plane"></i> Submit Bug Report</button>
</form>

</body>
</html>
