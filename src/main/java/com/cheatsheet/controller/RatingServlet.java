package com.cheatsheet.controller;

import com.cheatsheet.repository.RatingRepository;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/rate")
public class RatingServlet extends HttpServlet {

    RatingRepository repo = new RatingRepository();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        int userId = (int) session.getAttribute("userId");

        int cheatSheetId = Integer.parseInt(req.getParameter("cheatSheetId"));
        int score = Integer.parseInt(req.getParameter("score"));

        repo.saveRating(cheatSheetId, userId, score);

        resp.sendRedirect("detail?id=" + cheatSheetId);
    }
}