<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.ClientDAO" %>
<%@ page import="com.svalero.domain.Client" %>

<%@ include file="includes/header.jsp" %>

<%
    session.removeAttribute("videogames");
    session.removeAttribute("clients");
    session.removeAttribute("orders");

    String action = request.getParameter("action");
    String firstName = request.getParameter("firstName");
    if (firstName == null) firstName = "";
    String familyName = request.getParameter("familyName");
    if (familyName == null) familyName = "";
    String birthDate = request.getParameter("birthDate");
    if (birthDate == null) birthDate= "";
    String email = request.getParameter("email");
    if (email == null) email = "";
    String dni = request.getParameter("dni");
    if (dni == null) dni = "";
%>

<main>
    <div style="margin-top: 20px;" class="container">
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="client-list.jsp">Clients</a></li>
            <li class="breadcrumb-item active">
                <% if (action.equals("register")) {
                    %>Add client<%
                } else {
                    %>Edit <%= firstName %> <%= familyName %><%
                } %>
            </li>
          </ol>
        </nav>

        <div class="form-div" style="max-width: 600px; margin: 0 auto;">
            <form class="row g-3" method="post" action="addedit-client" enctype="multipart/form-data">
                <div class="col-md-6">
                    <label for="firstName" class="form-label">First name</label>
                    <input type="text" class="form-control" id="firstName" name="firstName" value="<%= firstName %>" required>
                </div>
                <div class="col-md-6">
                    <label for="familyName" class="form-label">Last name</label>
                    <input type="text" class="form-control" id="familyName" name="familyName" value="<%= familyName %>" required>
                </div>
                <div class="col-md-6">
                    <label for="birthDate">Birthdate</label>
                    <input type="date" class="form-control" id="birthDate" name="birthDate" value="<%= birthDate %>" required>
                </div>
                <div class="col-md-6">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= email %>" required>
                </div>
                <div class="col-md-6">
                    <label for="dni" class="form-label">DNI</label>
                    <input type="text" class="form-control" id="dni" name="dni" pattern="[0-9]{8}[A-Za-z]{1}" value="<%= dni %>" required>
                </div>
                <div class="col-md-6">
                    <label for="picture" class="form-label">Cover</label>
                    <input type="file" class="form-control" id="picture" name="picture">
                </div>
                <%
                    if (action.equals("edit")) {
                %>
                <div class="col-md-6">
                    <div class="form-check">
                        <label for="deletePicture" class="form-check-label">Check this box to use our default client picture</label>
                        <input type="checkbox" class="form-check-input" id="deletePicture" name="deletePicture">
                    </div>
                    <input type="hidden" name="id" value='<%= request.getParameter("id") %>'/>
                    <input type="hidden" name="action" value="edit">
                </div>
                <%
                    } else {
                %>
                    <input type="hidden" name="action" value="register">
                <%
                    }
                %>
                <div class="col-12">
                    <button type="submit" class="btn btn-primary" data-toggle="modal" data-target="#confirmationModal">
                        <% if (action.equals("edit")) { %>
                            Commit edition
                        <% } else { %>
                            Commit addition
                        <% } %>
                    </button>
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

                var firstName = document.querySelector("input[name='firstName']").value;
                var familyName = document.querySelector("input[name='familyName']").value;
                var action = "<%= action %>";

                if (action === "edit") {
                    $("#confirmationMessage").text("Are you sure you want to edit <%= firstName %> <%= familyName %>?");
                } else {
                    $("#confirmationMessage").text("Are you sure you want to register " + firstName + " " + familyName + "?");
                }
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
