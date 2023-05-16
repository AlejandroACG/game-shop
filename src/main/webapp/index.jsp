<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.VideogameDAO" %>
<%@ page import="com.svalero.domain.Videogame" %>
<%@ page import="java.util.List" %>

<%@ include file="includes/header.jsp" %>

<% session.removeAttribute("videogames"); %>

<main>
  <section class="py-5 text-center container">
    <div class="row py-lg-5">
      <div class="col-lg-6 col-md-8 mx-auto">
        <h1 class="fw-light">Game Shop Management</h1>
        <p class="lead text-body-secondary">Manage your Game Shop</p>
      </div>
    </div>
  </section>

<%@ include file="includes/footer.jsp" %>
