package com.example.sfaaproj;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AuthServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("user") == null){
            resp.getWriter().write("Unauthorized");
        }
        else {
            resp.getWriter().write(session.getAttribute("user").toString());
        }
    }
    public boolean authenticateUser(HttpServletRequest req) {
        System.out.println("Check Authenticate");
        HttpSession session = req.getSession();
        return session.getAttribute("user") != null;
    }
}
