<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.VideogameDAO" %>
<%@ page import="com.svalero.domain.Videogame" %>
<%@ page import="java.util.List" %>

<%@ include file="includes/header.jsp" %>
<main>
  <section class="py-5 text-center container">
    <div class="row py-lg-5">
      <div class="col-lg-6 col-md-8 mx-auto">
        <h1 class="fw-light">Game Shop Management</h1>
        <p class="lead text-body-secondary">Manage our videogames</p>
        <p>
          <a href="videogame-form.jsp?action=register" class="btn btn-primary my-2">Add videogame</a>
        </p>
      </div>
    </div>
  </section>

  <div class="album py-5 bg-body-tertiary">
    <div class="container">
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        <%
            Database.connect();
            List<Videogame> videogameList = Database.jdbi.withExtension(VideogameDAO.class, VideogameDAO::getVideogames);
            for (Videogame videogame : videogameList) {
        %>
        <div class="col">
          <div class="card shadow-sm">
            <img src="../game-shop_data/games/<%= videogame.getPicture() %>" class="bd-placeholder-img card-img-top"/>
            <div class="card-body">
                  <p class="card-text"><%= videogame.getName() %> (<%= videogame.getReleaseDate() %>)</p>
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
