package com.example.sfaaproj;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

public class AccountServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:postgresql://cf9gid2f6uallg.cluster-czrs8kj4isg7.us-east-1.rds.amazonaws.com:5432/db7svujot0s1tl";
    private static final String DB_USER = "udlour4ugvrsgl";
    private static final String DB_PASSWORD = "pdcdc5d482397bde07cca535fba58801e132f94494547be8e646e5514d1c0fa2d";
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        AuthServlet authServlet = new AuthServlet();
        if (authServlet.authenticateUser(req)){
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/account.jsp");
            requestDispatcher.forward(req, resp);
        }
        else {
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/login.jsp");
            requestDispatcher.forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int userId = (int) req.getSession().getAttribute("userId");
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = null;
            if (req.getParameter("updType").contains("upd")){
                if (req.getParameter("updType").equals("updPersonal")){
                    sql = "UPDATE users SET full_name = ?, email = ? WHERE user_id = ?";
                }
                if (req.getParameter("updType").equals("updFinancial")){
                    sql = "UPDATE users SET bank_acc_num = ?, credit_card_num = ? WHERE user_id = ?";
                }
                if (req.getParameter("updType").equals("updAcademic")){
                    sql = "UPDATE users SET major = ?, gpa = ? WHERE user_id = ?";
                }
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, req.getParameter("updVal1"));
                ps.setString(2, req.getParameter("updVal2"));
                ps.setInt(3, userId);
                ps.executeUpdate();
                ps.close();
                conn.close();
                resp.getWriter().write("Success");
            }
            if (!req.getParameter("updType").contains("upd")){
                sql = "SELECT * FROM USERS WHERE user_id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    String returnVal = "";
                    if (req.getParameter("updType").equals("fullName")) {
                        returnVal = rs.getString("full_name");
                    }
                    if (req.getParameter("updType").equals("email")) {
                        returnVal = rs.getString("email");
                    }
                    if (req.getParameter("updType").equals("bankAccount")) {
                        returnVal = rs.getString("bank_acc_num");
                    }
                    if (req.getParameter("updType").equals("creditCard")) {
                        returnVal = rs.getString("credit_card_num");
                    }
                    if (req.getParameter("updType").equals("major")) {
                        returnVal = rs.getString("major");
                    }
                    if (req.getParameter("updType").equals("gpa")) {
                        returnVal = rs.getString("gpa");
                    }
                    if (returnVal == null){
                        returnVal = "N/A";
                    }
                    resp.getWriter().write(returnVal);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            resp.getWriter().write("Error");
        }
    }
}
