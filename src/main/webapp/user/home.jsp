<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheatography</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

/* =======================
   BASE
======================= */
body{
    background:#f6f7fb;
    font-family: 'Segoe UI', sans-serif;
    color:#111827;
}

/* =======================
   HEADER (BLACK)
======================= */
.top-header{
    background:#0f172a;
    padding:16px 0;
    position:sticky;
    top:0;
    z-index:1000;
}

.logo{
    color:white;
    font-size:28px;
    font-weight:800;
}

/* =======================
   NAV (BLACK)
======================= */
.nav-bar{
    background:#111827;
    padding:12px 0;
}

.nav-bar a{
    color:#cbd5e1;
    text-decoration:none;
    margin-right:20px;
    font-weight:500;
    font-size:14px;
}

.nav-bar a:hover{
    color:#ffffff;
}

/* =======================
   HERO (CLEAN)
======================= */
.hero-section{
    background:#ffffff;
    border:1px solid #e5e7eb;
    border-radius:14px;
    padding:60px 30px;
    margin-top:25px;
    text-align:center;
}

.hero-title{
    font-size:42px;
    font-weight:800;
}

.hero-subtitle{
    font-size:16px;
    color:#6b7280;
}

/* =======================
   SECTION TITLE
======================= */
.section-title{
    font-size:22px;
    font-weight:700;
    margin-bottom:15px;
    margin-top:35px;
}

/* =======================
   CATEGORY CARD (STANDARD)
======================= */
.category-card{
    background:#ffffff;
    border:1px solid #e5e7eb;
    border-radius:12px;
    padding:18px;
    text-align:center;
    transition:0.2s;
    height:100%;
}

.category-card:hover{
    border-color:#2563eb;
    transform:translateY(-2px);
}

.category-card i{
    font-size:26px;
    color:#2563eb;
    margin-bottom:10px;
}

.category-card h6{
    font-size:15px;
    font-weight:700;
    margin-bottom:5px;
}

.category-card p{
    font-size:12px;
    color:#6b7280;
}

/* =======================
   CHEAT CARD (STANDARD)
======================= */
.card-link{
    text-decoration:none;
    color:inherit;
}

.cheat-card{
    background:#ffffff;
    border:1px solid #e5e7eb;
    border-radius:14px;
    padding:22px;
    margin-bottom:16px;
    transition:0.2s;
}

.cheat-card:hover{
    border-color:#2563eb;
    box-shadow:0 6px 18px rgba(0,0,0,0.06);
}

.cheat-title{
    font-size:20px;
    font-weight:800;
}

.cheat-summary{
    font-size:13px;
    color:#6b7280;
    margin-top:6px;
}

/* =======================
   BADGES
======================= */
.view-badge{
    background:#f3f4f6;
    padding:5px 10px;
    border-radius:20px;
    font-size:12px;
}

.meta{
    font-size:12px;
    color:#6b7280;
}

/* =======================
   FOOTER (BLACK)
======================= */
.footer{
    background:#0f172a;
    color:#e5e7eb;
    margin-top:50px;
    padding:30px 0;
    font-size:14px;
}

/* =======================
   UPDATED BUTTONS ONLY
======================= */
.btn-login{
    background:#2563eb;
    color:#fff;
    border:none;
    border-radius:20px;
    padding:6px 16px;
    font-size:13px;
    font-weight:500;
}

.btn-login:hover{
    background:#1d4ed8;
}

.btn-register{
    background:transparent;
    color:#93c5fd;
    border:1px solid #3b82f6;
    border-radius:20px;
    padding:6px 16px;
    font-size:13px;
    font-weight:500;
}

.btn-register:hover{
    background:#2563eb;
    color:#fff;
}

</style>

</head>

<body>

<!-- HEADER -->
<div class="top-header">
    <div class="container d-flex justify-content-between align-items-center">

        <div class="logo">📚 Cheat Sheet</div>

        <form action="search" method="get" class="d-flex" style="width:40%;">
            <input type="text" name="q" class="form-control form-control-sm me-2" placeholder="Search cheat sheets..." required>
            <button class="btn btn-light btn-sm">Search</button>
        </form>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <span class="text-white">👤 ${sessionScope.user.name}</span>
                <a href="logout" class="btn btn-danger btn-sm">Logout</a>
            </c:when>
            <c:otherwise>
    <div style="display:flex; gap:6px;">
        <a href="login" class="btn btn-login btn-sm">Login</a>
        <a href="register" class="btn btn-register btn-sm">Register</a>
    </div>
</c:otherwise>
        </c:choose>

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

<div class="container">

    <!-- HERO -->
    <div class="hero-section">
        <h1 class="hero-title">Cheat Sheets Library</h1>
        <p class="hero-subtitle">Browse, learn, and share structured cheat sheets</p>
    </div>

    <!-- CATEGORIES -->
    <div class="section-title">Categories</div>

    <div class="row g-3">

        <c:forEach var="c" items="${categories}">

            <div class="col-lg-3 col-md-4 col-6">

                <a href="${pageContext.request.contextPath}/category/view?id=${c.id}"
                   class="text-decoration-none">

                    <div class="category-card">

                        <i class="fas fa-book"></i>

                        <h6>${c.name}</h6>

                        <p>${c.description}</p>

                    </div>

                </a>

            </div>

        </c:forEach>

    </div>

    <!-- LATEST -->
    <div class="section-title">Latest Cheat Sheets</div>

    <c:forEach var="cs" items="${latest}">

        <a href="cheatsheet?action=view&id=${cs.id}" class="card-link">

            <div class="cheat-card">

                <div class="d-flex justify-content-between">

                    <div>
                        <div class="cheat-title">${cs.title}</div>

                        <div class="cheat-summary">
                            ${fn:length(cs.summary) > 120 ? fn:substring(cs.summary,0,120).concat("...") : cs.summary}
                        </div>

                        <div class="meta mt-2">
                            ⭐ ${cs.avgRating} • 💬 ${cs.commentCount}
                        </div>
                    </div>

                    <div class="text-end">
                        <div class="view-badge">👁 ${cs.views}</div>
                    </div>

                </div>

            </div>

        </a>

    </c:forEach>

    <!-- TRENDING -->
    <div class="section-title">Trending</div>

    <c:forEach var="cs" items="${popular}">

        <a href="cheatsheet?action=view&id=${cs.id}" class="card-link">

            <div class="cheat-card">

                <div class="d-flex justify-content-between">

                    <div>
                        <div class="cheat-title">${cs.title}</div>

                        <div class="cheat-summary">
                            ${fn:length(cs.summary) > 120 ? fn:substring(cs.summary,0,120).concat("...") : cs.summary}
                        </div>

                        <div class="meta mt-2">
                            ⭐ ${cs.avgRating} • 💬 ${cs.commentCount}
                        </div>
                    </div>

                    <div class="text-end">
                        <div class="view-badge">👁 ${cs.views}</div>
                    </div>

                </div>

            </div>

        </a>

    </c:forEach>

</div>

<!-- FOOTER -->
<div class="footer text-center">
    © 2026 CheatSheet Platform
</div>

</body>
</html>