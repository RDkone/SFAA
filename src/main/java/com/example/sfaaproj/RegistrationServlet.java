package com.example.sfaaproj;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegistrationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AuthServlet authServlet = new AuthServlet();
        if (authServlet.authenticateUser(request)){
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("welcome.jsp");
            requestDispatcher.forward(request, response);
        }
        else {
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("registration.jsp");
            requestDispatcher.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Add Code for POST parameters with SQL User Creation
        HttpSession session = req.getSession();
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        req.setAttribute("username", username);
        req.setAttribute("email", email);
        req.setAttribute("password", password);
        if (CheckUserExists(username, email, req)){
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("registration.jsp");
            requestDispatcher.forward(req, resp);
        }
        else if (!Validate(username, password, req)) {
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("registration.jsp");
            requestDispatcher.forward(req, resp);
        }
        else {
            try {
                Class.forName("org.postgresql.Driver");
            } catch (ClassNotFoundException e) {
                req.setAttribute("error", "An error occurred attempting to connect to the server.");
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("registration.jsp");
                requestDispatcher.forward(req, resp);
            }
            try (Connection con = DriverManager.getConnection("jdbc:postgresql://cf9gid2f6uallg.cluster-czrs8kj4isg7.us-east-1.rds.amazonaws.com:5432/db7svujot0s1tl", "udlour4ugvrsgl", "pdcdc5d482397bde07cca535fba58801e132f94494547be8e646e5514d1c0fa2d");
                 PreparedStatement ps = con.prepareStatement("INSERT INTO users (username, email, password) VALUES (?, ?, ?) RETURNING user_id")) {
                ps.setString(1, username);
                ps.setString(2, email);
                ps.setString(3, password);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    session.setAttribute("user", username);
                    session.setAttribute("userId", rs.getInt(1));
                    resp.sendRedirect("welcome.jsp");
                }
                else {
                    req.setAttribute("error", "An attempting to register new user.");
                    RequestDispatcher requestDispatcher = req.getRequestDispatcher("registration.jsp");
                    requestDispatcher.forward(req, resp);
                }
            } catch (SQLException | IOException e) {
                req.setAttribute("error", "An error occurred attempting to connect to the server. " + e.getMessage());
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("registration.jsp");
                requestDispatcher.forward(req, resp);
            }
        }


    }
    public boolean CheckUserExists(String username, String email, HttpServletRequest req) throws ServletException, IOException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            req.setAttribute("error", "An error occurred attempting to connect to the server.");
            return true;
        }
        try (Connection con = DriverManager.getConnection("jdbc:postgresql://cf9gid2f6uallg.cluster-czrs8kj4isg7.us-east-1.rds.amazonaws.com:5432/db7svujot0s1tl", "udlour4ugvrsgl", "pdcdc5d482397bde07cca535fba58801e132f94494547be8e646e5514d1c0fa2d");
             PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username = ? OR email = ?")) {
            ps.setString(1, username);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                req.setAttribute("error", "Username or email already exists");
                return true;
            }
        } catch (SQLException e) {
            req.setAttribute("error", "An error occurred attempting to connect to the server");
            return true;
        }
        return false;
    }
    public boolean Validate(String username, String password, HttpServletRequest req) throws ServletException, IOException {
        String regexUsr = "^(?=.*[0-9])"
                + "(?=.*[a-z])"
                + "(?=\\S+$).{6,20}$";
        String regexPw = "^(?=.*[0-9])"
                + "(?=.*[a-z])(?=.*[A-Z])"
                + "(?=.*[@#$%^&+=])"
                + "(?=\\S+$).{8,20}$";
        Pattern p1 = Pattern.compile(regexUsr);
        Pattern p2 = Pattern.compile(regexPw);
        if (username.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "Username or password cannot be empty.");
            return false;
        }
        Matcher m1 = p1.matcher(username);
        Matcher m2 = p2.matcher(password);
        if (!m1.matches()){
            req.setAttribute("error", "Username must be 6-20 characters long.<br/>Must contain at least one digit<br/>Must contain at least one letter<br/>Must contain no spaces.");
            return false;
        }
        if (!m2.matches()){
            req.setAttribute("error", "Password must be 8-20 characters long.<br/>Must contain at least one digit<br/>Must contain at least one uppercase letter<br/>Must contain at least one lowercase letter<br/>Must contain at least one special character<br/>Must contain no white spaces.");
            return false;
        }
        return true;
    }

}
