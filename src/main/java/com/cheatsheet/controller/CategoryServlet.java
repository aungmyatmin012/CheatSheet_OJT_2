package com.cheatsheet.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheatsheet.model.Category;
import com.cheatsheet.model.User;
import com.cheatsheet.repository.CategoryRepository;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {

    CategoryRepository repo = new CategoryRepository();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");

        if (admin == null || !"ADMIN".equalsIgnoreCase(admin.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            repo.delete(id);

            session.setAttribute("success", "Category deleted successfully!");
            response.sendRedirect(request.getContextPath() + "/category");
            return;
        }

        // DEFAULT LOAD
        request.setAttribute("list", repo.findAll());
        request.getRequestDispatcher("admin/categories.jsp")
               .forward(request, response);
    }
    

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String idStr = request.getParameter("id");

        Category c = new Category();
        c.setName(request.getParameter("name"));
        c.setDescription(request.getParameter("description"));

        if (idStr != null && !idStr.isEmpty()) {
            c.setId(Integer.parseInt(idStr));
            repo.update(c);
            session.setAttribute("success", "Category updated successfully!");
        } else {
            repo.save(c);
            session.setAttribute("success", "Category created successfully!");
        }

        response.sendRedirect(request.getContextPath() + "/category");
    }
}
