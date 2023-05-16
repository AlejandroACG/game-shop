package com.svalero.servlet;
import com.svalero.dao.Database;
import com.svalero.dao.VideogameDAO;
import com.svalero.domain.Videogame;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/delete-videogame")
public class DeleteVideogameServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String id = request.getParameter("id");

        if (request.getSession().getAttribute("videogames") != null) {
            List<Videogame> videogames = (List<Videogame>) request.getSession().getAttribute("videogames");
            request.getSession().removeAttribute("videogames");
            videogames.removeIf(p -> p.getId().equals(id));
            request.getSession().setAttribute("videogames", videogames);
        }

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
