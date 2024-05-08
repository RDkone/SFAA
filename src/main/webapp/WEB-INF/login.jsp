<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        form {
            max-width: 400px;
        }
        input[type="text"],
        input[type="password"],
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #4caf50;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    <div class="vh-100 d-flex align-items-center justify-content-center">
        <div class="p-5 shadow rounded-5">
            <form action="login" method="post">
                <h2 style="text-align: center;">Login</h2>
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                <p>Don't have an account? <a href="register">Register</a> here</p>
                <input type="submit" value="Login">
            </form>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>
