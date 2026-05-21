package com.cheatsheet.controller;

import com.cheatsheet.model.User;
import com.cheatsheet.repository.CommentRepository;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/comment/delete")
public class CommentDeleteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int commentId = Integer.parseInt(request.getParameter("id"));
        int cheatSheetId = Integer.parseInt(request.getParameter("cheatSheetId"));

        CommentRepository repo = new CommentRepository();
        repo.deleteComment(commentId, user.getId());

        response.sendRedirect(
                request.getContextPath() +
                "/cheatsheet?action=view&id=" + cheatSheetId
        );
    }
}