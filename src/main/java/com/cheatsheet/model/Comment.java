package com.cheatsheet.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class Comment {
	

	    private int id;
	    private int cheatSheetId;
	    private int userId;
	    private String userName;

	    private String body;
	    private Integer parentId; // IMPORTANT for replies
	    private Timestamp createdAt;

}
