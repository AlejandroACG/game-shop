<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.ClientDAO" %>
<%@ page import="com.svalero.domain.Client" %>
<%@ page import="com.svalero.util.Utils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.stream.Collectors" %>

<%@ include file="includes/header.jsp" %>
<main>
  <% session.removeAttribute("videogames"); %>
  <section class="py-5 text-center container">
    <div class="row py-lg-5">
      <div class="col-lg-6 col-md-8 mx-auto">
        <h1 class="fw-light">Game Shop Management</h1>
        <p>
          <a href="client-form.jsp?action=register" class="btn btn-primary my-2">Add client</a>
        </p>
        <p class="lead text-body-secondary">or</p>
        <p class="lead text-body-secondary">Search clients</p>

        <form class="row g-3" method="post" action="search-client">
            <div class="col-md-6 mx-auto text-center">
                <label for="fullName" class="form-label">Name</label>
                <input type="text" class="form-control" id="fullName" name="fullName">
            </div>
            <div>
                <input type="submit" value="Search"/>
            </div>
        </form>
      </div>
    </div>
  </section>

  <div class="album py-5 bg-body-tertiary">
    <div class="container">
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        <%
            Database.connect();
            List<Client> clients = Database.jdbi.withExtension(ClientDAO.class, ClientDAO::getClientsOrderByFamilyName);

            int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
            int recordsPerPage = 9;
            int initialValue = (currentPage - 1) * recordsPerPage + 1;
            int finalValue = currentPage * recordsPerPage;

            if (session.getAttribute("clients") != null) {
                clients = (List<Client>) session.getAttribute("clients");
            }

            List<Client> paginatedClients = clients.stream()
                .skip(initialValue - 1)
                .limit(recordsPerPage)
                .collect(Collectors.toList());

            for (Client client : paginatedClients) {
        %>
        <div class="col">
          <div class="card shadow-sm">
            <img src="../game-shop_data/clients/<%= client.getPicture() %>" class="bd-placeholder-img card-img-top"/>
            <div class="card-body">
              <p class="card-text"><%= client.getFamilyName() %>, <%= client.getFirstName() %> (<%= client.getDni() %>)</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <a href="client-details.jsp?id=<%= client.getId() %>" class="btn btn-sm btn-outline-secondary">View</a>
                  <a href="client-form.jsp?id=<%= client.getId() %>&action=edit&firstName=<%= client.getFirstName() %>&familyName=<%= client.getFamilyName() %>&birthDate=<%= client.getBirthDate() %>&email=<%= client.getEmail() %>&dni=<%= client.getDni() %>" class="btn btn-sm btn-outline-dark">Edit</a>
                  <a href="#" class="btn btn-sm btn-outline-danger delete-button" data-id="<%= client.getId() %>" data-first-name="<%= client.getFirstName() %>" data-family-name="<%= client.getFamilyName() %>" data-dni="<%= client.getDni() %>" data-bs-toggle="modal" data-bs-target="#deleteConfirmationModal">Delete</a>
                </div>
                <small class="text-body-secondary"><%= Utils.getAge(client.getBirthDate()) %>yo</small>
              </div>
            </div>
          </div>
        </div>
        <%
            }
        %>
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

      <div class="d-flex justify-content-center">
        <nav>
          <ul class="pagination">
            <%
              int totalPages = (int) Math.ceil((double)clients.size() / recordsPerPage);

              for (int i = 1; i <= totalPages; i++) {
                if (currentPage == i) {
            %>
            <li class="page-item active">
              <a class="page-link" href="#"><%= i %></a>
            </li>
            <% } else { %>
            <li class="page-item">
              <a class="page-link" href="client-list.jsp?page=<%= i %>"><%= i %></a>
            </li>
            <%
                }
              }
            %>
          </ul>
        </nav>
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
</main>
<%@ include file="includes/footer.jsp" %>
