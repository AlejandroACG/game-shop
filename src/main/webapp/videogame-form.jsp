<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.VideogameDAO" %>
<%@ page import="com.svalero.domain.Videogame" %>

<%@ include file="includes/header.jsp" %>

<%
    session.removeAttribute("videogames");
    String action = request.getParameter("action");
    String name = request.getParameter("name");
    if (name == null) name = "";
    String price = request.getParameter("price");
    if (price == null) price = "";
    String releaseDate = request.getParameter("releaseDate");
    if (releaseDate == null) releaseDate= "";
%>

<main>
    <div style="margin-top: 20px;" class="container">
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="videogame-list.jsp">Videogames</a></li>
            <li class="breadcrumb-item active">
                <% if (action.equals("register")) {
                    %>Add videogame<%
                } else {
                    %>Edit <%= name %><%
                } %>
            </li>
          </ol>
        </nav>
        <div class="form-div" style="max-width: 600px; margin: 0 auto;">
            <form class="row g-3" method="post" action="addedit-videogame" enctype="multipart/form-data">
                <div class="col-md-6">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%= name %>" required>
                </div>
                <div class="col-md-6">
                    <label for="price" class="form-label">Price</label>
                    <input type="text" class="form-control" id="price" name="price" value="<%= price %>" required>
                </div>
                <div class="col-md-6">
                    <label for="releaseDate">Release date</label>
                    <input type="date" class="form-control" id="releaseDate" name="releaseDate" value="<%= releaseDate %>" required>
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
                        <label for="deletePicture" class="form-check-label">Check this box to use our default cover picture</label>
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

                var name = document.querySelector("input[name='name']").value;
                var action = "<%= action %>";

                if (action === "edit") {
                    $("#confirmationMessage").text("Are you sure you want to edit <%= name %> into " + name + "?");
                } else {
                    $("#confirmationMessage").text("Are you sure you want to register " + name + "?");
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
