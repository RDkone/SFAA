<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Expense Manager</title>
    <style>
        .centered-card {
            width: 50%;
            border: 1px solid brown;
            padding: 10px;
            margin: 0 auto 10px;
            border-radius: 20px;
            background: lavenderblush;
        }

        .centered-header {
            margin: 0 auto;
            padding: 20px;
            display: table;
        }


        table {
            width: 100%;
        }

        h2 {
            margin: 0 auto 10px;
            display: table;
            color: maroon;
        }

        input[type=text] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type=number] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type=date] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        textarea {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        select {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .btn-submit {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-submit:hover {
            background-color: #45a049;
        }

        .info-key {
            color: #22140c;
            font-size: x-large;
            float: left;
            margin: 20px;
        }
        .info-value{
            color: #250914;
            font-size: x-large;
            margin: 20px;
        }


    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    <br />
    <h1 class="centered-header">Expense Manager</h1>
    <div class="centered-card">
        <h2>Expense Report</h2>
        <form action="expense" method="get">
            <label for="year">Year:</label>
            <select class="input-default" name="year" id="year">
                <%
                    String selectedYear = request.getAttribute("year").toString();
                    int currentYear = java.time.LocalDate.now().getYear();
                    for (int year = currentYear - 1; year <= currentYear + 1; year++) {
                        String selected = (String.valueOf(year).equals(selectedYear)) ? "selected" : "";
                %>
                <option value="<%= year %>" <%= selected %>><%= year %>
                </option>
                <%
                    }
                %>
            </select>
            <label for="month">Month:</label>
            <select class="input-default" name="month" id="month">
                <%
                    String selectedMonth = request.getAttribute("month").toString();
                    for (int month = 1; month <= 12; month++) {
                        String selected = (String.valueOf(month).equals(selectedMonth)) ? "selected" : "";
                %>
                <option value="<%= month %>" <%= selected %>><%= month %>
                </option>
                <%
                    }
                %>
            </select>
            <button class="btn-submit" type="submit">Load Expenses</button>
        </form>
        <br>
        <div class="table-responsive bg-transparent">
            <table class="table text-center ">
                <thead>
                <tr>
                    <% ResultSet resultSet = (ResultSet) request.getAttribute("expenses"); %>
                    <% ResultSetMetaData metaData = resultSet.getMetaData(); %>
                    <% int columnCount = metaData.getColumnCount(); %>
                    <% for (int i = 1; i <= columnCount; i++) { %>
                    <th><%= metaData.getColumnName(i) %>
                    </th>
                    <% } %>
                </tr>
                </thead>
                <tbody class="table-group-divider">
                <% while (resultSet.next()) { %>
                <tr>
                    <% for (int i = 1; i <= columnCount; i++) { %>
                    <td><%= resultSet.getString(i) %>
                    </td>
                    <% } %>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <p class="info-key">Total expenses for <%= request.getAttribute("month") %>/<%= request.getAttribute("year") %>:
        </p>
        <p class="info-value">
            $<%= request.getAttribute("monthlySum") %>
        </p>
    </div>
    <div class="centered-card">

        <h2>Create Expense</h2>
        <form action="expense" method="post">
            <input type="hidden" name="action" value="create_expense">
            <div class="input-group">
                <label for="date">Date:</label>
                <input type="date" id="date" name="date" value="<%= java.time.LocalDate.now() %>" required><br>
            </div>
            <div class="input-group">
                <label for="category">Category:</label>
                <select class="input-default" id="category" name="category" required>
                    <%-- Populate dropdown with categories --%>
                    <%
                        List<String> categories = (List<String>) request.getAttribute("categories");
                        for (String category : categories) {
                    %>
                    <option value="<%= category %>"><%= category %>
                    </option>
                    <%
                        }
                    %>
                </select>
            </div>
            <div class="input-group">
                <label for="value">Value:</label>
                <input class="input-default" type="number" id="value" name="value" step="0.01" required><br>
            </div>
            <div class="input-group">
                <label class="input-default" for="description">Description:</label><br>
                <textarea class="input-default" id="description" name="description" rows="4" cols="50"></textarea><br>
            </div>
            <button class="btn-submit" type="submit">Create Expense</button>
        </form>
    </div>
    <div class="centered-card">
        <h2>Create Expense Category</h2>
        <form action="expense" method="post">
            <input class="input-default" type="hidden" name="action" value="create_expense_category">
            <label for="expense_category">Expense Category Name:</label>
            <input class="input-default" type="text" id="expense_category" name="expense_category" required><br>
            <button class="btn-submit" type="submit">Create Category</button>
        </form>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>