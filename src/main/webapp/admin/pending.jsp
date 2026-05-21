<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN LIST</title>
</head>
<body>

<h3>Pending Cheat Sheets</h3>

<c:forEach var="cs" items="${list}">
    <div class="card p-3 mb-3">

        <h5>${cs.title}</h5>
        <p>${cs.summary}</p>

        <a href="${pageContext.request.contextPath}/admin?action=view&id=${cs.id}"
           class="btn btn-sm btn-dark">
            Review
        </a>

    </div>
</c:forEach>

</body>
</html>