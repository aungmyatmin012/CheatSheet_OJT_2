<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.cheatsheet.model.CheatSheet" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheat Sheets</title>
</head>

<body>

<h2>Cheat Sheets</h2>

<%
    List<CheatSheet> list = (List<CheatSheet>) request.getAttribute("list");

    if (list != null && !list.isEmpty()) {
        for (CheatSheet cs : list) {
%>

    <li>
        <a href="${pageContext.request.contextPath}/cheatsheet?action=view&id=<%= cs.getId() %>">
            <%= cs.getTitle() %>
        </a>
        <br>
        <small><%= cs.getSummary() %></small>
    </li>

<%
        }
    } else {
%>

    <p>No cheat sheets found.</p>

<%
    }
%>

</body>
</html>