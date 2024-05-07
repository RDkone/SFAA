<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <title>GPA Result</title>
</head>
<body class="container">
    <h2>Your Calculated GPA is: ${gpa}</h2>
    <% if (request.getAttribute("error") != null) { %>
        <p>Error: <%= request.getAttribute("error") %></p>
    <% } %>
    <a href="gpacalculator.jsp">Calculate Again</a>
</body>
</html>
