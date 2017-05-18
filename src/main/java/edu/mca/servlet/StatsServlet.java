package edu.mca.servlet;

import com.google.gson.Gson;
import edu.mca.util.DbConnection;
import edu.mca.util.Response;

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
import java.util.*;

/**
 * Created by vivek on 13/5/17.
 */

@WebServlet("/stats")
public class StatsServlet extends HttpServlet {

    protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String fdate = request.getParameter("from");
        String tdate = request.getParameter("to");
        String pid = request.getParameter("pid");

        try {


            HttpSession session = request.getSession();
            String user = (String) session.getAttribute("user");
            String role = (String) session.getAttribute("role");
            if (user != null && !"".equals(user.trim()) && !"null".equalsIgnoreCase(user.trim())
                    && role != null && !"".equals(role.trim()) && !"null".equalsIgnoreCase(role.trim())) {

                Connection cn = DbConnection.getConnection();
                PreparedStatement preparedStatement = cn.prepareStatement("select name from Stores");
                ResultSet storeRst = preparedStatement.executeQuery();
                List<String> storeList = new ArrayList<>();
                while (storeRst.next()) {
                    storeList.add(storeRst.getString(1));
                }


                DateFormat format = new SimpleDateFormat("MM/dd/yyyy");
                DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
                DateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                DateFormat format3 = new SimpleDateFormat("dd-MMM-yy");

                Date fd1 = format.parse(fdate);
                Date td1 = format.parse(tdate);

                Date nextD = null;
                int i = 0;
                Map<String, String> dateWiseMap = new LinkedHashMap<>();
                Map<String, Integer> cityWiseMap = new LinkedHashMap<>();
                Gson gson = new Gson();

                List<String> datewiseKeys = new LinkedList<>();
                List<Object> datewiseValues = new LinkedList<>();

                Map<String, List<Integer>> mp = new HashMap<>();

                Map<String, List<Response>> dateWiseTableMap = new LinkedHashMap<>();

                do {
                    Calendar c = Calendar.getInstance();
                    c.setTime(fd1);
                    c.add(Calendar.DATE, i++);
                    nextD = c.getTime();

                    PreparedStatement pst = cn.prepareStatement("select store, sum(count),count(*) from sold where created_on between ? and ? group by store");
                    pst.setTimestamp(1, new java.sql.Timestamp(format2.parse(format2.format(format2.parse(format1.format(nextD) + " 00:00:00"))).getTime()));
                    pst.setTimestamp(2, new java.sql.Timestamp(format2.parse(format2.format(format2.parse(format1.format(nextD) + " 23:59:59"))).getTime()));

                    ResultSet rst = pst.executeQuery();

                    Map<String, Integer> map = new LinkedHashMap<>();
                    List<Response> responses = new ArrayList<>();
                    while (rst.next()) {
                        map.put(rst.getString(1), rst.getInt(2));
                        responses.add(new Response(rst.getString(1), rst.getInt(2), rst.getInt(3)));
                    }

                    storeList.forEach(s -> {
                        try {
                            if (mp.containsKey(s)) {
                                List<Integer> lst = mp.get(s);
                                if (map.containsKey(s)) {
                                    lst.add(map.get(s));
                                } else {
                                    lst.add(0);
                                }
                                mp.put(s, lst);
                            } else {
                                List<Integer> lst = new LinkedList<>();
                                if (map.containsKey(s)) {
                                    lst.add(map.get(s));
                                } else {
                                    lst.add(0);
                                }
                                mp.put(s, lst);
                            }
                        } catch (Exception e) {
                        }
                    });

                    datewiseKeys.add(format3.format(nextD));
                    if (responses != null && responses.size() > 0)
                        dateWiseTableMap.put(format3.format(nextD), responses);
                } while (!td1.equals(nextD));

                mp.forEach((m, n) -> {
                    Map<String, Object> map1 = new LinkedHashMap<>();
                    map1.put("name", m);
                    map1.put("data", n);
                    datewiseValues.add(map1);
                });
                request.setAttribute("datewiseKeys", gson.toJson(datewiseKeys));
                request.setAttribute("datewiseValues", gson.toJson(datewiseValues));
                request.setAttribute("dateWiseTableMap", dateWiseTableMap);

                PreparedStatement preparedStatement1 = cn.prepareStatement("select distinct city from sold where campaign_fkey=?");
                preparedStatement1.setLong(1, Long.valueOf(pid.trim()));
                ResultSet citiesRst = preparedStatement1.executeQuery();
                List<String> citywiseKeys = new LinkedList<>();
                List<Object> citywiseValues = new LinkedList<>();

                Map<String, List<Response>> cityWiseTableMap = new LinkedHashMap<>();
                Map<String, List<Integer>> mp1 = new HashMap<>();
                while (citiesRst.next()) {
                    PreparedStatement pst = cn.prepareStatement("select store,sum(count),count(*) from sold where campaign_fkey=? and city=? and created_on between ? and ? group by store");
                    pst.setLong(1, Long.valueOf(pid));
                    pst.setString(2, citiesRst.getString(1));
                    pst.setTimestamp(3, new java.sql.Timestamp(format2.parse(format2.format(format2.parse(format1.format(fd1) + " 00:00:00"))).getTime()));
                    pst.setTimestamp(4, new java.sql.Timestamp(format2.parse(format2.format(format2.parse(format1.format(td1) + " 23:59:59"))).getTime()));
                    ResultSet rst = pst.executeQuery();

                    Map<String, Integer> map = new LinkedHashMap<>();

                    List<Response> responses = new ArrayList<>();
                    while (rst.next()) {
                        map.put(rst.getString(1), rst.getInt(2));
                        responses.add(new Response(rst.getString(1), rst.getInt(2), rst.getInt(3)));

                    }

                    storeList.forEach(s -> {
                        if (mp1.containsKey(s)) {
                            List<Integer> lst = mp1.get(s);
                            if (map.containsKey(s)) {
                                lst.add(map.get(s));
                            } else {
                                lst.add(0);
                            }
                            mp1.put(s, lst);
                        } else {
                            List<Integer> lst = new LinkedList<>();
                            if (map.containsKey(s)) {
                                lst.add(map.get(s));
                            } else {
                                lst.add(0);
                            }
                            mp1.put(s, lst);
                        }

                    });
                    citywiseKeys.add(citiesRst.getString(1));
                    if (responses != null && responses.size() > 0)
                        cityWiseTableMap.put(citiesRst.getString(1), responses);
                }

                mp1.forEach((m, n) -> {
                    Map<String, Object> map1 = new LinkedHashMap<>();
                    System.out.println("m: " + m + " | n: " + n);
                    map1.put("name", m);
                    map1.put("data", n);
                    citywiseValues.add(map1);
                });
                request.setAttribute("citywiseKeys", gson.toJson(citywiseKeys));
                request.setAttribute("citywiseValues", gson.toJson(citywiseValues));
                request.setAttribute("cityWiseTableMap", cityWiseTableMap);

//              Get campaign Name
                PreparedStatement pst1 = cn.prepareStatement("select name from campaign where id=?");
                pst1.setLong(1, Long.valueOf(pid));
                ResultSet rst = pst1.executeQuery();
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        process(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        process(request, response);
    }

}