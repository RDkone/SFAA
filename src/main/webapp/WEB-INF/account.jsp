<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Financial and Academic Assistant - Account</title>
    <style>
        /* Global styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Main content styles */
        main {
            padding: 20px;
        }

        /* Account container */
        .account-container {
            background-color: #ecf0f1; /* Light grey */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .account-container h2 {
            color: #333;
            margin-top: 0;
        }

        /* Form styles */
        .input-group {
            margin-bottom: 10px;
        }

        .input-group label {
            display: block;
            margin-bottom: 5px;
        }

        .input-group input {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            width: auto;
            padding: 10px 20px;
            background-color: #2980b9; /* Dark blue */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #3498db; /* Light blue */
        }

        
        /* Logout button styles */
        .logout-btn {
            display: block;
            background-color: #e74c3c; /* Red */
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            margin-top: 20px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            width: fit-content;
        }
        
        .logout-btn:hover {
            background-color: #c0392b; /* Darker red */
        }
        
        /* Home button styles */
        .home-btn {
            display: block;
            background-color: #2ecc71; /* Green */
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            margin-top: 20px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            width: fit-content;
        }
        
        .home-btn:hover {
            background-color: #27ae60; /* Darker green */
        }
    </style>
</head>
<body>
  <jsp:include page="navbar.jsp" />
  <br />
  <div class="container">
    <div class="pt-5 text-light pb-0 text-center" style="background-color: #2980b9; border-radius: 10px">
      <h1 class="fw-bold text-light">Welcome to Your SFAA Account</h1>
      <p class="lead">Manage your financial and academic information here.</p>
      <ul class="nav justify-content-center text-light" style="background-color: #2c3e50; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px">
        <li class="nav-item">
          <a class="nav-link text-light" aria-current="page" href="#personal-info">Personal Information</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-light" href="#financial-info">Financial Information</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-light" href="#academic-info">Academic Information</a>
        </li>
      </ul>
    </div>
    <main>
      <!-- Personal Information -->
      <section id="personal-info">
        <div class="account-container">
          <h2>Personal Information</h2>
          <form id="personalInfoForm">
            <div class="input-group">
              <label for="fullName">Full Name:</label>
              <input type="text" id="fullName" name="fullName" required>
            </div>
            <div class="input-group">
              <label for="email">Email:</label>
              <input type="email" id="email" name="email" required>
            </div>
            <button type="button" onclick="UpdateAccountType('updPersonal')">Update Personal Info</button>
          </form>
        </div>
      </section>

      <!-- Financial Information -->
      <section id="financial-info">
        <div class="account-container">
          <h2>Financial Information</h2>
          <form id="financialInfoForm">
            <div class="input-group">
              <label for="bankAccount">Bank Account Number:</label>
              <input type="text" id="bankAccount" name="bankAccount" required>
            </div>
            <div class="input-group">
              <label for="creditCard">Credit Card Number:</label>
              <input type="text" id="creditCard" name="creditCard" required>
            </div>
            <button type="button" onclick="UpdateAccountType('updFinancial')">Update Financial Info</button>
          </form>
        </div>
      </section>

      <!-- Academic Information -->
      <section id="academic-info">
        <div class="account-container">
          <h2>Academic Information</h2>
          <form id="academicInfoForm">
            <div class="input-group">
              <label for="major">Major:</label>
              <input type="text" id="major" name="major" required>
            </div>
            <div class="input-group">
              <label for="gpa">GPA:</label>
              <input type="text" id="gpa" name="gpa" required>
            </div>
            <button type="button" onclick="UpdateAccountType('updAcademic')">Update Academic Info</button>
          </form>
        </div>
      </section>

      <!-- Home button -->
      <a href="home" class="home-btn">Home</a>

      <!-- Logout button -->
      <a href="logout" class="logout-btn">Logout</a>
    </main>
  </div>
  <jsp:include page="footer.jsp" />
  <script>
    function UpdateAccountType(updType){
      let updVal1 = "";
      let updVal2 = "";
      if (updType === 'updPersonal'){
        updVal1 = $('#fullName').val();
        updVal2 = $('#email').val();
      }
      if (updType === 'updFinancial'){
        updVal1 = $('#bankAccount').val();
        updVal2 = $('#creditCard').val();
      }
      if (updType === 'updAcademic'){
        updVal1 = $('#major').val();
        updVal2 = $('#gpa').val();
      }
      UpdateAccount(updType, updVal1, updVal2);

    }
    GetAccountInfo("fullName");
    GetAccountInfo("email");
    GetAccountInfo("bankAccount");
    GetAccountInfo("creditCard");
    GetAccountInfo("major");
    GetAccountInfo("gpa");
    function GetAccountInfo(getType){
      $.ajax({
        url: 'account',
        type: 'POST',
        data: {
          updType: getType,
        },
        success: function (result) {
          $('#' + getType).val(result);
        },
        error: function (err) {
          console.log('error connecting to server');
        },
      });
    }
    function UpdateAccount(updType, updVal1, updVal2){
      $.ajax({
        url: 'account',
        type: 'POST',
        data: {
          updType: updType,
          updVal1: updVal1,
          updVal2: updVal2
        },
        success: function (result) {
          if (result === 'Success') {
            window.location.reload();
          }
          else {
            alert("Error updating account information");
          }
        },
        error: function (err) {
          console.log('error connecting to server');
        },
      });
    }
  </script>
</body>
</html>
