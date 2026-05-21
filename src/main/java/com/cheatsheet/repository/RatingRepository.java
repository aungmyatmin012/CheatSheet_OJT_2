package com.cheatsheet.repository;

import java.sql.*;
import com.cheatsheet.config.DBConnection;
import com.cheatsheet.model.Rating;

public class RatingRepository {

    Connection con = DBConnection.getConnection();

    // ⭐ INSERT OR UPDATE RATING
    public void saveRating(int cheatSheetId, int userId, int score) {

        String sql =
            "INSERT INTO ratings (cheat_sheet_id, user_id, score) " +
            "VALUES (?, ?, ?) " +
            "ON DUPLICATE KEY UPDATE score = VALUES(score)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cheatSheetId);
            ps.setInt(2, userId);
            ps.setInt(3, score);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ⭐ GET AVERAGE RATING
    public double getAverageRating(int cheatSheetId) {

        String sql =
            "SELECT AVG(score) FROM ratings WHERE cheat_sheet_id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cheatSheetId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // ⭐ GET USER RATING (optional but useful for UI)
    public Integer getUserRating(int cheatSheetId, int userId) {

        String sql =
            "SELECT score FROM ratings WHERE cheat_sheet_id=? AND user_id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cheatSheetId);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("score");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // ⭐ DELETE RATING (optional)
    public void deleteRating(int cheatSheetId, int userId) {

        String sql =
            "DELETE FROM ratings WHERE cheat_sheet_id=? AND user_id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cheatSheetId);
            ps.setInt(2, userId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
   
}