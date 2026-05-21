package com.cheatsheet.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class Rating {
	

	 private int userId;
	    private int cheatSheetId;
	    private int score;

	    private Timestamp createdAt;
	    private Timestamp updatedAt;

}
