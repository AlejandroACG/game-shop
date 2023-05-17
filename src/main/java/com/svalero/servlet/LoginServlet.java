package com.svalero.servlet;
import com.svalero.dao.Database;
import com.svalero.dao.UserDAO;
import com.svalero.domain.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (validateCredentials(username, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    private boolean validateCredentials(String username, String password) {
        try {
            Database.connect();
            UserDAO userDAO = Database.jdbi.onDemand(UserDAO.class);
            User user = userDAO.findUserByUsername(username);
            if (user == null) {
                return false;
            }
            return password.equals(user.getPassword());
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        }
        return false;
    }
}
