package com.cheatsheet.repository;

import com.cheatsheet.config.DBConnection;
import com.cheatsheet.model.CheatSheet;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CheatSheetRepository {

    // =====================================================
    // 🔥 BASE QUERY
    // =====================================================

    private static final String BASE_QUERY =
            "SELECT " +
            "cs.*, " +
            "u.name AS userName, " +
            "IFNULL(r.avg_rating, 0) AS avgRating, " +
            "IFNULL(c.commentCount, 0) AS commentCount " +
            "FROM cheat_sheets cs " +
            "JOIN users u ON cs.user_id = u.id " +

            "LEFT JOIN ( " +
            "   SELECT cheat_sheet_id, AVG(score) AS avg_rating " +
            "   FROM ratings " +
            "   GROUP BY cheat_sheet_id " +
            ") r ON cs.id = r.cheat_sheet_id " +

            "LEFT JOIN ( " +
            "   SELECT cheat_sheet_id, COUNT(*) AS commentCount " +
            "   FROM comments " +
            "   GROUP BY cheat_sheet_id " +
            ") c ON cs.id = c.cheat_sheet_id ";

    // =====================================================
    // 🔁 EXECUTOR
    // =====================================================

    private List<CheatSheet> execute(String sql, Object... params) {

        List<CheatSheet> list = new ArrayList<>();

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =====================================================
    // 🧠 MAPPER
    // =====================================================

    private CheatSheet map(ResultSet rs) throws SQLException {

        CheatSheet cs = new CheatSheet();

        cs.setId(rs.getInt("id"));
        cs.setTitle(rs.getString("title"));
        cs.setSummary(rs.getString("summary"));

     // ✅ IMPORTANT
        cs.setContent(rs.getString("content"));
        cs.setCategoryId(rs.getInt("category_id"));
        cs.setUserId(rs.getInt("user_id"));

        cs.setStatus(rs.getString("status"));
        cs.setViews(rs.getInt("views"));

        cs.setCreatedAt(rs.getTimestamp("created_at"));
        cs.setUpdatedAt(rs.getTimestamp("updated_at"));
        cs.setPublishedAt(rs.getTimestamp("published_at"));

        cs.setUserName(rs.getString("userName"));

        // ✅ FIXED
        cs.setAvgRating(rs.getDouble("avgRating"));
        cs.setCommentCount(rs.getInt("commentCount"));

        return cs;
    }

    // =====================================================
    // 🏠 LATEST
    // =====================================================

    public List<CheatSheet> findLatest() {

        String sql =
                BASE_QUERY +
                "WHERE cs.status='published' " +
                "ORDER BY cs.published_at DESC " +
                "LIMIT 10";

        return execute(sql);
    }

    // =====================================================
    // 🔥 POPULAR
    // =====================================================

    public List<CheatSheet> findPopular() {

        String sql =
                BASE_QUERY +
                "WHERE cs.status='published' " +
                "ORDER BY cs.views DESC " +
                "LIMIT 10";

        return execute(sql);
    }

    // =====================================================
    // ⭐ TOP RATED
    // =====================================================

    public List<CheatSheet> findTopRated() {

        String sql =
                BASE_QUERY +
                "WHERE cs.status='published' " +
                "ORDER BY avgRating DESC, commentCount DESC " +
                "LIMIT 10";

        return execute(sql);
    }

    // =====================================================
    // 📚 ALL PUBLISHED
    // =====================================================

    public List<CheatSheet> findPublished() {

        String sql =
                BASE_QUERY +
                "WHERE cs.status='published' " +
                "ORDER BY cs.published_at DESC, cs.views DESC";

        return execute(sql);
    }

    // =====================================================
    // 👤 USER CHEATSHEETS
    // =====================================================

    public List<CheatSheet> findByUser(int userId) {

        String sql =
                BASE_QUERY +
                "WHERE cs.user_id=? " +
                "ORDER BY cs.id DESC";

        return execute(sql, userId);
    }

    // =====================================================
    // 📂 CATEGORY
    // =====================================================

    public List<CheatSheet> findByCategory(int categoryId) {

        String sql =
                BASE_QUERY +
                "WHERE cs.category_id=? " +
                "AND cs.status='published' " +
                "ORDER BY cs.published_at DESC";

        return execute(sql, categoryId);
    }

    // =====================================================
    // ⏳ FIND BY STATUS
    // =====================================================

    public List<CheatSheet> findByStatus(String status) {

        String sql =
                BASE_QUERY +
                "WHERE cs.status=? " +
                "ORDER BY cs.created_at DESC";

        return execute(sql, status);
    }

    // =====================================================
    // 🔍 SEARCH
    // =====================================================

    public List<CheatSheet> search(String keyword) {

        String sql =
                BASE_QUERY +
                "WHERE cs.title LIKE ? " +
                "OR cs.summary LIKE ? " +
                "OR cs.content LIKE ? " +
                "ORDER BY cs.views DESC";

        String k = "%" + keyword + "%";

        return execute(sql, k, k, k);
    }

    // =====================================================
    // 🔎 FIND BY ID
    // =====================================================

    public CheatSheet findById(int id) {

        String sql =
                BASE_QUERY +
                "WHERE cs.id=?";

        List<CheatSheet> list = execute(sql, id);

        return list.isEmpty() ? null : list.get(0);
    }

    // =====================================================
    // ➕ SAVE
    // =====================================================

    public boolean save(CheatSheet cs) {

        String sql =
                "INSERT INTO cheat_sheets " +
                "(title, summary, category_id, user_id, status) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, cs.getTitle());
            ps.setString(2, cs.getSummary());
            ps.setInt(3, cs.getCategoryId());
            ps.setInt(4, cs.getUserId());
            ps.setString(5, cs.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =====================================================
    // 🔢 SAVE + RETURN ID
    // =====================================================

    public int saveAndReturnId(CheatSheet cs) {

        String sql =
                "INSERT INTO cheat_sheets " +
                "(title, summary, category_id, user_id, status, published_at) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(
                        sql,
                        Statement.RETURN_GENERATED_KEYS
                )
        ) {

            ps.setString(1, cs.getTitle());
            ps.setString(2, cs.getSummary());
            ps.setInt(3, cs.getCategoryId());
            ps.setInt(4, cs.getUserId());
            ps.setString(5, cs.getStatus());
            ps.setTimestamp(6, cs.getPublishedAt());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // =====================================================
    // ✏️ UPDATE
    // =====================================================

    public void update(CheatSheet cs) {

        String sql =
                "UPDATE cheat_sheets " +
                "SET title=?, summary=?, category_id=? " +
                "WHERE id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, cs.getTitle());
            ps.setString(2, cs.getSummary());
            ps.setInt(3, cs.getCategoryId());
            ps.setInt(4, cs.getId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =====================================================
    // 👁 INCREMENT VIEWS
    // =====================================================

    public void incrementViews(int id) {

        String sql =
                "UPDATE cheat_sheets " +
                "SET views = views + 1 " +
                "WHERE id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =====================================================
    // ❌ DELETE
    // =====================================================

    public void delete(int id) {

        String sql =
                "DELETE FROM cheat_sheets WHERE id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =====================================================
    // 🔄 STATUS UPDATE
    // =====================================================

    private void updateStatus(int id, String status) {

        String sql =
                "UPDATE cheat_sheets " +
                "SET status=? " +
                "WHERE id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, status);
            ps.setInt(2, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =====================================================
    // ✅ APPROVE
    // =====================================================

    public void approve(int id) {

        String sql =
                "UPDATE cheat_sheets " +
                "SET status='published', published_at=NOW() " +
                "WHERE id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =====================================================
    // ❌ REJECT
    // =====================================================

    public void reject(int id) {
        updateStatus(id, "rejected");
    }

    // =====================================================
    // 🔄 REQUEST CHANGES
    // =====================================================

    public void requestChanges(int id) {
        updateStatus(id, "pending_review");
    }

    // =====================================================
    // 🔢 COUNT ALL
    // =====================================================

    public int countAll() {

        String sql = "SELECT COUNT(*) FROM cheat_sheets";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // =====================================================
    // 🔢 COUNT BY STATUS
    // =====================================================

    public int countByStatus(String status) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM cheat_sheets " +
                "WHERE status=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, status);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}