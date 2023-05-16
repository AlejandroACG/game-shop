package com.svalero.servlet;
import com.svalero.dao.Database;
import com.svalero.dao.ClientDAO;
import com.svalero.domain.Client;
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

@WebServlet("/addedit-client")
@MultipartConfig
public class AddEditClientServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String picturePath = request.getServletContext().getInitParameter("client-pic-path");

        String firstName = request.getParameter("firstName");
        String familyName = request.getParameter("familyName");
        LocalDate birthDate = Utils.dateReverseFormatter(request.getParameter("birthDate"));
        String email = request.getParameter("email");
        String dni = request.getParameter("dni");

        String id, idTemp = null;
        String action = request.getParameter("action");
        if (action.equals("edit")) {
            idTemp = request.getParameter("id");
        }
        id = idTemp;

        boolean deletePicture = request.getParameter("deletePicture") != null;
        Part picturePart = request.getPart("picture");
        String pictureName;

        try {
            Database.connect();
            Client client = Database.jdbi.withExtension(ClientDAO.class, dao -> dao.getClient(id));
            if (picturePart.getSize() == 0 && action.equals("edit") && !deletePicture) {
                pictureName = client.getPicture();
            } else if (picturePart.getSize() == 0 || deletePicture) {
                pictureName = "no_picture.jpg";
            } else {
                pictureName = UUID.randomUUID() + ".jpg";
                InputStream pictureStream = picturePart.getInputStream();
                Files.copy(pictureStream, Path.of(picturePath + File.separator + pictureName));
            }
            if (action.equals("edit")) {
                Database.jdbi.withExtension(ClientDAO.class, dao -> {
                    dao.modifyClient(firstName,familyName, birthDate, email, dni, pictureName, id);
                    return null;
                });
                out.println("<div style='margin-top: 20px;' class='alert alert-success' role='alert'>Client successfully modified.</div>");
            } else {
                Database.jdbi.withExtension(ClientDAO.class, dao -> {
                    dao.addClient(firstName, familyName, birthDate, email, dni, pictureName);
                    return null;
                });
                out.println("<div style='margin-top: 20px;' class='alert alert-success' role='alert'>Client successfully added to database.</div>");
            }
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        }
    }
}
