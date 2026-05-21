package com.cheatsheet.controller;

import com.cheatsheet.model.User;
import com.cheatsheet.repository.UserRepository;
import com.cheatsheet.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    // SHOW REGISTER PAGE
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/register.jsp")
               .forward(request, response);
    }

    // PROCESS REGISTER
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // validation
        if (name == null || name.trim().isEmpty()) {

            response.sendRedirect(
                request.getContextPath()
                + "/register?error=name"
            );
            return;
        }

        if (email == null || !email.contains("@")) {

            response.sendRedirect(
                request.getContextPath()
                + "/register?error=email"
            );
            return;
        }

        if (password == null || password.length() < 6) {

            response.sendRedirect(
                request.getContextPath()
                + "/register?error=password"
            );
            return;
        }

        UserRepository repo = new UserRepository();

        if (repo.existsByEmail(email)) {

            response.sendRedirect(
                request.getContextPath()
                + "/register?error=exists"
            );
            return;
        }

        String hashedPassword =
                PasswordUtil.hashPassword(password);

        User user = new User();

        user.setName(name);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setRole("USER");

        if (repo.save(user)) {

            response.sendRedirect(
                request.getContextPath()
                + "/login?success=1"
            );

        } else {

            response.sendRedirect(
                request.getContextPath()
                + "/register?error=db"
            );
        }
    }
}