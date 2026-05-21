package com.cheatsheet.controller;

import com.cheatsheet.model.User;
import com.cheatsheet.repository.UserRepository;
import com.cheatsheet.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // SHOW LOGIN PAGE
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/login.jsp")
               .forward(request, response);
    }

    // LOGIN PROCESS
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty()) {

            response.sendRedirect(
                request.getContextPath()
                + "/login.jsp?error=email"
            );

            return;
        }

        if (password == null || password.trim().isEmpty()) {

            response.sendRedirect(
                request.getContextPath()
                + "/login.jsp?error=password"
            );

            return;
        }

        UserRepository repo = new UserRepository();
        User user = repo.findByEmail(email);

        if (user != null &&
            PasswordUtil.checkPassword(
                password,
                user.getPassword()
            )) {

            HttpSession session =
                    request.getSession();

            session.setAttribute("user", user);

            // redirect after login
            String redirect =
                (String) session.getAttribute(
                    "redirectAfterLogin"
                );

            if (redirect != null) {

                session.removeAttribute(
                    "redirectAfterLogin"
                );

                response.sendRedirect(redirect);
                return;
            }

            // default redirect
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/admin"
                );

            } else {

                response.sendRedirect(
                    request.getContextPath()
                    + "/home"
                );
            }

            return;
        }

        response.sendRedirect(
            request.getContextPath()
            + "/login.jsp?error=1"
        );
    }
}