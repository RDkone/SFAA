package com.example.sfaaproj;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
            try (Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/sfaa", "postgres", "do07Sti=6D@A");
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