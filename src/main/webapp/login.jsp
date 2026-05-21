<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body{
            background:#e5e7eb;
            font-family:'Segoe UI', sans-serif;
        }

        /* CENTER SCREEN */
        .screen-wrapper{
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
        }

        /* LAPTOP SCREEN */
        .screen-box{
            width:100%;
            max-width:520px;
            background:#ffffff;
            border:2px solid #111827;
            box-shadow:0 20px 50px rgba(0,0,0,0.2);
        }

        /* TOP BAR (LIKE WINDOW) */
        .screen-top{
            background:#111827;
            color:#fff;
            padding:10px 15px;
            font-size:14px;
            display:flex;
            justify-content:space-between;
            align-items:center;
        }

        .screen-dots span{
            display:inline-block;
            width:10px;
            height:10px;
            margin-right:5px;
            background:#6b7280;
        }

        /* CONTENT */
        .screen-content{
            padding:30px;
        }

        .title{
            font-size:22px;
            font-weight:700;
        }

        .subtitle{
            font-size:13px;
            color:#6b7280;
            margin-bottom:20px;
        }

        .form-label{
            font-size:13px;
            font-weight:600;
        }

        .form-control{
            border-radius:0;
            border:1px solid #cbd5e1;
            padding:8px;
        }

        .form-control:focus{
            border-color:#2563eb;
            box-shadow:none;
        }

        .btn-login{
            background:#2563eb;
            border:none;
            border-radius:0;
            padding:10px;
            font-weight:600;
        }

        .btn-login:hover{
            background:#1d4ed8;
        }

        .info-box{
            background:#f9fafb;
            border:1px solid #e5e7eb;
            padding:10px;
            font-size:12px;
            margin-bottom:15px;
        }

        .footer-text{
            font-size:13px;
            color:#6b7280;
        }

        .footer-text a{
            text-decoration:none;
            font-weight:600;
        }

    </style>
</head>

<body>

<div class="screen-wrapper">

    <%
        String error = request.getParameter("error");
        String success = request.getParameter("success");
        String oldEmail = request.getParameter("email");
    %>

    <form action="login" method="post" class="screen-box">

        <!-- TOP BAR -->
        <div class="screen-top">
            <div class="screen-dots">
                <span></span><span></span><span></span>
            </div>
            <div>CheatSheet Login</div>
        </div>

        <!-- CONTENT -->
        <div class="screen-content">

            <div class="title">User Login</div>
            <div class="subtitle">Access your cheat sheets</div>

            <!-- INFO -->
            <div class="info-box">
                Tip: Organize your knowledge for quick access.
            </div>

            <!-- ERROR -->
            <% if ("1".equals(error)) { %>
                <div class="alert alert-danger">Invalid email or password</div>
            <% } else if ("email".equals(error)) { %>
                <div class="alert alert-danger">Email is required</div>
            <% } else if ("password".equals(error)) { %>
                <div class="alert alert-danger">Password is required</div>
            <% } %>

            <!-- SUCCESS -->
            <% if ("1".equals(success)) { %>
                <div class="alert alert-success">
                    Registration successful! Please login.
                </div>
            <% } %>

            <!-- EMAIL -->
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email"
                       name="email"
                       class="form-control"
                       value="<%= oldEmail != null ? oldEmail : "" %>">
            </div>

            <!-- PASSWORD -->
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password"
                       name="password"
                       class="form-control">
            </div>

            <!-- BUTTON -->
            <button type="submit" class="btn btn-login w-100">
                Login
            </button>

            <!-- FOOTER -->
            <div class="mt-3 text-center footer-text">
                Don’t have an account?
                <a href="register.jsp">Register</a>
            </div>

        </div>

    </form>

</div>

</body>
</html>