<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Explore Cheat Sheets</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

/* =======================
   FULL HEIGHT LAYOUT FIX
======================= */
html, body{
    height:100%;
}

body{
    background:#f6f7fb;
    font-family:'Segoe UI', sans-serif;
    color:#111827;
    display:flex;
    flex-direction:column;
}

/* MAIN WRAP pushes footer down */
.main-content{
    flex:1;
}

/* =======================
   HEADER
======================= */
.top-header{
    background:#0f172a;
    padding:16px 0;
}

.logo{
    color:white;
    font-size:26px;
    font-weight:800;
}

/* NAV */
.nav-bar{
    background:#111827;
    padding:12px 0;
}

.nav-bar a{
    color:#cbd5e1;
    text-decoration:none;
    margin-right:18px;
    font-size:14px;
}

.nav-bar a:hover{
    color:white;
}

/* =======================
   PAGE HEADER
======================= */
.page-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin:25px 0;
}

.page-title{
    font-size:26px;
    font-weight:800;
}

/* BACK BUTTON FIXED */
.back-btn{
    background:#ffffff;
    border:1px solid #e5e7eb;
    padding:6px 12px;
    border-radius:8px;
    font-size:14px;
    text-decoration:none;
    color:#111827;
    transition:0.2s;
}

.back-btn:hover{
    border-color:#2563eb;
    color:#2563eb;
}

/* =======================
   CARD
======================= */
.card-box{
    background:#ffffff;
    border:1px solid #e5e7eb;
    border-radius:14px;
    padding:22px;
    margin-bottom:20px;
    transition:0.2s;
    height:100%;
}

.card-box:hover{
    transform:translateY(-4px);
    border-color:#2563eb;
    box-shadow:0 10px 25px rgba(0,0,0,0.08);
}

.card-title{
    font-size:20px;
    font-weight:800;
}

.card-summary{
    font-size:14px;
    color:#6b7280;
    margin-top:8px;
}

.meta{
    font-size:12px;
    color:#6b7280;
    margin-top:10px;
}

.read-btn{
    display:inline-block;
    margin-top:12px;
    background:#111827;
    color:white;
    padding:6px 12px;
    border-radius:8px;
    text-decoration:none;
    font-size:13px;
}

.read-btn:hover{
    background:#2563eb;
}

/* =======================
   FOOTER (STICKY BOTTOM)
======================= */
.footer{
    background:#0f172a;
    color:#e5e7eb;
    padding:25px 0;
    text-align:center;
    font-size:14px;
    margin-top:auto; /* KEY FIX */
}

</style>

</head>

<body>

<!-- HEADER -->
<div class="top-header">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo">📚 Cheat Sheet</div>

        <div>
            <a href="home" class="btn btn-sm btn-light">Home</a>
            <a href="cheatsheet?action=list" class="btn btn-sm btn-outline-light">Explore</a>
        </div>
    </div>
</div>

<!-- NAV -->
<div class="nav-bar">
    <div class="container">
        <a href="home">Home</a>
        <a href="cheatsheet?action=list">Explore</a>
        <a href="secure/create">Create</a>
        <a href="cheatsheet?action=my">My Sheets</a>
    </div>
</div>

<!-- MAIN CONTENT -->
<div class="main-content container">

    <!-- PAGE HEADER -->
    <div class="page-header">

        <div class="page-title">📚 Explore Cheat Sheets</div>

        <!-- FIXED BACK BUTTON -->
        <a href="${pageContext.request.contextPath}/cheatsheet?action=list"
           class="back-btn">
            ← Back to List
        </a>

    </div>

    <!-- GRID -->
    <div class="row g-3">

        <c:forEach var="cs" items="${list}">

            <div class="col-lg-6 col-md-6">

                <div class="card-box">

                    <div class="card-title">${cs.title}</div>

                    <div class="card-summary">${cs.summary}</div>

                    <div class="meta">👁 ${cs.views} views</div>

                    <a href="${pageContext.request.contextPath}/cheatsheet?action=view&id=${cs.id}"
                       class="read-btn">
                        Read Cheat Sheet →
                    </a>

                </div>

            </div>

        </c:forEach>

    </div>

</div>

<!-- FOOTER (ALWAYS BOTTOM) -->
<div class="footer">
    © 2026 CheatSheet Platform • Built for Learning
</div>

</body>
</html>