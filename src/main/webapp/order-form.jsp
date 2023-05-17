<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.ClientDAO" %>
<%@ page import="com.svalero.domain.Client" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.VideogameDAO" %>
<%@ page import="com.svalero.domain.Videogame" %>
<%@ page import="com.svalero.dao.OrderDAO" %>
<%@ page import="com.svalero.domain.Order" %>
<%@ page import="java.util.List" %>

<%@ include file="includes/header.jsp" %>

<%
    session.removeAttribute("videogames");
    session.removeAttribute("clients");
    session.removeAttribute("orders");

    String name = request.getParameter("name");
    String price = request.getParameter("price");
%>

<main>
    <div style="margin-top: 20px;" class="container">
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="order-list.jsp">Orders</a></li>
            <li class="breadcrumb-item active">Add order</li>
          </ol>
        </nav>

        <div class="form-div" style="max-width: 600px; margin: 0 auto;">
            <form class="row g-3" method="post" action="add-order" enctype="multipart/form-data">
                <label for="clientId">Client</label>
                <select name="clientId" id="clientId">
                     <%
                        Database.connect();
                        List<Client> clients = Database.jdbi.withExtension(ClientDAO.class, ClientDAO::getClientsOrderByFamilyName);
                        for (Client client : clients) { %>
                            <option data-fullname="<%= client.getFamilyName() %>, <%= client.getFirstName() %>" value="<%= client.getId() %>"><%= client.getFamilyName() %>, <%= client.getFirstName() %> (<%= client.getDni() %>)</option>
                     <% } %>
                </select>
                <label for="videogameId">Videogame</label>
                <select name="videogameId" id="videogameId">
                    <%
                        List<Videogame> videogames = Database.jdbi.withExtension(VideogameDAO.class, VideogameDAO::getVideogamesOrderByName);
                        for (Videogame videogame : videogames) { %>
                            <option data-name="<%= videogame.getName() %>" value="<%= videogame.getId() %>"><%= videogame.getName() %> (<%= videogame.getReleaseDate() %>)</option>
                    <% } %>
                </select>
                <div class="col-12">
                    <button type="submit" class="btn btn-primary" data-toggle="modal" data-target="#confirmationModal">Commit addition</button>
                </div>
            </form>
        </div>

        <div class="modal fade" id="confirmationModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmationModalLabel">Confirmation required</h5>
                    </div>
                    <div class="modal-body">
                        <p id="confirmationMessage"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="confirm-button">Confirm</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="result"></div>
    </div>

    <script type="text/javascript">
        $(document).ready(function() {
            $("form").submit(function(e) {
                e.preventDefault();

                var clientFullName = $("#clientId option:selected").data("fullname");
                var videogameName = $("#videogameId option:selected").data("name");

                $("#confirmationMessage").text("Are you sure you want to register an order of " + videogameName + " for " + " client " + clientFullName + "?");
                $("#confirmationModal").modal("show");
            });
            $("#confirm-button").click(function() {
                var formData = new FormData($("form")[0]);
                $.ajax({
                    url: $("form").attr("action"),
                    type: $("form").attr("method"),
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(data) {
                        $("#result").html(data);
                    },
                    error: function(xhr, status, error) {
                        console.log("Error: " + error);
                    }
                });
                $("#confirmationModal").modal("hide");
            });
        });
    </script>
</main>
<%@ include file="includes/footer.jsp" %>
