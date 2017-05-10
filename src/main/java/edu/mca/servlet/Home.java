package edu.mca.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by vivek on 10/5/17.
 */

@WebServlet("/home")
public class Home extends HttpServlet {

    protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            out.println("Login Success");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        process(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        process(request, response);
    }
}
