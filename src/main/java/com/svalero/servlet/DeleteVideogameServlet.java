package com.svalero.servlet;
import com.svalero.dao.Database;
import com.svalero.dao.VideogameDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/delete-videogame")
public class DeleteVideogameServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Database.connect();
            Database.jdbi.withExtension(VideogameDAO.class, dao -> {
                dao.deleteVideogame(id);
                return null;
            });

            response.sendRedirect("videogame-list.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        }
    }
}
