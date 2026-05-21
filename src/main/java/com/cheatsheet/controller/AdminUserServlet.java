package com.cheatsheet.controller;

import com.cheatsheet.model.User;
import com.cheatsheet.repository.UserRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");

        // 🔐 SECURITY CHECK
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
        	response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        UserRepository repo = new UserRepository();
        List<User> users = repo.findAllUsers();

        request.setAttribute("users", users);

        try {
            request.getRequestDispatcher("/admin/users.jsp")
                   .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}