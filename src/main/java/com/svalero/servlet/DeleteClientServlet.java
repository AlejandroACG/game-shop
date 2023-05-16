package com.svalero.servlet;
import com.svalero.dao.ClientDAO;
import com.svalero.dao.Database;
import com.svalero.domain.Client;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/delete-client")
public class DeleteClientServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String id = request.getParameter("id");

        if (request.getSession().getAttribute("clients") != null) {
            List<Client> clients = (List<Client>) request.getSession().getAttribute("clients");
            request.getSession().removeAttribute("clients");
            clients.removeIf(p -> p.getId().equals(id));
            request.getSession().setAttribute("clients", clients);
        }

        try {
            Database.connect();
            Database.jdbi.withExtension(ClientDAO.class, dao -> {
                dao.deleteClient(id);
                return null;
            });

            response.sendRedirect("client-list.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        }
    }
}
