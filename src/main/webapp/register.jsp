<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<style>
    body{
        background:#e5e7eb;
        font-family:'Segoe UI', sans-serif;
    }

    /* CENTER */
    .screen-wrapper{
        min-height:100vh;
        display:flex;
        align-items:center;
        justify-content:center;
    }

    /* SCREEN BOX */
    .screen-box{
        width:100%;
        max-width:520px;
        background:#fff;
        border:2px solid #111827;
        box-shadow:0 20px 50px rgba(0,0,0,0.2);
    }

    /* TOP BAR */
    .screen-top{
        background:#111827;
        color:#fff;
        padding:10px 15px;
        display:flex;
        justify-content:space-between;
        align-items:center;
        font-size:14px;
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

    .btn-register{
        background:#2563eb;
        border:none;
        border-radius:0;
        padding:10px;
        font-weight:600;
    }

    .btn-register:hover{
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

    String oldName = request.getParameter("name");
    String oldEmail = request.getParameter("email");
%>

<form action="register" method="post" class="screen-box">

    <!-- TOP BAR -->
    <div class="screen-top">
        <div class="screen-dots">
            <span></span><span></span><span></span>
        </div>
        <div>CheatSheet Register</div>
    </div>

    <!-- CONTENT -->
    <div class="screen-content">

        <div class="title">Create Account</div>
        <div class="subtitle">Join and start building cheat sheets</div>

        <!-- INFO -->
        <div class="info-box">
            Tip: Create structured notes to improve your learning speed.
        </div>

        <!-- SUCCESS -->
        <% if ("1".equals(success)) { %>
            <div class="alert alert-success">
                Registration successful! Please login.
            </div>
        <% } %>

        <!-- ERROR -->
        <% if ("name".equals(error)) { %>
            <div class="alert alert-danger">Name is required</div>
        <% } else if ("email".equals(error)) { %>
            <div class="alert alert-danger">Invalid email</div>
        <% } else if ("password".equals(error)) { %>
            <div class="alert alert-danger">Password must be at least 6 characters</div>
        <% } else if ("db".equals(error)) { %>
            <div class="alert alert-danger">Something went wrong. Try again.</div>
        <% } %>

        <!-- NAME -->
        <div class="mb-3">
            <label class="form-label">Name</label>
            <input type="text" name="name"
                   class="form-control"
                   value="<%= oldName != null ? oldName : "" %>">
        </div>

        <!-- EMAIL -->
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email"
                   class="form-control"
                   value="<%= oldEmail != null ? oldEmail : "" %>">
        </div>

        <!-- PASSWORD -->
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password"
                   class="form-control">
        </div>

        <!-- BUTTON -->
        <button type="submit" class="btn btn-register w-100">
            Register
        </button>

        <!-- FOOTER -->
        <div class="mt-3 text-center footer-text">
            Already have an account?
            <a href="login.jsp">Login</a>
        </div>

    </div>

</form>

</div>

</body>
</html>