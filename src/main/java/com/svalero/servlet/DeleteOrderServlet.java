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

@WebServlet("/delete-order")
public class DeleteOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String id = request.getParameter("id");

        if (request.getSession().getAttribute("orders") != null) {
            List<Order> orders = (List<Order>) request.getSession().getAttribute("orders");
            request.getSession().removeAttribute("orders");
            orders.removeIf(p -> p.getId().equals(id));
            request.getSession().setAttribute("orders", orders);
        }

        try {
            Database.connect();
            Database.jdbi.withExtension(OrderDAO.class, dao -> {
                dao.deleteOrder(id);
                return null;
            });

            response.sendRedirect("order-list.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        }
    }
}
