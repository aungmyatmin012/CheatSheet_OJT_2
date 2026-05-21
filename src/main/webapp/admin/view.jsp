<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Review - ${cs.title}</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
    background:#f4f6fb;
    font-family:'Segoe UI', sans-serif;
}

.container-box{
    background:#fff;
    padding:30px;
    border-radius:16px;
    box-shadow:0 6px 18px rgba(0,0,0,0.06);
}

.header-title{
    font-size:28px;
    font-weight:800;
}

.summary{
    color:#6b7280;
    margin-bottom:20px;
}

.section-card{
    background:#f9fafb;
    border:1px solid #e5e7eb;
    border-radius:12px;
    padding:15px;
    margin-bottom:12px;
}

.section-title{
    font-weight:700;
    font-size:16px;
    margin-bottom:6px;
}

.section-content{
    white-space:pre-wrap;
    color:#374151;
}

.badge-status{
    background:#e0f2fe;
    color:#0369a1;
    padding:5px 10px;
    border-radius:8px;
    font-size:12px;
}

.action-box{
    background:#fff;
    border:1px solid #e5e7eb;
    padding:20px;
    border-radius:12px;
    margin-top:20px;
}

.btn-group button{
    margin-right:8px;
}

</style>

</head>

<body>

<div class="container mt-4 container-box">

    <!-- TITLE -->
    <div class="d-flex justify-content-between align-items-center">

        <h3 class="header-title">${cs.title}</h3>

        <span class="badge-status">
            ${cs.status}
        </span>

    </div>

    <!-- SUMMARY -->
    <p class="summary">${cs.summary}</p>

    <hr>

    <!-- 🔥 SECTIONS -->
    <h5>📚 Sections</h5>

    <c:if test="${empty sections}">
        <div class="alert alert-warning">
            No sections found for this cheat sheet.
        </div>
    </c:if>

    <c:forEach var="s" items="${sections}">

        <div class="section-card">

            <div class="section-title">
                ${s.title}
            </div>

            <div class="section-content">
                ${s.content}
            </div>

        </div>

    </c:forEach>

    <hr>

    <!-- ADMIN COMMENT + ACTION -->
    <div class="action-box">

        <form method="post" action="${pageContext.request.contextPath}/admin">

            <input type="hidden" name="id" value="${cs.id}">

            <div class="mb-3">

                <label class="form-label fw-bold">
                    Admin Comment
                </label>

                <textarea name="comment"
                          class="form-control"
                          rows="3"
                          placeholder="Write feedback for user..."></textarea>

            </div>

            <div class="btn-group">

                <button name="action" value="approve"
                        class="btn btn-success">
                    Approve
                </button>

                <button name="action" value="reject"
                        class="btn btn-danger">
                    Reject
                </button>

                <button name="action" value="request_changes"
                        class="btn btn-warning">
                    Request Changes
                </button>

            </div>

        </form>

    </div>

</div>

</body>
</html>