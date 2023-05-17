package com.svalero.servlet;
import com.svalero.dao.Database;
import com.svalero.dao.OrderDAO;
import com.svalero.domain.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/search-order")
public class SearchOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String clientFullName = request.getParameter("clientFullName");
        String videogameName = request.getParameter("videogameName");

        try {
            Database.connect();
            List<Order> orders;
            orders = Database.jdbi.withExtension(OrderDAO.class, dao -> dao.getOrdersByBothFullNames(clientFullName, videogameName));
            request.getSession().setAttribute("orders", orders);
            response.sendRedirect("order-list.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        }
    }
}
