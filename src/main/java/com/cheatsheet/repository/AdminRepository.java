package com.cheatsheet.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.cheatsheet.config.DBConnection;

public class AdminRepository {

    Connection con = DBConnection.getConnection();

    public void log(int cheatSheetId, int adminId, String action, String comment) {

        String sql = "INSERT INTO cheat_sheet_moderation(cheat_sheet_id, admin_id, action, comment) " +
                     "VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cheatSheetId);
            ps.setInt(2, adminId);
            ps.setString(3, action);
            ps.setString(4, comment);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
