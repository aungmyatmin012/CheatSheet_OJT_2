<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/admin/layout/header.jsp" %>

<style>
body {
    background: #f5f7fb;
}

/* DASHBOARD CARDS */
.dashboard-card {
    background: white;
    border-radius: 14px;
    padding: 20px;
    box-shadow: 0 4px 14px rgba(0,0,0,0.05);
    transition: 0.2s;
}

.dashboard-card:hover {
    transform: translateY(-3px);
}

/* TITLE */
.page-title {
    font-weight: 800;
    margin-bottom: 20px;
}
</style>

<div class="container mt-4">

<!-- =========================
     DASHBOARD OVERVIEW
========================= -->
<h4 class="page-title">📊 Admin Dashboard</h4>

<div class="row g-3 mb-4">

    <div class="col-md-3">
        <div class="dashboard-card text-center">
            <h6>Total Users</h6>
            <h3>${userCount}</h3>
        </div>
    </div>

    <div class="col-md-3">
        <div class="dashboard-card text-center">
            <h6>Admins</h6>
            <h3>${adminCount}</h3>
        </div>
    </div>

    <div class="col-md-3">
        <div class="dashboard-card text-center">
            <h6>Cheat Sheets</h6>
            <h3>${cheatSheetCount}</h3>
        </div>
    </div>

    <div class="col-md-3">
        <div class="dashboard-card text-center">
            <h6>Categories</h6>
            <h3>${categoryCount}</h3>
        </div>
    </div>

</div>

<!-- =========================
     MODERATION OVERVIEW
========================= -->
<div class="row mb-4">

    <div class="col-md-4">
        <div class="dashboard-card text-center">
            <h6>⏳ Pending Reviews</h6>
            <h2>${pendingCount}</h2>
        </div>
    </div>

    <div class="col-md-4">
        <div class="dashboard-card text-center">
            <h6>✅ Published</h6>
            <h2>${publishedCount}</h2>
        </div>
    </div>

    <div class="col-md-4">
        <div class="dashboard-card text-center">
            <h6>❌ Rejected</h6>
            <h2>${rejectedCount}</h2>
        </div>
    </div>

</div>

<!-- =========================
     TABS
========================= -->
<ul class="nav nav-tabs mb-4">
    <li class="nav-item">
        <a class="nav-link ${tab=='pending'?'active':''}"
           href="${pageContext.request.contextPath}/admin?tab=pending">
            ⏳ Pending
        </a>
    </li>

    <li class="nav-item">
        <a class="nav-link ${tab=='approved'?'active':''}"
           href="${pageContext.request.contextPath}/admin?tab=approved">
            ✅ Approved
        </a>
    </li>

    <li class="nav-item">
        <a class="nav-link ${tab=='rejected'?'active':''}"
           href="${pageContext.request.contextPath}/admin?tab=rejected">
            ❌ Rejected
        </a>
    </li>
</ul>

<!-- EMPTY STATE -->
<c:if test="${empty list}">
    <div class="alert alert-info">No records found.</div>
</c:if>

<!-- =========================
     MODERATION LIST
========================= -->
<div class="row">

<c:forEach var="cs" items="${list}">

    <div class="col-md-6">
        <div class="dashboard-card mb-3">

            <!-- TITLE + STATUS -->
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0">${cs.title}</h5>

                <span class="badge 
                    ${cs.status=='published'?'bg-success':
                      cs.status=='rejected'?'bg-danger':'bg-warning'}">
                    ${cs.status}
                </span>
            </div>

            <p class="text-muted mt-2">${cs.summary}</p>

            <!-- ACTIONS -->
            <div class="d-flex gap-2">

                <a href="${pageContext.request.contextPath}/admin?action=view&id=${cs.id}"
                   class="btn btn-sm btn-dark">
                    👁 Review
                </a>

                <c:if test="${tab=='pending'}">

                    <form method="post" action="${pageContext.request.contextPath}/admin">
                        <input type="hidden" name="id" value="${cs.id}">
                        <input type="hidden" name="action" value="approve">

                        <button class="btn btn-sm btn-success"
                                onclick="return confirm('Approve?')">
                            ✔
                        </button>
                    </form>

                    <form method="post" action="${pageContext.request.contextPath}/admin">
                        <input type="hidden" name="id" value="${cs.id}">
                        <input type="hidden" name="action" value="reject">

                        <button class="btn btn-sm btn-danger"
                                onclick="return confirm('Reject?')">
                            ✖
                        </button>
                    </form>

                </c:if>

            </div>

        </div>
    </div>

</c:forEach>

</div>

</div>

<%@ include file="/admin/layout/footer.jsp" %>