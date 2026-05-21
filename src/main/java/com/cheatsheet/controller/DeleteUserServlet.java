package com.cheatsheet.controller;

import com.cheatsheet.repository.UserRepository;
import com.cheatsheet.model.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/deleteUser")
public class DeleteUserServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");

        // 🔐 SECURITY CHECK
        if (admin == null || !"ADMIN".equalsIgnoreCase(admin.getRole())) {
            response.sendRedirect("../login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));

        UserRepository repo = new UserRepository();
        repo.deleteById(id);

        response.sendRedirect("users");
    }
}