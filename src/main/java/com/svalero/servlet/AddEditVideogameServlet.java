package com.svalero.servlet;
import com.svalero.dao.Database;
import com.svalero.dao.VideogameDAO;
import com.svalero.domain.Videogame;
import com.svalero.util.Utils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDate;
import java.util.UUID;

@WebServlet("/edit-videogame")
@MultipartConfig
public class AddEditVideogameServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String picturePath = request.getServletContext().getInitParameter("game-pic-path");

        String name = request.getParameter("name");
        LocalDate releaseDate = Utils.dateReverseFormatter(request.getParameter("releaseDate"));
        double price = Double.parseDouble(request.getParameter("price"));

        int id, idTemp = 0;
        String action = request.getParameter("action");
        if (action.equals("edit")) {
            idTemp = Integer.parseInt(request.getParameter("id"));
        }
        id = idTemp;

        boolean deletePicture = request.getParameter("deletePicture") != null;
        Part picturePart = request.getPart("picture");
        String pictureName;

        try {
            Database.connect();
            Videogame videogame = Database.jdbi.withExtension(VideogameDAO.class, dao -> dao.getVideogame(id));
            if (picturePart.getSize() == 0 && action.equals("edit") && !deletePicture) {
                pictureName = videogame.getPicture();
            } else if (picturePart.getSize() == 0 || deletePicture) {
                pictureName = "no_picture.jpg";
            } else {
                pictureName = UUID.randomUUID() + ".jpg";
                InputStream pictureStream = picturePart.getInputStream();
                Files.copy(pictureStream, Path.of(picturePath + File.separator + pictureName));
            }
            if (action.equals("edit")) {
                Database.jdbi.withExtension(VideogameDAO.class, dao -> {
                    dao.modifyVideogame(name, releaseDate, price, pictureName, id);
                    return null;
                });
                out.println("<div style='margin-top: 20px;' class='alert alert-success' role='alert'>Videogame successfully modified.</div>");
            } else {
                Database.jdbi.withExtension(VideogameDAO.class, dao -> {
                    dao.addVideogame(name, releaseDate, price, pictureName);
                    return null;
                });
                out.println("<div style='margin-top: 20px;' class='alert alert-success' role='alert'>Videogame successfully added to database.</div>");
            }
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        }
    }
}
