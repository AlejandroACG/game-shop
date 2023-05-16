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

@WebServlet("/search-videogame")
public class SearchVideogameServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String orderBy = request.getParameter("orderBy");

        try {
            Database.connect();
            List<Videogame> videogames;
            if (orderBy.equals("orderByPrice")) {
                videogames = Database.jdbi.withExtension(VideogameDAO.class, dao -> dao.getVideogamesByNamePriceOrderByPrice(name.trim(), price));
            } else {
                videogames = Database.jdbi.withExtension(VideogameDAO.class, dao -> dao.getVideogamesByNamePriceOrderByName(name.trim(), price));
            }
            request.getSession().setAttribute("videogames", videogames);
            response.sendRedirect("videogame-list.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        }
    }
}
