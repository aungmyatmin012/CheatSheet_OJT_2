package com.cheatsheet.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheatsheet.model.Category;
import com.cheatsheet.model.CheatSheet;
import com.cheatsheet.repository.CategoryRepository;
import com.cheatsheet.repository.CheatSheetRepository;

@WebServlet("/category/view")
	public class CategoryViewServlet extends HttpServlet {

	    CategoryRepository categoryRepo = new CategoryRepository();
	    CheatSheetRepository cheatRepo = new CheatSheetRepository();

	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        int categoryId = Integer.parseInt(request.getParameter("id"));

	        // Get category info
	        Category category = categoryRepo.findById(categoryId);

	        // Get cheat sheets under this category
	        List<CheatSheet> list = cheatRepo.findByCategory(categoryId);

	        request.setAttribute("category", category);
	        request.setAttribute("cheatsheets", list);

	        request.getRequestDispatcher("/user/category-view.jsp")
	               .forward(request, response);
	    }
	}

