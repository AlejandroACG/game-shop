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
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/search-videogame")
public class SearchVideogameServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));

        try {
            Database.connect();
            List<Videogame> videogames;
            videogames = Database.jdbi.withExtension(VideogameDAO.class, dao -> dao.getVideogamesByNamePrice(name.trim(), price));

            request.setAttribute("videogames", videogames);
            request.getRequestDispatcher("videogame-list.jsp").forward(request, response);
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        }
    }
}
