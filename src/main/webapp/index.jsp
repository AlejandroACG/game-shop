<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.VideogameDAO" %>
<%@ page import="com.svalero.domain.Videogame" %>
<%@ page import="java.util.List" %>


<main>
  <section class="py-5 text-center container">
    <div class="row py-lg-5">
      <div class="col-lg-6 col-md-8 mx-auto">
        <h1 class="fw-light">Game Shop Management</h1>
        <p class="lead text-body-secondary">Manage your Game Shop</p>
        <p>
          <a href="add-videogame.jsp" class="btn btn-primary my-2">Register new videogame</a>
          <a href="add-order.jsp" class="btn btn-secondary my-2">Register new order</a>
        </p>
      </div>
    </div>
  </section>

  <div class="album py-5 bg-body-tertiary">
    <div class="container">

      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        <%
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Database.connect();
            List<Videogame> videogameList = Database.jdbi.withExtension(VideogameDAO.class, VideogameDAO::getVideogames);
            for (Videogame videogame : videogameList) {
        %>
        <div class="col">
          <div class="card shadow-sm">
            <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
            <div class="card-body">
                  <p class="card-text"><%= videogame.getName() %> (<%= videogame.getReleaseDate() %>)</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <a href="videogame-details.jsp?id=<%= videogame.getId() %>" class="btn btn-sm btn-outline-secondary">View</a>
                  <a href="edit-videogame.jsp?id=<%= videogame.getId() %>" class="btn btn-sm btn-outline-secondary">Edit</a>
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
