<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>${category.name}</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#f5f7fb;
}

.container-box{
    background:white;
    padding:30px;
    border-radius:16px;
    margin-top:30px;
    box-shadow:0 10px 25px rgba(0,0,0,0.05);
}
</style>

</head>

<body>

<div class="container">

    <div class="container-box">

        <!-- BACK BUTTON -->
        <a href="${pageContext.request.contextPath}/home"
           class="btn btn-secondary btn-sm mb-3">
            ← Back to Home
        </a>

        <!-- CATEGORY TITLE -->
        <h2>${category.name}</h2>
        <p class="text-muted">${category.description}</p>

        <hr>

        <!-- EMPTY STATE -->
        <c:if test="${empty cheatsheets}">
            <div class="alert alert-info">
                No cheat sheets in this category yet.
            </div>
        </c:if>

        <!-- LIST -->
        <c:forEach var="cs" items="${cheatsheets}">

            <div class="card mb-3 shadow-sm">

                <div class="card-body">

                    <h5 class="card-title">${cs.title}</h5>

                    <p class="card-text text-muted">
                        ${cs.summary}
                    </p>

                    <a href="${pageContext.request.contextPath}/cheatsheet?action=view&id=${cs.id}"
                       class="btn btn-primary btn-sm">
                        View Cheat Sheet →
                    </a>

                </div>

            </div>

        </c:forEach>

    </div>

</div>

</body>
</html>