<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.ClientDAO" %>
<%@ page import="com.svalero.domain.Client" %>
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
    ClientDAO clientDao = Database.jdbi.onDemand(ClientDAO.class);
    Client client = clientDao.getClient(id);
  %>

  <nav>
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="client-list.jsp">Clients</a></li>
      <li class="breadcrumb-item active"><%= client.getFamilyName() %>, <%= client.getFirstName() %></li>
    </ol>
  </nav>

    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h2>Client details <a href="client-form.jsp?id=<%= client.getId() %>&action=edit&firstName=<%= client.getFirstName() %>&familyName=<%= client.getFamilyName() %>&birthDate=<%= client.getBirthDate() %>&email=<%= client.getEmail() %>&dni=<%= client.getDni() %>" class="btn btn-sm btn-outline-dark">Edit</a><a href="#" class="btn btn-sm btn-outline-danger delete-button" data-id="<%= client.getId() %>" data-first-name="<%= client.getFirstName() %>" data-family-name="<%= client.getFamilyName() %>" data-dni="<%= client.getDni() %>" data-bs-toggle="modal" data-bs-target="#deleteConfirmationModal">Delete</a></h2>
                <table class="table">
                    <tr>
                        <th>ID</th>
                        <td>#<%= client.getId() %></td>
                    </tr>
                    <tr>
                        <th>First name</th>
                        <td><%= client.getFirstName() %></td>
                    </tr>
                    <tr>
                        <th>Last name</th>
                        <td><%= client.getFamilyName() %></td>
                    </tr>
                    <tr>
                        <th>Birthdate</th>
                        <td><%= client.getBirthDate().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy", Locale.ENGLISH)) %></td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td><%= client.getEmail() %></td>
                    </tr>
                    <tr>
                        <th>DNI</th>
                        <td><%= client.getDni() %></td>
                    </tr>
                </table>
            </div>
            <div class="col-md-6">
                <img src="../game-shop_data/clients/<%= client.getPicture() %>" class="img-fluid small-picture">
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
      let clientId = '';

      deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
          clientId = this.getAttribute('data-id');
          const firstName = this.getAttribute('data-first-name');
          const familyName = this.getAttribute('data-family-name');
          const dni = this.getAttribute('data-dni');
          deleteConfirmationMessage.textContent = "Do you really want to delete " + firstName + " " + familyName + " (" + dni + ")?";
        });
      });

      deleteConfirmButton.addEventListener('click', function() {
        window.location.href = "delete-client?id=" + clientId;
        deleteConfirmationModal.hide();
      });
    });
  </script>
 </div>
</main>

<%@ include file="includes/footer.jsp" %>
