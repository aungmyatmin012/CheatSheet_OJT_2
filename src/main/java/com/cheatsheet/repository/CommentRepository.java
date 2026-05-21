package com.cheatsheet.repository;

import java.sql.*;
import java.util.*;

import com.cheatsheet.config.DBConnection;
import com.cheatsheet.model.Comment;

public class CommentRepository {

    // ADD COMMENT
    public void addComment(int cheatSheetId,
                           int userId,
                           String body,
                           Integer parentId) {

        if (body == null || body.trim().isEmpty()) return;

        String sql = "INSERT INTO comments " +
                "(cheat_sheet_id, user_id, body, parent_id) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cheatSheetId);
            ps.setInt(2, userId);
            ps.setString(3, body.trim());

            if (parentId == null) {
                ps.setNull(4, Types.INTEGER);
            } else {
                ps.setInt(4, parentId);
            }

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // DELETE COMMENT
    public void deleteComment(int commentId, int userId) {

        String sql = "DELETE FROM comments WHERE id=? AND user_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, commentId);
            ps.setInt(2, userId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // GET COMMENTS
    public List<Comment> getComments(int cheatSheetId) {

        List<Comment> list = new ArrayList<>();

        String sql = "SELECT c.*, u.name AS userName " +
                "FROM comments c " +
                "JOIN users u ON c.user_id = u.id " +
                "WHERE c.cheat_sheet_id=? " +
                "ORDER BY c.created_at ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cheatSheetId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Comment c = new Comment();

                c.setId(rs.getInt("id"));
                c.setCheatSheetId(rs.getInt("cheat_sheet_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setUserName(rs.getString("userName"));
                c.setBody(rs.getString("body"));

                Object parentObj = rs.getObject("parent_id");
                c.setParentId(parentObj != null ? rs.getInt("parent_id") : null);

                c.setCreatedAt(rs.getTimestamp("created_at"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}