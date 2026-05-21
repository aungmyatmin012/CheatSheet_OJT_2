package com.cheatsheet.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.cheatsheet.repository.CategoryRepository;
import com.cheatsheet.repository.CheatSheetRepository;

@WebServlet({"/", "/home"})
public class HomeServlet extends HttpServlet {

    CategoryRepository categoryRepo = new CategoryRepository();
    CheatSheetRepository cheatRepo = new CheatSheetRepository();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("categories", categoryRepo.findAll());

        String cat = req.getParameter("category");

        // MAIN LIST (single source)
        if (cat != null && !cat.isEmpty()) {
            req.setAttribute("list",
                cheatRepo.findByCategory(Integer.parseInt(cat)));
        } else {
            req.setAttribute("list", cheatRepo.findLatest());
        }

        // SIDE SECTIONS (optional widgets)
        req.setAttribute("popular", cheatRepo.findPopular());
        req.setAttribute("latest", cheatRepo.findLatest());

        req.getRequestDispatcher("/user/home.jsp")
           .forward(req, resp);
    }
}