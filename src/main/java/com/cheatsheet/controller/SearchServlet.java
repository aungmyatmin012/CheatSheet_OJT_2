package com.cheatsheet.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.cheatsheet.model.CheatSheet;
import com.cheatsheet.repository.CheatSheetRepository;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    CheatSheetRepository repo = new CheatSheetRepository();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("q");

        // Handle empty search
        if (keyword == null || keyword.trim().isEmpty()) {
            request.setAttribute("results", new ArrayList<>());
            request.setAttribute("keyword", "");
            request.getRequestDispatcher("/user/search.jsp").forward(request, response);
            return;
        }

        // ✅ FIX: actual search logic
        keyword = keyword.trim();

        List<CheatSheet> results = repo.search(keyword);

        // Debug (optional)
        System.out.println("Keyword: " + keyword);
        System.out.println("Results size: " + results.size());

        request.setAttribute("results", results);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("/user/search.jsp").forward(request, response);
    }
}