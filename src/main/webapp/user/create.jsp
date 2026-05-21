<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Cheat Sheet</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
    background:#f6f7fb;
    font-family:'Segoe UI', sans-serif;
    margin:0;
}

/* HEADER */
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

/* PAGE WRAPPER */
.page-wrapper{
    padding:30px 0;
}

/* FORM CARD */
.form-card{
    background:#ffffff;
    border:1px solid #e5e7eb;
    border-radius:16px;
    padding:30px;
    box-shadow:0 6px 18px rgba(0,0,0,0.05);
}

/* BACK BUTTON */
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

/* TITLE */
.page-title{
    font-size:26px;
    font-weight:800;
    margin-bottom:20px;
}

/* INPUTS */
.form-control, .form-select{
    border-radius:10px;
    font-size:14px;
}

/* SECTION BOX */
.section-box{
    background:#f9fafb;
    padding:15px;
    border-radius:12px;
    border:1px solid #eef0f3;
    margin-bottom:12px;
}

/* FOOTER */
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
        <a href="${pageContext.request.contextPath}/cheatsheet?action=create">Create</a>
        <a href="${pageContext.request.contextPath}/cheatsheet?action=my">My Sheets</a>
    </div>
</div>

<!-- CONTENT -->
<div class="page-wrapper container">

    <div class="form-card">

        <!-- BACK -->
        <c:set var="backUrl" value="${param.backUrl}" />

        <a href="${not empty backUrl 
                ? backUrl 
                : pageContext.request.contextPath.concat('/cheatsheet?action=list')}"
           class="back-btn">
            ← Back
        </a>

        <div class="page-title">✍ Create Cheat Sheet</div>

       <form action="${pageContext.request.contextPath}/cheatsheet" method="post">

    <input type="hidden" name="action" value="save">

    <!-- TITLE -->
    <div class="mb-3">
        <label class="form-label">Title</label>
        <input name="title" class="form-control" required>
    </div>

    <!-- SUMMARY -->
    <div class="mb-3">
        <label class="form-label">Summary</label>
        <textarea name="summary" class="form-control"></textarea>
    </div>

    <!-- SECTIONS -->
    <label class="form-label">Sections</label>

    <div id="sections">

        <div class="section-box">
            <input name="sectionTitle[]" class="form-control mb-2"
                   placeholder="Section Title">

            <textarea name="sectionContent[]"
                      class="form-control"
                      placeholder="Content"></textarea>
        </div>

    </div>

    <button type="button"
            onclick="addSection()"
            class="btn btn-secondary mb-3">

        + Add Section

    </button>

    <!-- CATEGORY -->
    <div class="mb-3">

        <label class="form-label">Category</label>

        <select name="category_id" class="form-select">

            <c:forEach var="c" items="${categories}">
                <option value="${c.id}">
                    ${c.name}
                </option>
            </c:forEach>

        </select>

    </div>

    <button class="btn btn-primary w-100">
        Submit Cheat Sheet
    </button>

</form>

    </div>

</div>

<!-- FOOTER -->
<div class="footer">
    © 2026 CheatSheet Platform • Built for Developers
</div>
<script>
function addSection() {

    let container = document.getElementById("sections");

    let div = document.createElement("div");
    div.className = "section-box";

    div.innerHTML = `
        <input name="sectionTitle[]" class="form-control mb-2"
               placeholder="Section Title">

        <textarea name="sectionContent[]"
                  class="form-control"
                  placeholder="Content"></textarea>

        <button type="button"
                class="btn btn-sm btn-danger mt-2"
                onclick="this.parentElement.remove()">
            Remove
        </button>
    `;

    container.appendChild(div);
}
</script>
</body>
</html>