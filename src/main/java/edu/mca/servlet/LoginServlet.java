package edu.mca.servlet;

import edu.mca.util.DbConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Created by vivek on 10/5/17.
 */
@WebServlet("/loginservlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            if (userName != null && !userName.trim().equals("")
                    && password != null && !password.trim().equals("")) {

                Connection connection = DbConnection.getConnection();
                PreparedStatement pst = connection.prepareStatement("select user_name,password,role from users where user_name=? and password=?");
                pst.setString(1, userName);
                pst.setString(2, password);
                ResultSet rst = pst.executeQuery();
                if (rst != null && rst.next()) {
                    response.sendRedirect("home");
                } else {
                    response.sendRedirect("login?status=true");
                }
            } else {
                response.sendRedirect("login?status=true");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}