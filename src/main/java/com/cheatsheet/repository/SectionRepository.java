package com.cheatsheet.repository;

import com.cheatsheet.config.DBConnection;
import com.cheatsheet.model.Section;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SectionRepository {

    // =========================================
    // SAVE SECTION
    // =========================================

    public void save(Section s) {

        String sql =
                "INSERT INTO cheat_sheet_sections " +
                "(cheatsheet_id, section_title, section_content, sort_order) " +
                "VALUES (?, ?, ?, ?)";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, s.getCheatSheetId());
            ps.setString(2, s.getTitle());
            ps.setString(3, s.getContent());
            ps.setInt(4, s.getSortOrder());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =========================================
    // FIND BY CHEATSHEET ID
    // =========================================

    public List<Section> findByCheatSheetId(int cheatSheetId) {

        List<Section> list = new ArrayList<>();

        String sql =
                "SELECT * FROM cheat_sheet_sections " +
                "WHERE cheatsheet_id=? " +
                "ORDER BY sort_order ASC";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, cheatSheetId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Section s = new Section();

                s.setId(rs.getInt("id"));
                s.setCheatSheetId(rs.getInt("cheatsheet_id"));

                s.setTitle(rs.getString("section_title"));
                s.setContent(rs.getString("section_content"));

                s.setSortOrder(rs.getInt("sort_order"));

                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =========================================
    // DELETE BY CHEATSHEET
    // =========================================

    public void deleteByCheatSheetId(int cheatSheetId) {

        String sql =
                "DELETE FROM cheat_sheet_sections " +
                "WHERE cheatsheet_id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, cheatSheetId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}