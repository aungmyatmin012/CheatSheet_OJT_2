package com.cheatsheet.controller;

import com.cheatsheet.model.User;
import com.cheatsheet.repository.CommentRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/comment/add")
public class CommentAddServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int cheatSheetId = Integer.parseInt(request.getParameter("cheatSheetId"));
        String body = request.getParameter("body");

        String parentParam = request.getParameter("parentId");
        Integer parentId = null;

        if (parentParam != null && !parentParam.isEmpty()) {
            parentId = Integer.parseInt(parentParam);
        }

        CommentRepository repo = new CommentRepository();
        repo.addComment(cheatSheetId, user.getId(), body, parentId);

        response.sendRedirect(
                request.getContextPath() +
                "/cheatsheet?action=view&id=" + cheatSheetId
        );
    }
}