package com.cheatsheet.model;



import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Section {
    private int id;
    private int cheatSheetId;
    private String title;
    private String content;
    private int sortOrder;

    // getters & setters
}
