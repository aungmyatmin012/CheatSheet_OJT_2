<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Search Cheat Sheets</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        body{
            background:#f5f7fb;
            font-family: 'Segoe UI', sans-serif;
            display:flex;
            flex-direction:column;
            min-height:100vh;
        }

        /* HEADER */
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

        /* SEARCH BOX */
        .search-box{
            max-width:750px;
            margin:30px auto;
        }

        .search-input{
            border-radius:50px;
            padding:12px 18px;
        }

        /* CARD */
        .cs-card{
            border:none;
            border-radius:16px;
            transition:0.25s;
            height:100%;
        }

        .cs-card:hover{
            transform:translateY(-6px);
            box-shadow:0 12px 25px rgba(0,0,0,0.12);
        }

        .cs-title{
            font-weight:600;
            color:#1f2937;
        }

        .cs-summary{
            font-size:14px;
            color:#6b7280;
        }

        .tag{
            font-size:11px;
            padding:4px 10px;
            border-radius:20px;
            background:#e5e7eb;
            display:inline-block;
            margin-bottom:8px;
        }

        /* CONTENT */
        .content{
            flex:1;
        }

        /* FOOTER */
        .footer{
            background:#0f172a;
            color:white;
            text-align:center;
            padding:15px;
            margin-top:auto;
        }

    </style>
</head>

<body>

<!-- HEADER -->
<div class="top-header">
    <div class="container d-flex justify-content-between align-items-center">
        <h5 class="m-0">📚 Cheat Sheets</h5>

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

<!-- CONTENT -->
<div class="content container">

    <!-- SEARCH -->
    <div class="search-box">
        <form action="search" method="get" class="d-flex">
            <input type="text"
                   name="q"
                   class="form-control search-input shadow-sm"
                   placeholder="Search cheat sheets..."
                   value="${keyword}">
            <button class="btn btn-primary ms-2 rounded-pill px-4">Search</button>
        </form>
    </div>

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5>Results for "<c:out value='${keyword}' />"</h5>
        <span class="text-muted">${fn:length(results)} found</span>
    </div>

    <!-- EMPTY STATE -->
    <c:if test="${empty results}">
        <div class="text-center py-5">
            <h4 class="text-muted">😢 No Cheat Sheets Found</h4>
            <p class="text-muted">Try searching: Java, SQL, Spring, JSP</p>
            <a href="cheatsheet?action=list" class="btn btn-primary mt-2">
                Back to Explore
            </a>
        </div>
    </c:if>

    <!-- GRID -->
    <div class="row g-4">

        <c:forEach var="cs" items="${results}">

            <div class="col-md-4">

                <div class="card cs-card shadow-sm">

                    <div class="card-body d-flex flex-column">

                        <span class="tag">Cheat Sheet</span>

                        <h5 class="cs-title">
                            ${cs.title}
                        </h5>

                        <p class="cs-summary">
                            <c:choose>
                                <c:when test="${fn:length(cs.summary) > 120}">
                                    ${fn:substring(cs.summary,0,120)}...
                                </c:when>
                                <c:otherwise>
                                    ${cs.summary}
                                </c:otherwise>
                            </c:choose>
                        </p>

                        <div class="mt-auto">
                            <a href="cheatsheet?action=view&id=${cs.id}"
                               class="btn btn-sm btn-outline-primary w-100 rounded-pill">
                                View Cheat Sheet →
                            </a>
                        </div>

                    </div>

                </div>

            </div>

        </c:forEach>

    </div>

</div>

<!-- FOOTER -->
<div class="footer">
    © 2026 CheatSheet Platform • Built for Developers
</div>

</body>
</html>