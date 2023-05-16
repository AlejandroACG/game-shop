package com.svalero.servlet;
import com.svalero.dao.Database;
import com.svalero.dao.ClientDAO;
import com.svalero.domain.Client;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/search-client")
public class SearchClientServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String fullName = request.getParameter("fullName");

        try {
            Database.connect();
            List<Client> clients;
            clients = Database.jdbi.withExtension(ClientDAO.class, dao -> dao.getClientsByFullNameOrderByFamilyName(fullName.trim()));

            request.getSession().setAttribute("clients", clients);
            response.sendRedirect("client-list.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        }
    }
}
