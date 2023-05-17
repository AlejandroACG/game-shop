<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.VideogameDAO" %>
<%@ page import="com.svalero.domain.Videogame" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.stream.Collectors" %>

<%@ include file="includes/header.jsp" %>

<%
    session.removeAttribute("videogames");
    session.removeAttribute("clients");
    session.removeAttribute("orders");
%>

<main>
 <div style="margin-top: 20px;" class="container">

  <%
    String id = request.getParameter("id");
    Database.connect();
    VideogameDAO videogameDao = Database.jdbi.onDemand(VideogameDAO.class);
    Videogame videogame = videogameDao.getVideogame(id);
  %>

  <nav>
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="videogame-list.jsp">Videogames</a></li>
      <li class="breadcrumb-item active"><%= videogame.getName() %> (<%= videogame.getReleaseDate().getYear() %>)</li>
    </ol>
  </nav>

    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h2>Videogame details <a href="videogame-form.jsp?id=<%= videogame.getId() %>&action=edit&name=<%= videogame.getName() %>&releaseDate=<%= videogame.getReleaseDate() %>&price=<%= videogame.getPrice() %>" class="btn btn-sm btn-outline-dark">Edit</a><a href="#" class="btn btn-sm btn-outline-danger delete-button" data-id="<%= videogame.getId() %>" data-name="<%= videogame.getName() %>" data-release-date="<%= videogame.getReleaseDate().getYear() %>" data-bs-toggle="modal" data-bs-target="#deleteConfirmationModal">Delete</a></h2>
                <table class="table">
                    <tr>
                        <th>ID</th>
                        <td>#<%= videogame.getId() %></td>
                    </tr>
                    <tr>
                        <th>Title</th>
                        <td><%= videogame.getName() %></td>
                    </tr>
                    <tr>
                        <th>Release date</th>
                        <td><%= videogame.getReleaseDate().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy", Locale.ENGLISH)) %></td>
                    </tr>
                    <tr>
                        <th>Price</th>
                        <td>€<%= videogame.getPrice() %></td>
                    </tr>
                </table>
            </div>
            <div class="col-md-6">
                <img src="../game-shop_data/games/<%= videogame.getPicture() %>" class="img-fluid small-picture">
            </div>
        </div>
    </div>

      <div class="modal fade" id="deleteConfirmationModal" tabindex="-1">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="deleteConfirmationModalLabel">Confirmation required</h5>
            </div>
            <div class="modal-body">
              <p id="deleteConfirmationMessage"></p>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-danger" id="deleteConfirmButton">Delete</button>
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            </div>
          </div>
        </div>
      </div>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const deleteButtons = document.querySelectorAll('.delete-button');
      const deleteConfirmationModal = new bootstrap.Modal(document.getElementById('deleteConfirmationModal'));
      const deleteConfirmationMessage = document.getElementById('deleteConfirmationMessage');
      const deleteConfirmButton = document.getElementById('deleteConfirmButton');
      let videogameId = '';

      deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
          videogameId = this.getAttribute('data-id');
          const name = this.getAttribute('data-name');
          const releaseDate = this.getAttribute('data-release-date');
          deleteConfirmationMessage.textContent = "Do you really want to delete " + name + " (" + releaseDate + ")?";
        });
      });

      deleteConfirmButton.addEventListener('click', function() {
        window.location.href = "delete-videogame?id=" + videogameId;
        deleteConfirmationModal.hide();
      });
    });
  </script>
 </div>
</main>

<%@ include file="includes/footer.jsp" %>
