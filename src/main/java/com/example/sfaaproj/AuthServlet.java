package com.example.sfaaproj;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "authServlet", value = "/authenticate")
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
