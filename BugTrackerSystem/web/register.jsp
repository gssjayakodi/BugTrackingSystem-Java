<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Register - BugTracker Pro</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    html, body {
      height: 100%;
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, rgba(224, 240, 255, 0.9), rgba(245, 250, 255, 0.9)),
                  url("images/bg.jpg") no-repeat center center fixed;
      background-size: cover;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      padding: 40px 20px;
      color: #003366;
    }

    header {
      text-align: center;
      margin-bottom: 20px;
      animation: fadeInDown 1s ease-out;
    }

    header h1 {
      font-weight: 900;
      font-size: 3.6rem;
      text-shadow: 3px 3px 8px rgba(170, 204, 238, 0.7);
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 15px;
      letter-spacing: 1.5px;
    }

    header h1 i.fas.fa-bug {
      color: #0077cc;
      font-size: 3.2rem;
      transform-origin: center;
      animation: bug-wiggle 3s ease-in-out infinite;
      filter: drop-shadow(0 0 3px #0077cc88);
    }

    header h1 span {
      color: #0077cc;
      font-weight: 700;
    }

    header .tagline {
      margin-top: 10px;
      font-size: 1.2rem;
      font-weight: 500;
      color: #004080;
      text-shadow: 1px 1px 2px rgba(0, 119, 204, 0.15);
    }

    @keyframes bug-wiggle {
      0%, 100% { transform: rotate(-15deg); }
      50% { transform: rotate(-10deg); }
    }

    @keyframes fadeInDown {
      from {
        opacity: 0;
        transform: translateY(-30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .container {
      background-color: rgba(255, 255, 255, 0.97);
      box-shadow: 0 14px 36px rgba(0, 0, 0, 0.15);
      border-radius: 20px;
      max-width: 500px;
      width: 100%;
      padding: 50px 40px;
      margin-top: 20px;
      animation: fadeInUp 0.8s ease-out;
    }

    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .container h2 {
      text-align: center;
      margin-bottom: 35px;
      font-size: 30px;
      font-weight: 700;
      letter-spacing: 1px;
    }

    .form-group {
      margin-bottom: 25px;
    }

    .form-group input {
      width: 100%;
      padding: 16px 18px;
      font-size: 16px;
      border-radius: 10px;
      border: 1.8px solid #aaccee;
      box-shadow: inset 0 1px 4px rgba(0, 0, 0, 0.07);
      font-weight: 600;
      color: #003366;
      background-color: #fdfdff;
      transition: all 0.3s ease;
    }

    .form-group input::placeholder {
      color: #88aadd;
      font-weight: 400;
    }

    .form-group input:focus {
      border-color: #0055aa;
      box-shadow: 0 0 10px #0055aa88;
      outline: none;
      background-color: #f0f8ff;
    }

    button {
      width: 100%;
      padding: 16px 0;
      background-color: #003366;
      color: white;
      font-size: 18px;
      border: none;
      border-radius: 10px;
      font-weight: 700;
      letter-spacing: 1px;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
      box-shadow: 0 4px 12px rgba(0, 51, 102, 0.4);
    }

    button:hover {
      background-color: #0055aa;
      transform: scale(1.05);
    }

    .error {
      color: #cc0000;
      text-align: center;
      margin-top: 20px;
      font-size: 15px;
      font-weight: 600;
    }

    .login-link {
      text-align: center;
      margin-top: 30px;
      font-size: 15px;
      font-weight: 600;
      color: #004488;
    }

    .login-link a {
      color: #0055aa;
      text-decoration: none;
      font-weight: 700;
      transition: color 0.3s ease;
    }

    .login-link a:hover {
      color: #0077cc;
      text-decoration: underline;
    }

    @media (max-width: 600px) {
      .container {
        padding: 40px 25px;
      }

      header h1 {
        font-size: 2.6rem;
      }

      header .tagline {
        font-size: 1rem;
      }
    }
  </style>
</head>
<body>
  <header>
    <h1><i class="fas fa-bug"></i> BugTracker <span>Pro</span></h1>
    <p class="tagline">Streamlined Bug Reporting &amp; Tracking System</p>
  </header>

  <main class="container">
    <form action="RegisterServlet" method="post">
      <h2>Register</h2>

      <div class="form-group">
        <input type="text" name="username" placeholder="Username" required />
      </div>

      <div class="form-group">
        <input type="email" name="email" placeholder="Email" required />
      </div>

      <div class="form-group">
        <input type="password" name="password" placeholder="Password" required />
      </div>

      <button type="submit">Register</button>

      <div class="error">
        <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
      </div>

      <div class="login-link">
        Already have an account? <a href="login.jsp">Login here</a>
      </div>
    </form>
  </main>
</body>
</html>
