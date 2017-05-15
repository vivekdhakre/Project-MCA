package edu.mca.servlet;

import com.google.gson.Gson;
import edu.mca.util.DbConnection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Created by vivek on 13/5/17.
 */

@WebServlet("/stats")
public class StatsServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String fdate = request.getParameter("from");
        String tdate = request.getParameter("to");
        String pid = request.getParameter("pid");

        try {

            System.out.println("fdate: " + fdate + " | tdate: " + tdate + " | pid: " + pid);

            HttpSession session = request.getSession();
            String user = (String) session.getAttribute("user");
            String role = (String) session.getAttribute("role");
            if (user != null && !"".equals(user.trim()) && !"null".equalsIgnoreCase(user.trim())
                    && role != null && !"".equals(role.trim()) && !"null".equalsIgnoreCase(role.trim())) {

                Connection cn = DbConnection.getConnection();
                DateFormat format = new SimpleDateFormat("MM/dd/yyyy");
                DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
                DateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                DateFormat format3 = new SimpleDateFormat("dd-MMM-yy");

                Date fd1 = format.parse(fdate);
                Date td1 = format.parse(tdate);

                Date nextD = null;
                int i = 0;
                Map<String, Integer> dateWiseMap = new LinkedHashMap<>();
                Map<String, Integer> cityWiseMap = new LinkedHashMap<>();
                do {
                    Calendar c = Calendar.getInstance();
                    c.setTime(fd1);
                    c.add(Calendar.DATE, i++);
                    nextD = c.getTime();

                    PreparedStatement pst = cn.prepareStatement("select sum(count) from sold where created_on between ? and ?");
                    pst.setTimestamp(1, new java.sql.Timestamp(format2.parse(format2.format(format2.parse(format1.format(nextD) + " 00:00:00"))).getTime()));
                    pst.setTimestamp(2, new java.sql.Timestamp(format2.parse(format2.format(format2.parse(format1.format(nextD) + " 23:59:59"))).getTime()));

                    ResultSet rst = pst.executeQuery();
                    if (rst.next()) {
                        dateWiseMap.put(format3.format(nextD), rst.getInt(1));
                    }

                } while (!td1.equals(nextD));

                PreparedStatement pst = cn.prepareStatement("select city,sum(count) from sold where campaign_fkey=? and created_on between ? and ? group by city");
                pst.setLong(1, Long.valueOf(pid));
                pst.setTimestamp(2, new java.sql.Timestamp(format2.parse(format2.format(format2.parse(format1.format(fd1) + " 00:00:00"))).getTime()));
                pst.setTimestamp(3, new java.sql.Timestamp(format2.parse(format2.format(format2.parse(format1.format(td1) + " 23:59:59"))).getTime()));


                ResultSet rst = pst.executeQuery();
                while (rst.next()) {
                    cityWiseMap.put(rst.getString(1), rst.getInt(2));
                }

                Gson gson = new Gson();

                request.setAttribute("cityWiseMap", gson.toJson(cityWiseMap));
                request.setAttribute("dateWiseMap", gson.toJson(dateWiseMap));

//              Get campaign Name
                PreparedStatement pst1 = cn.prepareStatement("select name from campaign where id=?");
                pst1.setLong(1, Long.valueOf(pid));
                rst = pst1.executeQuery();
                if (rst.next()) request.setAttribute("campaignName", rst.getString(1));


                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsps/stats.jsp");
                rd.forward(request, response);
            } else {
                response.sendRedirect("login?status=true&msg=Session+Expired+or+Invalid");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}