package com.cheatsheet.controller;

import com.cheatsheet.model.CheatSheet;
import com.cheatsheet.model.Comment;
import com.cheatsheet.model.User;
import com.cheatsheet.repository.CheatSheetRepository;
import com.cheatsheet.repository.CommentRepository;
import com.cheatsheet.repository.RatingRepository;
import com.cheatsheet.repository.CategoryRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import com.cheatsheet.model.Section;
import com.cheatsheet.repository.SectionRepository;

@WebServlet("/cheatsheet")
public class CheatSheetServlet extends HttpServlet {

    CheatSheetRepository cheatRepo = new CheatSheetRepository();
    CategoryRepository categoryRepo = new CategoryRepository();
    SectionRepository sectionRepo = new SectionRepository();

    // =========================
    // GET (SHOW PAGES)
    // =========================
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
//
//        if ("view".equals(action)) {
//
//            int id = Integer.parseInt(req.getParameter("id"));
//
//            CheatSheet cs = cheatRepo.findById(id);
//
//            req.setAttribute("cs", cs);
//
//            req.getRequestDispatcher("/user/view-cheatsheet.jsp")
//                   .forward(req, resp);
//
//            return;
//        }
        if (action == null) {
            action = "list";
        }

        switch (action) {

            case "create":
                showCreateForm(req, resp);
                break;

            case "view":
                viewCheatSheet(req, resp);
                break;
                
            case "edit":
                showEditForm(req, resp);
                break;

            case "delete":
                deleteCheatSheet(req, resp);
                break;

            case "my":

                User user = (User) req.getSession().getAttribute("user");

                // NOT LOGGED IN
                if (user == null) {

                    resp.sendRedirect(req.getContextPath() + "/login.jsp");
                    return;
                }

                List<CheatSheet> mySheets =
                        cheatRepo.findByUser(user.getId());

                req.setAttribute("mySheets", mySheets);

                req.getRequestDispatcher("/user/my-cheatsheets.jsp")
                        .forward(req, resp);

                break;

            case "list":
            default:
                listCheatSheets(req, resp);
                break;
        }
    }
    // =========================
    // POST (FORM SUBMIT)
    // =========================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        

        if ("save".equals(action)) {
            createCheatSheet(req, resp);
        }
        
        if ("update".equals(action)) {
            updateCheatSheet(req, resp);
        }
    }

    // =========================
    // SHOW CREATE FORM
    // =========================
    private void showCreateForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("categories", categoryRepo.findAll());

        req.getRequestDispatcher("/user/create.jsp")
                .forward(req, resp);
    }

    // =========================
    // CREATE (SAVE)
    // =========================
    private void createCheatSheet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
 

        if (user == null) {
        	resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String title = req.getParameter("title");
        String summary = req.getParameter("summary");

        String catParam = req.getParameter("category_id");

        int categoryId = 0;
        if (catParam != null && !catParam.isEmpty()) {
            categoryId = Integer.parseInt(catParam);
        } else {
        	resp.sendRedirect(req.getContextPath() + "/cheatsheet?action=create&error=category");
            return;
        }

        // 🔥 GET MULTIPLE SECTIONS
        String[] sectionTitles = req.getParameterValues("sectionTitle[]");
        String[] sectionContents = req.getParameterValues("sectionContent[]");

        // =========================
        // SAVE CHEATSHEET FIRST
        // =========================
        CheatSheet cs = new CheatSheet();
        cs.setTitle(title);
        cs.setSummary(summary);
        cs.setCategoryId(categoryId);
        cs.setUserId(user.getId());
        cs.setStatus("pending_review");

        // 🔥 ADD DATE
        cs.setPublishedAt(new java.sql.Timestamp(System.currentTimeMillis()));

        int cheatId = cheatRepo.saveAndReturnId(cs);

        // =========================
        // SAVE SECTIONS
        // =========================
        if (sectionTitles != null) {
            for (int i = 0; i < sectionTitles.length; i++) {

                if (sectionTitles[i] == null || sectionTitles[i].isEmpty()) continue;

                Section s = new Section();
                s.setCheatSheetId(cheatId);
                s.setTitle(sectionTitles[i]);
                s.setContent(sectionContents[i]);
                s.setSortOrder(i);

                sectionRepo.save(s);
            }
        }

        resp.sendRedirect(req.getContextPath() + "/cheatsheet?action=list");
    }
    // =========================
    // LIST (ONLY APPROVED)
    // =========================
    private void listCheatSheets(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

    	 List<CheatSheet> list = cheatRepo.findPublished();
    	 
        req.setAttribute("list", cheatRepo.findPublished());

        req.getRequestDispatcher("/user/list.jsp")
                .forward(req, resp);
    }

    // =========================
    // VIEW DETAIL
    // =========================
    private void viewCheatSheet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        CheatSheet cs = cheatRepo.findById(id);

        if (cs == null || !"published".equals(cs.getStatus())) {
        	resp.sendRedirect(req.getContextPath() + "/cheatsheet?action=list");
            return;
        }

        cheatRepo.incrementViews(id);

        // 🔥 LOAD SECTIONS
        List<Section> sections = sectionRepo.findByCheatSheetId(id);

        // 💬 COMMENTS (ADD THIS)
        CommentRepository commentRepo = new CommentRepository();
        List<Comment> comments = commentRepo.getComments(id);

        // ⭐ RATING (ADD THIS)
        RatingRepository ratingRepo = new RatingRepository();
        double avgRating = ratingRepo.getAverageRating(id);
        
        
        req.setAttribute("cs", cs);
        req.setAttribute("sections", sections);

        req.setAttribute("comments", comments);
        req.setAttribute("avgRating", avgRating);

        req.getRequestDispatcher("/user/view-cheatsheet.jsp")
                .forward(req, resp);
    }
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));

        CheatSheet existing = cheatRepo.findById(id);

        if (existing == null || existing.getUserId() != user.getId()) {
            resp.sendRedirect(req.getContextPath() + "/cheatsheet?action=my");
            return;
        }

        // ✅ LOAD MAIN DATA
        req.setAttribute("cs", existing);

        // ✅ LOAD CATEGORIES
        req.setAttribute("categories", categoryRepo.findAll());

        // ⭐ IMPORTANT PART (THIS YOU ASKED)
        List<Section> sections = sectionRepo.findByCheatSheetId(id);
        req.setAttribute("sections", sections);

        // forward to edit page
        req.getRequestDispatcher("/user/edit-cheatsheet.jsp")
                .forward(req, resp);
    }
    private void updateCheatSheet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));

        CheatSheet existing = cheatRepo.findById(id);

        if (existing == null || existing.getUserId() != user.getId()) {
            resp.sendRedirect(req.getContextPath() + "/cheatsheet?action=my");
            return;
        }

        // =========================
        // UPDATE MAIN TABLE
        // =========================
        String title = req.getParameter("title");
        String summary = req.getParameter("summary");
        int categoryId = Integer.parseInt(req.getParameter("category_id"));

        existing.setTitle(title);
        existing.setSummary(summary);
        existing.setCategoryId(categoryId);

        cheatRepo.update(existing);

        // =========================
        // UPDATE SECTIONS
        // =========================
        String[] sectionTitles = req.getParameterValues("sectionTitle[]");
        String[] sectionContents = req.getParameterValues("sectionContent[]");

        // 1. DELETE OLD SECTIONS
        sectionRepo.deleteByCheatSheetId(id);

        // 2. INSERT NEW SECTIONS
        if (sectionTitles != null) {
            for (int i = 0; i < sectionTitles.length; i++) {

                if (sectionTitles[i] == null || sectionTitles[i].trim().isEmpty()) continue;

                Section s = new Section();
                s.setCheatSheetId(id);
                s.setTitle(sectionTitles[i]);
                s.setContent(sectionContents[i]);
                s.setSortOrder(i);

                sectionRepo.save(s);
            }
        }

        resp.sendRedirect(req.getContextPath() + "/cheatsheet?action=my");
    }
    
    private void deleteCheatSheet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));

        CheatSheet existing = cheatRepo.findById(id);

        // 🔒 SECURITY CHECK (IMPORTANT)
        if (existing == null || existing.getUserId() != user.getId()) {
            resp.sendRedirect(req.getContextPath() + "/cheatsheet?action=my");
            return;
        }

        cheatRepo.delete(id);

        resp.sendRedirect(req.getContextPath() + "/cheatsheet?action=my");
    }
}
