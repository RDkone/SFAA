<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <style>
        form {
            max-width: 400px;
        }
        input[type="text"],
        input[type="email"],
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
            <form action="register" method="post">
                <h2 style="text-align: center;">Registration Form For Student Financial and Academic Assistance</h2>
                <label for="username">Username:</label>
                <%
                    String usrName = (String) request.getAttribute("username");
                    if (usrName != null)
                    {
                %>
                    <input type="text" id="username" name="username" required value="<%= usrName.toString() %>">
                <%
                    }
                    else
                    { %>
                    <input type="text" id="username" name="username" required>
                <% }
                %>
                <label for="email">Email:</label>
                <%
                    String email = (String) request.getAttribute("email");
                    if (email != null)
                    {
                %>
                <input type="email" id="email" name="email" required value="<%= email.toString() %>">
                <%
                }
                else
                { %>
                <input type="email" id="email" name="email" required>
                <% }
                %>
                <label for="password">Password:</label>
                <%
                    String password = (String) request.getAttribute("password");
                    if (password != null)
                    {
                %>
                <input type="password" id="password" name="password" required value="<%= password.toString() %>">
                <%
                }
                else
                { %>
                <input type="password" id="password" name="password" required>
                <% }
                %>
                <input type="submit" value="Register">
            </form>
            <%
                String errorMsg = (String) request.getAttribute("error");
                if (errorMsg != null)
                {
            %>
                <div class="alert alert-danger" role="alert">
                    <%= errorMsg.toString() %>
                </div>
            <%
            }
            %>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>
