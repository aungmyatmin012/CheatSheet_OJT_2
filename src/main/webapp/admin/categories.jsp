<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="layout/header.jsp" %>

<div class="d-flex justify-content-between mb-3">
    <h2>Category Management</h2>

    <button class="btn btn-primary"
            data-bs-toggle="modal"
            data-bs-target="#categoryModal"
            onclick="openAddModal()">
        + Add Category
    </button>
</div>

<!-- TABLE -->
<table class="table table-bordered table-hover bg-white">

    <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th width="220">Action</th>
        </tr>
    </thead>

    <tbody>

        <c:if test="${empty list}">
            <tr>
                <td colspan="4" class="text-center">No categories found</td>
            </tr>
        </c:if>

        <c:forEach var="c" items="${list}">

            <tr>
                <td>${c.id}</td>
                <td>${c.name}</td>
                <td>${c.description}</td>

                <td>

                    <button class="btn btn-warning btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#categoryModal"
                            onclick="openEditModal('${c.id}', '${c.name}', '${c.description}')">
                        Edit
                    </button>

                    <a href="${pageContext.request.contextPath}/category?action=delete&id=${c.id}"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Delete category?')">
                        Delete
                    </a>

                </td>
            </tr>

        </c:forEach>

    </tbody>
</table>

<!-- MODAL -->
<div class="modal fade" id="categoryModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <form action="${pageContext.request.contextPath}/category" method="post">

        <div class="modal-header">
          <h5 class="modal-title" id="modalTitle">Add Category</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>

        <div class="modal-body">

          <input type="hidden" name="id" id="catId">

          <div class="mb-3">
            <label>Name</label>
            <input type="text" name="name" id="catName" class="form-control" required>
          </div>

          <div class="mb-3">
            <label>Description</label>
            <textarea name="description" id="catDesc" class="form-control"></textarea>
          </div>

        </div>

        <div class="modal-footer">
          <button class="btn btn-success">Save</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        </div>

      </form>

    </div>
  </div>
</div>

<script>
function openAddModal() {
    document.getElementById("modalTitle").innerText = "Add Category";
    document.getElementById("catId").value = "";
    document.getElementById("catName").value = "";
    document.getElementById("catDesc").value = "";
}

function openEditModal(id, name, desc) {
    document.getElementById("modalTitle").innerText = "Edit Category";
    document.getElementById("catId").value = id;
    document.getElementById("catName").value = name;
    document.getElementById("catDesc").value = desc;
}
</script>

<%@ include file="layout/footer.jsp" %>