package edu.mca.util;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Created by vivek on 8/5/17.
 */
public class DbConnection {

    private static Connection connection = null;

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","root");
            System.out.println(connection);

        }catch (Exception e){
            System.out.println(e);
        }
    }

    public static Connection getConnection(){
        return connection;
    }

    public static void main(String[] args) {
        System.out.println(DbConnection.getConnection());
    }


}
