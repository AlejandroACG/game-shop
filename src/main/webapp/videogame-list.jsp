<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.VideogameDAO" %>
<%@ page import="com.svalero.domain.Videogame" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.stream.Collectors" %>

<%@ include file="includes/header.jsp" %>

<% session.removeAttribute("clients"); %>

<main>
  <section class="py-5 text-center container">
    <div class="row py-lg-5">
      <div class="col-lg-6 col-md-8 mx-auto">
        <h1 class="fw-light">Game Shop Management</h1>
        <p>
          <a href="videogame-form.jsp?action=register" class="btn btn-primary my-2">Add videogame</a>
        </p>
        <p class="lead text-body-secondary">or</p>
        <p class="lead text-body-secondary">Search videogames</p>
        <%
            Database.connect();
            List<Videogame> videogames = Database.jdbi.withExtension(VideogameDAO.class, VideogameDAO::getVideogamesOrderByName);
        %>
        <form class="row g-3" method="post" action="search-videogame">
            <div class="col-md-6 mx-auto text-center">
                <label for="name" class="form-label">Name</label>
                <input type="text" class="form-control" id="name" name="name">
            </div>
            <label for="slider">Maximum price</label>
            <span id="current-price"><%= Database.jdbi.withExtension(VideogameDAO.class, VideogameDAO::getMaxPrice) %></span>
            <input type="range" id="price" name="price" min="0" max='<%= Database.jdbi.withExtension(VideogameDAO.class, VideogameDAO::getMaxPrice) %>' step="1" value="<%= Database.jdbi.withExtension(VideogameDAO.class, VideogameDAO::getMaxPrice) %>">
            <div class="d-flex align-items-center justify-content-center">
                <div class="form-check d-inline-flex me-3">
                    <input class="form-check-input" type="radio" name="orderBy" id="orderByName" value="orderByName" checked>
                    <label class="form-check-label ms-2" for="orderByName">
                        Order by name
                    </label>
                </div>
                <div class="form-check d-inline-flex">
                    <input class="form-check-input" type="radio" name="orderBy" id="orderByPrice" value="orderByPrice">
                    <label class="form-check-label ms-2" for="orderByPrice">
                        Order by price
                    </label>
                </div>
            </div>
            <div>
                <input type="submit" value="Search"/>
            </div>
        </form>
      </div>
    </div>
  </section>

  <script>
    var slider = document.getElementById('price');
    var sliderValue = document.getElementById('current-price');
    slider.addEventListener('input', function() {
      sliderValue.textContent = slider.value;
    });
  </script>

  <div class="album py-5 bg-body-tertiary">
    <div class="container">
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        <%
            int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
            int recordsPerPage = 9;
            int initialValue = (currentPage - 1) * recordsPerPage + 1;
            int finalValue = currentPage * recordsPerPage;

            if (session.getAttribute("videogames") != null) {
                videogames = (List<Videogame>) session.getAttribute("videogames");
            }

            List<Videogame> paginatedVideogames = videogames.stream()
                .skip(initialValue - 1)
                .limit(recordsPerPage)
                .collect(Collectors.toList());

            for (Videogame videogame : paginatedVideogames) {
        %>
        <div class="col">
          <div class="card shadow-sm">
            <img src="../game-shop_data/games/<%= videogame.getPicture() %>" class="bd-placeholder-img card-img-top"/>
            <div class="card-body">
              <p class="card-text"><%= videogame.getName() %> (<%= videogame.getReleaseDate().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy", Locale.ENGLISH)) %>)</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <a href="videogame-details.jsp?id=<%= videogame.getId() %>" class="btn btn-sm btn-outline-secondary">View</a>
                  <a href="videogame-form.jsp?id=<%= videogame.getId() %>&action=edit&name=<%= videogame.getName() %>&releaseDate=<%= videogame.getReleaseDate() %>&price=<%= videogame.getPrice() %>" class="btn btn-sm btn-outline-dark">Edit</a>
                  <a href="#" class="btn btn-sm btn-outline-danger delete-button" data-id="<%= videogame.getId() %>" data-name="<%= videogame.getName() %>" data-release-date="<%= videogame.getReleaseDate().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy", Locale.ENGLISH)) %>" data-bs-toggle="modal" data-bs-target="#deleteConfirmationModal">Delete</a>
                </div>
                <small class="text-body-secondary">€<%= videogame.getPrice() %></small>
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
                int totalPages = (int) Math.ceil((double)videogames.size() / recordsPerPage);
                if (totalPages > 1) {
                    for (int i = 1; i <= totalPages; i++) {
                        if (currentPage == i) {
            %>
            <li class="page-item active">
              <a class="page-link" href="#"><%= i %></a>
            </li>
            <% } else { %>
            <li class="page-item">
              <a class="page-link" href="videogame-list.jsp?page=<%= i %>"><%= i %></a>
            </li>
            <%
                        }
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
      let deleteVideoGameId = '';

      deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
          deleteVideoGameId = this.getAttribute('data-id');
          const name = this.getAttribute('data-name');
          const releaseDate = this.getAttribute('data-release-date');
          deleteConfirmationMessage.textContent = "Do you really want to delete " + name + " (" + releaseDate + ")?";
        });
      });

      deleteConfirmButton.addEventListener('click', function() {
        window.location.href = "delete-videogame?id=" + deleteVideoGameId;
        deleteConfirmationModal.hide();
      });
    });
  </script>
</main>
<%@ include file="includes/footer.jsp" %>
