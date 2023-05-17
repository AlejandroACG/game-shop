<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.OrderDAO" %>
<%@ page import="com.svalero.domain.Order" %>
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
    OrderDAO orderDao = Database.jdbi.onDemand(OrderDAO.class);
    Order order = orderDao.getOrder(id);
  %>

  <nav>
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="order-list.jsp">Orders</a></li>
      <li class="breadcrumb-item active">#<%= order.getId() %></li>
    </ol>
  </nav>

    <div class="container">
        <h2>Order details</h2>
        <table class="table">
            <tr>
                <th>ID</th>
                <td>#<%= order.getId() %> <a href="#" class="btn btn-sm btn-outline-danger delete-button" data-id="<%= order.getId() %>" data-order-date="<%= order.getOrderDate().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy", Locale.ENGLISH)) %>" data-bs-toggle="modal" data-bs-target="#deleteConfirmationModal">Delete</a></td>
            </tr>
            <tr>
                <th>Client</th>
                <td><%= order.getClient().getFamilyName() %>, <%= order.getClient().getFirstName() %> (<%= order.getClient().getDni() %>) <a href="client-details.jsp?id=<%= order.getClient().getId() %>" class="btn btn-sm btn-outline-secondary">View</a></td>
            </tr>
            <tr>
                <th>Videogame</th>
                <td><%= order.getVideogame().getName() %> (<%= order.getVideogame().getReleaseDate().getYear() %>) <a href="videogame-details.jsp?id=<%= order.getVideogame().getId() %>" class="btn btn-sm btn-outline-secondary">View</a></td>
            </tr>
            <tr>
                <th>Date</th>
                <td><%= order.getOrderDate().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy", Locale.ENGLISH)) %></td>
            </tr>
        </table>
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
      let orderId = '';

      deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
          orderId = this.getAttribute('data-id');
          const orderDate = this.getAttribute('data-order-date');
          deleteConfirmationMessage.textContent = "Do you really want to delete order #" + orderId + " (" + orderDate + ")?";
        });
      });

      deleteConfirmButton.addEventListener('click', function() {
        window.location.href = "delete-order?id=" + orderId;
        deleteConfirmationModal.hide();
      });
    });
  </script>
 </div>
</main>

<%@ include file="includes/footer.jsp" %>
