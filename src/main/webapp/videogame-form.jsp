<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.svalero.dao.Database" %>
<%@ page import="com.svalero.dao.VideogameDAO" %>
<%@ page import="com.svalero.domain.Videogame" %>
<%@ include file="includes/header.jsp" %>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").submit(function(e) {
            e.preventDefault();
            var formData = new FormData(this);
            $.ajax({
                url: $(this).attr("action"),
                type: $(this).attr("method"),
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
        });
    });
</script>

<%
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
        <nav aria-label="breadcrumb">
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

        <form class="row g-3" method="post" action="edit-videogame" enctype="multipart/form-data">
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
                <label for="deletePicture" class="form-label">Select for default cover picture: </label>
                <input type="checkbox" class="form-check-input" id="deletePicture" name="deletePicture">
                <input type="hidden" name="id" value='<%= request.getParameter("id") %>'/>
            </div>
            <%
                }
            %>
            <input type="hidden" name="action" value="<%= action %>"/>
            <div class="col-12">
                <input type="submit" value="Commit"/>
            </div>
        </form>
        <div id="result"></div>
    </div>
</main>
<%@ include file="includes/footer.jsp" %>
