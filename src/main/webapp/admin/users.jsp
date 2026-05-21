<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.cheatsheet.model.User" %>

<%@ include file="/admin/layout/header.jsp" %>

<%
    List<User> users = (List<User>) request.getAttribute("users");

    int totalUsers = (users != null) ? users.size() : 0;
    int adminCount = 0;

    if (users != null) {
        for (User u : users) {
            if (u != null && "ADMIN".equalsIgnoreCase(u.getRole())) {
                adminCount++;
            }
        }
    }

    int normalUsers = totalUsers - adminCount;
%>

<style>
body {
    background: #f5f7fb;
}

.page-title {
    font-weight: 800;
    margin-bottom: 25px;
}

.stat-card {
    background: white;
    border-radius: 16px;
    padding: 22px;
    box-shadow: 0 4px 14px rgba(0,0,0,0.05);
}

.stat-card:hover {
    transform: translateY(-3px);
    transition: 0.2s;
}

.stat-icon {
    width: 55px;
    height: 55px;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 22px;
    background: #eef2ff;
}

.table-card {
    background: white;
    border-radius: 18px;
    padding: 24px;
    box-shadow: 0 4px 14px rgba(0,0,0,0.05);
}

.user-avatar {
    width: 42px;
    height: 42px;
    border-radius: 50%;
    background: #111827;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 700;
    font-size: 14px;
}

.role-admin {
    background: #dc2626;
    color: white;
    padding: 6px 12px;
    border-radius: 30px;
    font-size: 12px;
    font-weight: 600;
}

.role-user {
    background: #2563eb;
    color: white;
    padding: 6px 12px;
    border-radius: 30px;
    font-size: 12px;
    font-weight: 600;
}

.empty-box {
    padding: 40px;
    text-align: center;
    color: #6b7280;
}
</style>

<div class="container mt-4">

    <!-- TITLE -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="page-title">👥 User Management</h3>
            <div class="text-muted">Manage users, admins and permissions</div>
        </div>
    </div>

    <!-- STATS -->
    <div class="row g-3 mb-4">

        <div class="col-md-4">
            <div class="stat-card">
                <div class="text-muted">Total Users</div>
                <h2><%= totalUsers %></h2>
            </div>
        </div>

        <div class="col-md-4">
            <div class="stat-card">
                <div class="text-muted">Admin Accounts</div>
                <h2><%= adminCount %></h2>
            </div>
        </div>

        <div class="col-md-4">
            <div class="stat-card">
                <div class="text-muted">Normal Users</div>
                <h2><%= normalUsers %></h2>
            </div>
        </div>

    </div>

    <!-- TABLE -->
    <div class="table-card">

        <% if (users == null || users.isEmpty()) { %>

            <div class="empty-box">No users found.</div>

        <% } else { %>

        <div class="table-responsive">
            <table class="table align-middle">

                <thead>
                    <tr>
                        <th>User</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    for (User u : users) {
                        if (u == null) continue;

                        String name = (u.getName() != null) ? u.getName().trim() : "N/A";

                        // SAFE INITIAL (NO CRASH EVER)
                        String initial = "U";
                        if (!name.isEmpty()) {
                            initial = name.substring(0, 1).toUpperCase();
                        }
                %>

                    <tr>

                        <!-- USER -->
                        <td>
                            <div class="d-flex align-items-center gap-3">

                                <div class="user-avatar">
                                    <%= initial %>
                                </div>

                                <div>
                                    <div class="fw-bold"><%= name %></div>
                                    <div class="text-muted small">ID: <%= u.getId() %></div>
                                </div>

                            </div>
                        </td>

                        <!-- EMAIL -->
                        <td><%= u.getEmail() %></td>

                        <!-- ROLE -->
                        <td>
                            <% if ("ADMIN".equalsIgnoreCase(u.getRole())) { %>
                                <span class="role-admin">ADMIN</span>
                            <% } else { %>
                                <span class="role-user">USER</span>
                            <% } %>
                        </td>

                        <!-- ACTION -->
                        <td>
                            <a href="<%= request.getContextPath() %>/admin/user/delete?id=<%= u.getId() %>"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Delete this user?')">
                                Delete
                            </a>
                        </td>

                    </tr>

                <% } %>

                </tbody>
            </table>
        </div>

        <% } %>

    </div>

</div>

<%@ include file="/admin/layout/footer.jsp" %>