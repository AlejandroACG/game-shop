<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.VideogameDAO" %>
<%@ page import="com.svalero.domain.Videogame" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>

<%@ include file="includes/header.jsp" %>
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
            List<Videogame> videogames = Database.jdbi.withExtension(VideogameDAO.class, VideogameDAO::getVideogames);
        %>
        <form class="row g-3" method="post" action="search-videogame">
            <div class="col-md-6 mx-auto text-center">
                <label for="name" class="form-label">Name</label>
                <input type="text" class="form-control" id="name" name="name">
            </div>
            <label for="slider">Maximum price</label>
            <span id="current-price"><%= Database.jdbi.withExtension(VideogameDAO.class, VideogameDAO::getMaxPrice) %></span>
            <input type="range" id="price" name="price" min="0" max='<%= Database.jdbi.withExtension(VideogameDAO.class, VideogameDAO::getMaxPrice) %>' step="1" value="<%= Database.jdbi.withExtension(VideogameDAO.class, VideogameDAO::getMaxPrice) %>">
            <input type="submit" value="Search"/>
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
            if (request.getAttribute("videogames") != null) {
                videogames = (List<Videogame>) request.getAttribute("videogames");
            }
            for (Videogame videogame : videogames) {
        %>
        <div class="col">
          <div class="card shadow-sm">
            <img src="../game-shop_data/games/<%= videogame.getPicture() %>" class="bd-placeholder-img card-img-top"/>
            <div class="card-body">
                  <p class="card-text"><%= videogame.getName() %> (<%= videogame.getReleaseDate().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy", Locale.ENGLISH)) %>)</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <a href="videogame-details.jsp?id=<%= videogame.getId() %>" class="btn btn-sm btn-outline-secondary">View</a>
                  <a href="videogame-form.jsp?id=<%= videogame.getId() %>&action=edit&name=<%= videogame.getName() %>&releaseDate=<%= videogame.getReleaseDate() %>&price=<%= videogame.getPrice() %>" class="btn btn-sm btn-outline-secondary">Edit</a>
                  <a href="delete-videogame?id=<%= videogame.getId() %>" class="btn btn-sm btn-outline-warning">Delete</a>
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
    </div>
  </div>
</main>
<%@ include file="includes/footer.jsp" %>
