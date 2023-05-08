<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.VideogameDAO" %>
<%@ page import="com.svalero.domain.Videogame" %>

<%@ include file="includes/header.jsp" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    try {
    Database.connect();
    } catch (ClassNotFoundException cnfe) {
        cnfe.printStackTrace();
    }
    Videogame videogame = Database.jdbi.withExtension(VideogameDAO.class, dao -> dao.getVideogame(id));
%>
<div class="container">
    <div class="card mb-3">
      <img src="..." class="card-img-top" alt="...">
      <div class="card-body">
        <h5 class="card-title"><%= videogame.getName() %></h5>
        <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
        <p class="card-text"><small class="text-body-secondary">Last updated 3 mins ago</small></p>
      </div>
    </div>
</div>
<%@ include file="includes/footer.jsp" %>