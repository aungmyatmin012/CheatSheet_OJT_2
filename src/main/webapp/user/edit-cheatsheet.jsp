<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/cheatsheet" method="post">

    <input type="hidden" name="action" value="update"/>
    <input type="hidden" name="id" value="${cs.id}"/>

    <input type="text" name="title" value="${cs.title}" class="form-control"/>

    <textarea name="summary" class="form-control">${cs.summary}</textarea>
    
    <input name="sectionTitle[]" value="${s.title}">
<textarea name="sectionContent[]">${s.content}</textarea>

    <select name="category_id" class="form-control">
        <c:forEach var="c" items="${categories}">
            <option value="${c.id}" ${c.id == cs.categoryId ? "selected" : ""}>
                ${c.name}
            </option>
        </c:forEach>
    </select>

    <button class="btn btn-primary mt-3">Update</button>

</form>
</body>
</html>