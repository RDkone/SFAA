package com.example.sfaaproj;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AuthServlet authServlet = new AuthServlet();
        if (authServlet.authenticateUser(req)){
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("welcome.jsp");
            requestDispatcher.forward(req, resp);
        }
        else {
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("login.jsp");
            requestDispatcher.forward(req, resp);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        if (session.getAttribute("user") == null) {
            try {
                Class.forName("org.postgresql.Driver");
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            try (Connection con = DriverManager.getConnection("jdbc:postgresql://cf9gid2f6uallg.cluster-czrs8kj4isg7.us-east-1.rds.amazonaws.com:5432/db7svujot0s1tl",
                    "udlour4ugvrsgl", "pdcdc5d482397bde07cca535fba58801e132f94494547be8e646e5514d1c0fa2d=6D@A");
                 PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?")) {
                ps.setString(1, username);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    session.setAttribute("user", username);
                    session.setAttribute("userId", rs.getInt("user_id"));
                    response.sendRedirect("welcome.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=true");
                }
            } catch (SQLException e) {
                throw new ServletException("Login error", e);
            }
        } else {
            response.sendRedirect("welcome.jsp");
        }
    }
}