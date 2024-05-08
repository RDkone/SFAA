
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Page</title>
</head>
<body>
    <jsp:include page="WEB-INF/navbar.jsp" />
    <div class="container mt-5">
        <div class="p-5 text-center rounded-3" style="background-color: #2980b9;">
            <h1 class="fw-bold text-light">Welcome to the Student Financial Academic Assistant!</h1>
            <p class="col-lg-8 mx-auto fs-5 text-light">
                Your one-stop solution for GPA calculation, tuition cost estimation, and budgeting monthly living expenses.
            </p>
        </div>
        <h4 class="text-center">Please <a href="login">log in</a> to continue.</h4>
    </div>
    <jsp:include page="WEB-INF/footer.jsp" />
</body>
</html>
