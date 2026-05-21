package com.cheatsheet.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.cheatsheet.model.CheatSheet;
import com.cheatsheet.model.User;
import com.cheatsheet.repository.CategoryRepository;
import com.cheatsheet.repository.CheatSheetRepository;

@WebServlet("/secure/create")
public class CreateServlet extends HttpServlet {

    CheatSheetRepository cheatRepo = new CheatSheetRepository();
    CategoryRepository categoryRepo = new CategoryRepository();

   
    // SHOW CREATE PAGE
    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        // not logged in
        if (user == null) {

            session.setAttribute(
                "redirectAfterLogin",
                req.getContextPath() + "/secure/create"
            );

            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        
        req.setAttribute(
                "categories",
                categoryRepo.findAll()
            );


        // forward to form page
        req.getRequestDispatcher("/user/create.jsp")
           .forward(req, resp);
    }

    // SAVE DATA
    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {

            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        CheatSheet cs = new CheatSheet();

        cs.setTitle(req.getParameter("title"));
        cs.setSummary(req.getParameter("summary"));

        cs.setCategoryId(
            Integer.parseInt(req.getParameter("category_id"))
        );

        cs.setUserId(user.getId());

        cs.setStatus("pending_review");

        cheatRepo.save(cs);

        resp.sendRedirect(
        	    req.getContextPath() + "/home"
        	);
    }
}