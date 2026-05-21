package com.cheatsheet.repository;

import com.cheatsheet.config.DBConnection;
import com.cheatsheet.model.Category;

import java.sql.*;
import java.util.*;

public class CategoryRepository {

    Connection con = DBConnection.getConnection();

    public List<Category> findAll() {

        List<Category> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM categories";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description")); // ✅ ADD THIS
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
 // FIND BY ID
    public Category findById(int id) {

        Category c = null;

        try {
            String sql = "SELECT * FROM categories WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                c = new Category();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return c;
    }
    public boolean update(Category c) {

        boolean success = false;

        try {
            String sql = "UPDATE categories SET name=?, description=? WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, c.getName());
            ps.setString(2, c.getDescription());
            ps.setInt(3, c.getId());

            success = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
 // CREATE
    public boolean save(Category c) {
        try {
            String sql = "INSERT INTO categories(name, description) VALUES(?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, c.getName());
            ps.setString(2, c.getDescription());
            return ps.executeUpdate() > 0;
        } catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }

    // DELETE
    public boolean delete(int id) {
        try {
            String sql = "DELETE FROM categories WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }
    public int countAll() {

        String sql = "SELECT COUNT(*) FROM categories";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

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