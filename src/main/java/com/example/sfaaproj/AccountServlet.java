package com.example.sfaaproj;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class AccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        AuthServlet authServlet = new AuthServlet();
        if (authServlet.authenticateUser(req)){
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("account.jsp");
            requestDispatcher.forward(req, resp);
        }
        else {
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("login.jsp");
            requestDispatcher.forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
