package com.cheatsheet.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CheatSheet {
	private int id;
    private String title;
    private String summary;
   
    private int categoryId;
    private int userId;
    private String status;
    private int views;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    private Timestamp publishedAt;

    // 🔥 ADD
    private String userName;
    
    // ⭐ ADD THIS
    private double avgRating;

    // 💬 ADD THIS
    private int commentCount;
    
    private String content;


}