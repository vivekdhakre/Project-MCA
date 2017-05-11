package edu.mca.servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by vivek on 10/5/17.
 */

@WebServlet("/home")
public class Home extends HttpServlet {

    protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            String user = (String) session.getAttribute("user");
            String role = (String) session.getAttribute("role");
            if (user != null && !"".equals(user.trim()) && !"null".equalsIgnoreCase(user.trim())
                    && role != null && !"".equals(role.trim()) && !"null".equalsIgnoreCase(role.trim())) {

                RequestDispatcher rd = request.getRequestDispatcher("/stats.jsp");
                rd.forward(request, response);
            } else {
                response.sendRedirect("login?status=true&msg=Session+Expired+or+Invalid");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        process(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        process(request, response);
    }
}
