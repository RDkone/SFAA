package com.example.sfaaproj;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class TuitionServlet extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        AuthServlet authServlet = new AuthServlet();
        if (authServlet.authenticateUser(req)){
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/tuition-estimator.jsp");
            requestDispatcher.forward(req, resp);
        }
        else {
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/login.jsp");
            requestDispatcher.forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getParameter("tData") != null) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            ServletContext context = getServletContext();
            InputStream stream = context.getResourceAsStream("/WEB-INF/InstitutionData.txt");
            InputStreamReader isr = new InputStreamReader(stream);
            char[] charArr = new char[stream.available()];
            isr.read(charArr);
            String contents = new String(charArr);
            resp.getWriter().write(contents);
        }
        else {
            doGet(req, resp);
        }
    }

    public void destroy() {
    }
}
