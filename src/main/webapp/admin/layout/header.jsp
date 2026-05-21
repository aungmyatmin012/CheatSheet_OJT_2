<%@ page import="com.cheatsheet.model.User" %>

<%
User admin = (User) session.getAttribute("user");

if (admin == null || !"ADMIN".equalsIgnoreCase(admin.getRole())) {
    response.sendRedirect("../login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>Admin Panel</title>



<style>
body { display: flex; margin:0; min-height:100vh; }

.sidebar {
    width: 240px;
    background: #1e1e2f;
    color: white;
    padding: 20px;
}

.sidebar a {
    display: block;
    color: #ccc;
    padding: 10px;
    text-decoration: none;
    border-radius: 5px;
}

.sidebar a:hover {
    background: #34344a;
    color: white;
}

.main { flex: 1; background: #f4f6f9; }

.topbar {
    background: white;
    padding: 15px;
    border-bottom: 1px solid #ddd;
}
</style>
</head>

<body>

<div class="sidebar">
    <h4>Admin Panel</h4>
    <hr>

    <a href="<%= request.getContextPath() %>/admin">
    <i class="bi bi-speedometer2"></i> Dashboard
</a>


<a href="<%= request.getContextPath() %>/category">
    <i class="bi bi-folder"></i> Categories
</a>

<a href="<%= request.getContextPath() %>/admin/users">
    <i class="bi bi-journal-text"></i> User Management
</a>


<a href="<%= request.getContextPath() %>/users">
    <i class="bi bi-people"></i> Users Page
</a>
<a href="<%= request.getContextPath() %>/logout">>
    <i class="bi bi-box-arrow-right"></i> Logout
</a>
</div>

<div class="main">

<div class="topbar">
    Welcome, <b><%= admin.getName() %></b>
</div>

<div class="p-4">