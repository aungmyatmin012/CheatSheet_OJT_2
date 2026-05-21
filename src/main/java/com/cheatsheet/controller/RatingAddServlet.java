// ================================
// RatingAddServlet.java
// ================================

package com.cheatsheet.controller;

import com.cheatsheet.model.User;
import com.cheatsheet.repository.RatingRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/rating/add")
public class RatingAddServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user =
                (User) session.getAttribute("user");

        // LOGIN CHECK
        if(user == null){

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }

        int cheatSheetId =
                Integer.parseInt(
                        request.getParameter("cheatSheetId")
                );

        int score =
                Integer.parseInt(
                        request.getParameter("score")
                );

        // VALIDATION
        if(score < 1 || score > 5){

            response.sendRedirect(
                    request.getContextPath()
                    + "/cheatsheet?action=view&id="
                    + cheatSheetId
            );

            return;
        }

        RatingRepository repo =
                new RatingRepository();

        repo.saveRating(
                cheatSheetId,
                user.getId(),
                score
        );

        response.sendRedirect(
                request.getContextPath()
                + "/cheatsheet?action=view&id="
                + cheatSheetId
        );
    }
}