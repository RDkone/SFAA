
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    <section class="py-5 text-center container">
        <div class="row py-lg-5">
            <div class="col-lg-6 col-md-8 mx-auto">
                <h1 class="fw-light">Welcome!</h1>
                <p class="lead text-body-secondary">You can now access all the features available, including the GPA Calculator, Tuition Cost Estimator, and Monthly Living Expenses Calculator.</p>
            </div>
        </div>
    </section>
    <div class="album py-5">
        <div class="container">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
                <div class="col">
                    <div class="card shadow-sm">
                        <img src="images/GPACalc.png" height="300px" class="card-img-top" alt="GPA Calculator">
                        <div class="card-body">
                            <p class="card-text text-center"><a class="text-decoration-none" href="gpa">GPA Calculator</a></p>
                            <div class="d-flex justify-content-between align-items-center">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card shadow-sm">
                        <img src="images/TuitionEstim.png" height="300px" class="card-img-top" alt="Tuition Estimator">
                        <div class="card-body">
                            <p class="card-text text-center"><a class="text-decoration-none" href="tuition">Tuition Cost Estimator</a></p>
                            <div class="d-flex justify-content-between align-items-center">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card shadow-sm">
                        <img src="images/MonthlyExp.png" height="300px" class="card-img-top" alt="Monthly Expenses">
                        <div class="card-body">
                            <p class="card-text text-center"><a class="text-decoration-none" href="expense">Monthly Expenses Calculator</a></p>
                            <div class="d-flex justify-content-between align-items-center">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card shadow-sm">
                        <img src="images/Account.png" height="300px" class="card-img-top" alt="Monthly Expenses">
                        <div class="card-body">
                            <p class="card-text text-center"><a class="text-decoration-none" href="account">Your Account</a></p>
                            <div class="d-flex justify-content-between align-items-center">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>
