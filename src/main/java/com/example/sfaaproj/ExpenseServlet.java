package com.example.sfaaproj;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ExpenseServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:postgresql://cf9gid2f6uallg.cluster-czrs8kj4isg7.us-east-1.rds.amazonaws.com:5432/db7svujot0s1tl";
    private static final String DB_USER = "udlour4ugvrsgl";
    private static final String DB_PASSWORD = "pdcdc5d482397bde07cca535fba58801e132f94494547be8e646e5514d1c0fa2d";

    private static final List<String> SYSTEM_CATEGORIES = Arrays.asList(
            "Transportation", "Supplies", "Miscellaneous", "Rent", "Utility Bills", "Food"
    );

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AuthServlet authServlet = new AuthServlet();
        if (!authServlet.authenticateUser(request)){
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("login.jsp");
            requestDispatcher.forward(request, response);
        }
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        int userId = (int) request.getSession().getAttribute("userId");
        if (month == null || year == null) {
            LocalDate currentDate = LocalDate.now();
            month = String.valueOf(currentDate.getMonthValue());
            year = String.valueOf(currentDate.getYear());
        }

        request.setAttribute("month", month);
        request.setAttribute("year", year);

        List<String> customCategories = fetchCustomCategories(userId);
        List<String> allCategories = new ArrayList<>(SYSTEM_CATEGORIES);
        allCategories.addAll(customCategories);
        request.setAttribute("categories", allCategories);

        double monthlySum = getTotalExpenses(userId,year,month);
        System.out.println("DEBUG: MONTHLY SUM = " + monthlySum);
        request.setAttribute("monthlySum", monthlySum);

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "SELECT date,description,category,value FROM expenses WHERE user_id=? AND date_part('month', date::date)=? AND date_part('year', date::date)=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, Integer.parseInt(month));
            stmt.setInt(3, Integer.parseInt(year));
            ResultSet rs = stmt.executeQuery();
            request.setAttribute("expenses", rs);
            request.getRequestDispatcher("expense.jsp").forward(request, response);
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQL Exception
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "create_expense":
                    createExpense(request, response);
                    break;
                case "create_expense_category":
                    createExpenseCategory(request, response);
                    break;
                default:
                    response.sendRedirect("error.jsp");
            }
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    private void createExpense(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        String date = request.getParameter("date");
        String category = request.getParameter("category");
        double value = Double.parseDouble(request.getParameter("value"));
        String description = request.getParameter("description");

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "INSERT INTO expenses (user_id, date, category, value, description) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setString(2, date);
            stmt.setString(3, category);
            stmt.setDouble(4, value);
            stmt.setString(5, description);
            stmt.executeUpdate();
            stmt.close();
            conn.close();
            request.setAttribute("message", "successfully created expenses!");
            doGet(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQL Exception
            response.sendRedirect("error.jsp");
        } catch (ServletException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    private void createExpenseCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        String category = request.getParameter("expense_category");

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "INSERT INTO custom_categories (user_id, category) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setString(2, category);
            stmt.executeUpdate();

            stmt.close();
            conn.close();
            request.setAttribute("message", "successfully added category!");
            doGet(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQL Exception
            response.sendRedirect("error.jsp");
        } catch (ServletException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public List<String> fetchCustomCategories(int userId) {
        List<String> customCategories = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "SELECT category FROM custom_categories WHERE user_id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                customCategories.add(rs.getString("category"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQL Exception
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return customCategories;
    }

    private double getTotalExpenses(int userId, String year, String month) {
        double totalExpenses = 0.0;

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "SELECT SUM(value) AS total FROM expenses WHERE user_id=? AND date_part('year', date::date)=? AND date_part('month', date::date)=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, Integer.parseInt(year));
            stmt.setInt(3, Integer.parseInt(month));
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                totalExpenses = rs.getDouble("total");
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQL Exception
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return totalExpenses;
    }

}

