package com.svalero.servlet;
import com.svalero.dao.Database;
import com.svalero.dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

@WebServlet("/add-order")
@MultipartConfig
public class AddOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String videogameId = request.getParameter("videogameId");
        String clientId = request.getParameter("clientId");
        LocalDate orderDate = LocalDate.now();

        try {
            Database.connect();
            Database.jdbi.withExtension(OrderDAO.class, dao -> {
                dao.addOrder(clientId, videogameId, orderDate);
                return null;
            });
            out.println("<div style='margin-top: 20px;' class='alert alert-success' role='alert'>Order successfully added to database.</div>");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        }
    }
}
