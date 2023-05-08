package com.svalero.servlet;
import com.svalero.dao.Database;
import com.svalero.dao.VideogameDAO;
import com.svalero.util.Utils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

@WebServlet("/insert-videogame")
public class AddVideogameServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        LocalDate releaseDate = Utils.dateReverseFormatter(request.getParameter("releaseDate"));
        double price = Double.parseDouble(request.getParameter("price"));

        try {
            Database.connect();
            Database.jdbi.withExtension(VideogameDAO.class, dao -> {
                dao.addVideogame(name, releaseDate, price);
                return null;
            });
            out.println("<div style='margin-top: 20px;' class='alert alert-success' role='alert'>Videogame successfully added to database.</div>");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        }
    }
}
