package com.cheatsheet.controller;

import com.cheatsheet.model.CheatSheet;
import com.cheatsheet.model.Section;
import com.cheatsheet.model.User;
import com.cheatsheet.repository.AdminRepository;
import com.cheatsheet.repository.CategoryRepository;
import com.cheatsheet.repository.CheatSheetRepository;
import com.cheatsheet.repository.SectionRepository;
import com.cheatsheet.repository.UserRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // REPOSITORIES
    CheatSheetRepository cheatRepo = new CheatSheetRepository();
    AdminRepository adminRepo = new AdminRepository();
    UserRepository userRepo = new UserRepository();
    CategoryRepository categoryRepo = new CategoryRepository();
    SectionRepository sectionRepo = new SectionRepository();

    // =====================================================
    // GET
    // =====================================================
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // =====================================================
        // ADMIN SECURITY CHECK
        // =====================================================
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String tab = req.getParameter("tab");
        String action = req.getParameter("action");

        if (tab == null) {
            tab = "pending";
        }

        // =====================================================
        // DASHBOARD COUNTS
        // =====================================================
        req.setAttribute("userCount", userRepo.countUsers());

        req.setAttribute("adminCount", userRepo.countAdmins());

        req.setAttribute("cheatSheetCount",
                cheatRepo.countAll());

        req.setAttribute("categoryCount",
                categoryRepo.countAll());

        req.setAttribute("pendingCount",
                cheatRepo.countByStatus("pending_review"));

        req.setAttribute("publishedCount",
                cheatRepo.countByStatus("published"));

        req.setAttribute("rejectedCount",
                cheatRepo.countByStatus("rejected"));

        // =====================================================
        // VIEW DETAIL PAGE
        // =====================================================
        if ("view".equals(action)) {

            int id = Integer.parseInt(req.getParameter("id"));

            CheatSheet cs = cheatRepo.findById(id);

            List<Section> sections = sectionRepo.findByCheatSheetId(id);

            req.setAttribute("cs", cs);
            req.setAttribute("sections", sections);

            req.getRequestDispatcher("/admin/view.jsp")
                    .forward(req, resp);

            return;
        }

        // =====================================================
        // TAB FILTER SYSTEM
        // =====================================================
        List<CheatSheet> list;

        switch (tab) {

            case "approved":

                list = cheatRepo.findByStatus("published");
                break;

            case "rejected":

                list = cheatRepo.findByStatus("rejected");
                break;

            default:

                list = cheatRepo.findByStatus("pending_review");
                break;
        }

        req.setAttribute("list", list);
        req.setAttribute("tab", tab);

        // =====================================================
        // OPEN DASHBOARD
        // =====================================================
        req.getRequestDispatcher("/admin/dashboard.jsp")
                .forward(req, resp);
    }

    // =====================================================
    // POST
    // =====================================================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        // =====================================================
        // ADMIN SECURITY CHECK
        // =====================================================
        HttpSession session = req.getSession();

        User admin = (User) session.getAttribute("user");

        if (admin == null || !"ADMIN".equalsIgnoreCase(admin.getRole())) {

            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String action = req.getParameter("action");

        int id = Integer.parseInt(req.getParameter("id"));

        String comment = req.getParameter("comment");

        // =====================================================
        // ACTION HANDLING
        // =====================================================
        switch (action) {

            case "approve":

                cheatRepo.approve(id);

                adminRepo.log(
                        id,
                        admin.getId(),
                        "approve",
                        comment
                );

                break;

            case "reject":

                cheatRepo.reject(id);

                adminRepo.log(
                        id,
                        admin.getId(),
                        "reject",
                        comment
                );

                break;

            case "request_changes":

                cheatRepo.requestChanges(id);

                adminRepo.log(
                        id,
                        admin.getId(),
                        "request_changes",
                        comment
                );

                break;
        }

        // =====================================================
        // REDIRECT
        // =====================================================
        resp.sendRedirect(
                req.getContextPath() + "/admin?tab=pending"
        );
    }
}