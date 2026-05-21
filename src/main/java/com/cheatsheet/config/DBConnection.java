package com.cheatsheet.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
  
  static Connection con=null;//static object
  
  public static void main(String args[]) {
    Connection con=getConnection();
    
     if(con != null) {
       System.out.println("Connection is working");
     }
  }
  
  public static Connection getConnection() { //static method
    
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      String db="jdbc:mysql://localhost:3306/cheatsheet_db";
      String user="root";
      String password="179238";
      
      con=DriverManager.getConnection(db,user,password);
      System.out.println("Database connection is Oki!");
    }catch(ClassNotFoundException e){
      System.out.println("Jdbc Driver not found");
    }catch(SQLException e){
      System.out.println("Database connection fail: "+e);
    }
    return con;
  }
}