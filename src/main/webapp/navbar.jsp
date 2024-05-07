<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
        <a class="navbar-brand" href="home">SFAA</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="home">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="gpa">GPA Calculator</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="tuition">Tuition Estimator</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="expense">Expenses Calculator</a>
                </li>
            </ul>
            <ul class="navbar-nav">
                <li id="loggedIn" class="nav-item">
                    <a class="nav-link" href="login">Log in</a>
                </li>
                <li id="register" class="nav-item">
                    <a class="nav-link" href="register">Register</a>
                </li>
                <li id="usrName" class="nav-item">
                    <a id="usrNameTxt" href="account" class="nav-link"></a>
                </li>
                <li id="loggedOut" class="nav-item">
                    <a class="nav-link" href="logout">Log Out</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<script>
    $(function(){
        $.ajax({
            url: 'authenticate',
            type: 'POST',
            success: function (result) {
                if (result.length > 0 && !(result === 'Unauthorized') ) {
                    $('#loggedIn').hide();
                    $('#register').hide();
                    $('#usrNameTxt').text(result);
                }
                else {
                    $('usrName').hide();
                    $('#loggedOut').hide();
                }
            },
            error: function (err) {
                console.log('error');
            },
        });
    });
</script>
