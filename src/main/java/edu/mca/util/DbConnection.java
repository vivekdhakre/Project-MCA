package edu.mca.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Created by vivek on 8/5/17.
 */
public class DbConnection {

    private static Connection connection = null;

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/psd", "root", "root");

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static Connection getConnection(){
        return connection;
    }

    public static void main(String[] args) throws Exception {
        Connection connection = DbConnection.getConnection();
        PreparedStatement pst = connection.prepareStatement("select user_name,password,role from users where user_name=? and password=?");
        pst.setString(1, "admin");
        pst.setString(2, "admin");
        ResultSet rst = pst.executeQuery();
        if (rst.next()) {
            System.out.println(rst.getString(1) + " | " + rst.getString(2) + " | " + rst.getString(3));
        }


    }


}