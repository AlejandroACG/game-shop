<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="includes/header.jsp" %>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            var formValue = $(this).serialize();
            $.post("insert-videogame", formValue, function(data) {
                $("#result").html(data);
            });
        });
    });
</script>

<main>
    <div style="margin-top: 20px;" class="container">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/game-shop">Videogames</a></li>
            <li class="breadcrumb-item active">Add videogame</li>
          </ol>
        </nav>
        <form class="row g-3">
            <div class="col-md-6">
                <label for="name" class="form-label">Name</label>
                <input type="text" class="form-control" id="name" name="name">
            </div>
            <div class="col-md-6">
                <label for="price" class="form-label">Price</label>
                <input type="text" class="form-control" id="price" name="price">
            </div>
            <div class="col-md-6">
                <label for="releaseDate">Release date:</label>
                <input type="date" class="form-control" id="releaseDate" name="releaseDate">
            </div>
            <div class="col-md-6">
                <label for="picture" class="form-label">Picture</label>
                <input type="file" class="form-control" id="picture" name="picture">
            </div>
            <button type="submit" class="btn btn-primary">Add videogame</button>
        </form>
        <div id="result"></div>
    </div>
</main>
<%@ include file="includes/footer.jsp" %>
