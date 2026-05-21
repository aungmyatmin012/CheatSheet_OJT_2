<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>${cs.title}</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

/* =======================
   BASE
======================= */
body{
    background:#f6f7fb;
    font-family:'Segoe UI', sans-serif;
    margin:0;
    color:#111827;
}

/* =======================
   HEADER
======================= */
.top-header{
    background:#0f172a;
    padding:14px 0;
}

.logo{
    color:white;
    font-size:24px;
    font-weight:800;
}

.nav-bar{
    background:#111827;
    padding:10px 0;
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
   CONTENT
======================= */
.page-wrapper{
    padding:25px 0;
}

.container-box{
    background:#fff;
    padding:35px;
    border-radius:16px;
    border:1px solid #e5e7eb;
    box-shadow:0 6px 18px rgba(0,0,0,0.05);
}

/* =======================
   BACK BUTTON
======================= */
.back-btn{
    display:inline-block;
    background:#f3f4f6;
    padding:6px 12px;
    border-radius:8px;
    text-decoration:none;
    color:#111827;
    font-size:13px;
    margin-bottom:15px;
}

.back-btn:hover{
    background:#e5e7eb;
}

/* =======================
   TITLE
======================= */
h1{
    font-size:28px;
    font-weight:800;
}

/* =======================
   META
======================= */
.meta{
    font-size:13px;
    color:#6b7280;
    margin-bottom:15px;
}

/* =======================
   SECTION
======================= */
.section{
    background:#f9fafb;
    padding:16px;
    border-radius:12px;
    margin-bottom:12px;
    border:1px solid #eef0f3;
}

/* =======================
   COMMENT
======================= */
.comment-box{
    border:1px solid #e5e7eb;
    padding:14px;
    border-radius:12px;
    margin-bottom:12px;
    background:#fff;
}

.reply-box{
    border-left:3px solid #e5e7eb;
    padding-left:12px;
    margin-top:10px;
}

/* =======================
   FOOTER
======================= */
.footer{
    background:#0f172a;
    color:#e5e7eb;
    text-align:center;
    padding:20px 0;
    margin-top:40px;
    font-size:14px;
}

</style>

</head>

<body>

<!-- HEADER -->
<div class="top-header">
    <div class="container d-flex justify-content-between align-items-center">

        <div class="logo">📚 Cheat Sheet</div>

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

<!-- CONTENT -->
<div class="page-wrapper container">

    <div class="container-box">

        <!-- BACK -->
        <c:set var="backUrl" value="${param.backUrl}" />

        <a href="${not empty backUrl ? backUrl : pageContext.request.contextPath.concat('/cheatsheet?action=list')}"
           class="back-btn">
            ← Back
        </a>

        <!-- TITLE -->
        <h1>${cs.title}</h1>

        <!-- META -->
        <div class="meta">
            👤 ${cs.userName}
            &nbsp; | &nbsp;
            📅 <fmt:formatDate value="${cs.publishedAt}" pattern="MMM dd, yyyy"/>
            &nbsp; | &nbsp;
            👁 ${cs.views}
            &nbsp; | &nbsp;
            ⭐ ${cs.avgRating}
        </div>

        <!-- SUMMARY -->
        <p>${cs.summary}</p>

        <hr>

        <!-- SECTIONS -->
        <c:forEach var="s" items="${sections}">
            <div class="section">
                <h5>${s.title}</h5>
                <div style="white-space:pre-wrap;">${s.content}</div>
            </div>
        </c:forEach>
<%--         <c:if test="${empty sections}">
    <h4 style="color:red">NO SECTIONS FOUND</h4>
</c:if>
 --%>
        <hr>

        <!-- RATING -->
        <h5>⭐ Rating: ${cs.avgRating}</h5>

        <form action="rating/add" method="post" class="mt-2">

            <input type="hidden" name="cheatSheetId" value="${cs.id}"/>

            <select name="score" class="form-select w-25">
                <option value="1">1 Star</option>
                <option value="2">2 Stars</option>
                <option value="3">3 Stars</option>
                <option value="4">4 Stars</option>
                <option value="5">5 Stars</option>
            </select>

            <button class="btn btn-warning mt-2">Submit Rating</button>

        </form>

        <hr>

        <!-- COMMENTS -->
        <h5>Comments</h5>

        <form action="comment/add" method="post" class="mb-3">

            <input type="hidden" name="cheatSheetId" value="${cs.id}"/>

            <textarea name="body" class="form-control" placeholder="Write comment..." required></textarea>

            <button class="btn btn-primary mt-2">Post Comment</button>

        </form>

        <!-- COMMENT LIST -->
        <c:forEach var="c" items="${comments}">

            <c:if test="${c.parentId == null}">

                <div class="comment-box">

                    <b>${c.userName}</b>
                    <small class="text-muted"> • ${c.createdAt}</small>

                    <p class="mt-2">${c.body}</p>

                    <form action="comment/delete" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="${c.id}">
                        <input type="hidden" name="cheatSheetId" value="${cs.id}">
                        <button class="btn btn-sm text-danger p-0">Delete</button>
                    </form>

                    <!-- REPLY -->
                    <form action="comment/add" method="post" class="mt-2">

                        <input type="hidden" name="cheatSheetId" value="${cs.id}"/>
                        <input type="hidden" name="parentId" value="${c.id}"/>

                        <input type="text" name="body"
                               class="form-control form-control-sm"
                               placeholder="Reply..." required/>

                        <button class="btn btn-sm btn-primary mt-1">Reply</button>

                    </form>

                    <!-- REPLIES -->
                    <div class="reply-box">

                        <c:forEach var="r" items="${comments}">
                            <c:if test="${r.parentId == c.id}">
                                <div class="mb-2">
                                    <b>${r.userName}</b>
                                    <small class="text-muted"> • ${r.createdAt}</small>
                                    <div>${r.body}</div>
                                </div>
                            </c:if>
                        </c:forEach>

                    </div>

                </div>

            </c:if>

        </c:forEach>

    </div>

</div>

<!-- FOOTER -->
<div class="footer">
    © 2026 CheatSheet Platform • Built for Developers
</div>

</body>
</html>