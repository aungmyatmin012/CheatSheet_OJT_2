<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Cheat Sheets</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

/* ======================
   FULL PAGE LAYOUT FIX
====================== */
html, body {
    height: 100%;
}

body{
    background:#f5f7fb;
    font-family: 'Segoe UI', sans-serif;
    display:flex;
    flex-direction:column;
    margin:0;
}

/* ======================
   HEADER
====================== */
.top-header{
    background:#0f172a;
    color:white;
    padding:12px 0;
}

.nav-bar{
    background:#111827;
    padding:10px 0;
}

.nav-bar a{
    color:#cbd5e1;
    text-decoration:none;
    margin-right:15px;
    font-size:14px;
}

/* ======================
   MAIN
====================== */
.main-content{
    flex:1;
    padding:30px 0;
}

/* ======================
   BACK BUTTON
====================== */
.back-btn{
    display:inline-block;
    background:#e5e7eb;
    padding:6px 12px;
    border-radius:8px;
    text-decoration:none;
    color:#111827;
    font-size:13px;
    margin-bottom:15px;
}

.back-btn:hover{
    background:#d1d5db;
}

/* ======================
   CARD LIST
====================== */
.card-box{
    background:white;
    padding:20px;
    border-radius:12px;
    margin-bottom:15px;
    box-shadow:0 2px 10px rgba(0,0,0,0.05);
    transition:0.2s;
}

.card-box:hover{
    transform:translateY(-3px);
}

/* ======================
   FOOTER (STICK TO BOTTOM)
====================== */
.footer{
    background:#0f172a;
    color:white;
    text-align:center;
    padding:15px;
}

</style>

</head>

<body>

<!-- HEADER -->
<div class="top-header">
    <div class="container d-flex justify-content-between align-items-center">
        <h5 class="m-0">📚 Cheat Sheet</h5>
        <div>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-sm btn-light">Home</a>
            <a href="${pageContext.request.contextPath}/cheatsheet?action=list" class="btn btn-sm btn-outline-light">Explore</a>
        </div>
    </div>
</div>

<!-- NAV -->
<div class="nav-bar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/cheatsheet?action=list">Explore</a>
        <a href="${pageContext.request.contextPath}/secure/create">Create</a>
        <a href="${pageContext.request.contextPath}/cheatsheet?action=my">My Sheets</a>
    </div>
</div>

<!-- MAIN CONTENT -->
<div class="main-content container">

    <!-- BACK BUTTON -->
    <a href="${pageContext.request.contextPath}/cheatsheet?action=list"
       class="back-btn">
        ← Back to List
    </a>

    <h3 class="mb-4">📚 My Cheat Sheets</h3>

   <c:choose>

    <c:when test="${empty mySheets}">
        
        <div class="text-center py-5">

            <h4 class="text-muted">😕 No Cheat Sheets Yet</h4>

            <p class="text-muted">
                You haven’t created any cheat sheets yet.
            </p>

            <a href="${pageContext.request.contextPath}/secure/create"
               class="btn btn-primary mt-3">
                + Create Your First Cheat Sheet
            </a>

        </div>

    </c:when>

    <c:otherwise>

        <c:forEach var="cs" items="${mySheets}">

            <div class="card-box">

                <h5 class="fw-bold">${cs.title}</h5>

                <p class="text-muted">${cs.summary}</p>

                <small>👁 ${cs.views} views</small>

                <div class="mt-3">

                    <a href="${pageContext.request.contextPath}/cheatsheet?action=view&id=${cs.id}"
                       class="btn btn-dark btn-sm">
                        View
                    </a>

                    <a href="${pageContext.request.contextPath}/cheatsheet?action=edit&id=${cs.id}"
                       class="btn btn-warning btn-sm">
                        Edit
                    </a>

                    <a href="${pageContext.request.contextPath}/cheatsheet?action=delete&id=${cs.id}"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Delete this cheat sheet?')">
                        Delete
                    </a>

                </div>

            </div>

        </c:forEach>

    </c:otherwise>

</c:choose>

</div>

<!-- FOOTER (ALWAYS BOTTOM) -->
<div class="footer">
    © 2026 CheatSheet Platform • Built for Developers
</div>

</body>
</html>