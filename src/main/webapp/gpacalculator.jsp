
<!DOCTYPE html>
<html>
<head>
    <title>GPA Calculator</title>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    <br />
    <br />
    <div class="container">
        <div class="p-5 text-center text-light rounded-3" style="background-color: #2980b9">
            <h1 class="fw-bold text-light">GPA Calculator</h1>
            <p class="lead">
                Find out your true GPA.
            </p>
        </div>
        <br />
        <div id="semesters">
            <div id="semCard1" class="card">
                <div id="semCard1Txt" class="card-header">
                    Semester #1
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-borderless">
                            <thead>
                            <tr>
                                <th scope="col"></th>
                                <th scope="col"></th>
                                <th scope="col"></th>
                                <th scope="col"></th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th scope="row">
                                    <input class="form-control course-inp" type="text" placeholder="Course Name" />
                                </th>
                                <td class="fw-bold align-middle">Grade:</td>
                                <td>
                                    <select class="form-select course-grade" onchange="CalcSemesterGPA('semCard1')">
                                        <option value="">--Select Grade--</option>
                                        <option value="4">A</option>
                                        <option value="3.7">A-</option>
                                        <option value="3.3">B+</option>
                                        <option value="3">B</option>
                                        <option value="2.7">B-</option>
                                        <option value="2.3">C+</option>
                                        <option value="2">C</option>
                                        <option value="1.7">C-</option>
                                        <option value="1.3">D+</option>
                                        <option value="1">D</option>
                                        <option value="0.7">D-</option>
                                        <option value="0">F</option>
                                    </select>
                                </td>
                                <td class="fw-bold align-middle">Credits:</td>
                                <td>
                                    <input class="form-control credit-inp" type="number" min="0" placeholder="Credits" oninput="CalcSemesterGPA('semCard1')" />
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="text-center">
                        <button class="btn btn-outline-secondary" type="button" onclick="AddNewCourse('semCard1')">Add Another Course</button>
                        <h3 class="mt-3">Semester GPA: <span id="semCard1GPA" class="badge"></span></h3>
                    </div>
                </div>
            </div>
        </div>
        <br />
        <div class="text-center">
            <button class="btn btn-outline-secondary" onclick="AddNewSemester()">Add Another Semester</button>
            <h3 id="overall" class="mt-3 visually-hidden">Overall GPA: <span id="overallGPA" class="badge"></span></h3>
        </div>

    </div>
    <jsp:include page="footer.jsp" />
    <script>
        let semesterCount = 1;
        ConfigureCreditInputs();
        function ConfigureCreditInputs() {
            $(document).on('keydown', '.credit-inp', function (e){
                if(!((e.keyCode > 95 && e.keyCode < 106)
                        || (e.keyCode > 47 && e.keyCode < 58)
                        || e.keyCode === 8
                        || (e.keyCode > 36 && e.keyCode < 41))) {
                    return false;
                }
            });

        }
        function AddNewCourse(semester){
            $('#' + semester + ' table tbody:last-child')
                .append('<tr><th scope="row"><input class="form-control course-inp" type="text" placeholder="Course Name" /></th>' +
                `<td class="fw-bold">Grade:</td><td><select class="form-select course-grade" onchange="CalcSemesterGPA('\${semester}')"><option value="">--Select Grade--</option>` +
                '<option value="4">A</option><option value="3.7">A-</option><option value="3.3">B+</option><option value="3">B</option>' +
                '<option value="2.7">B-</option><option value="2.3">C+</option><option value="2">C</option> <option value="1.7">C-</option>' +
                '<option value="1.3">D+</option><option value="1">D</option><option value="0.7">D-</option><option value="0">F</option>' +
                '</select></td><td class="fw-bold">Credits:</td><td>' +
                `<input class="form-control credit-inp" type="number" min="0" oninput="CalcSemesterGPA('\${semester}')" placeholder="Credits" /></td></tr>`);
        }
        function AddNewSemester(){
            semesterCount++;
            $('#semesters').append(`
                <br />
                <div id="semCard\${semesterCount}" class="card">
                <div id="semCard\${semesterCount}Txt" class="card-header">
                    Semester #\${semesterCount}
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-borderless">
                            <thead>
                            <tr>
                                <th scope="col"></th>
                                <th scope="col"></th>
                                <th scope="col"></th>
                                <th scope="col"></th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th scope="row">
                                    <input class="form-control course-inp" type="text" placeholder="Course Name" />
                                </th>
                                <td class="fw-bold align-middle">Grade:</td>
                                <td>
                                    <select class="form-select course-grade" onchange="CalcSemesterGPA('semCard\${semesterCount}')">
                                            <option value="">--Select Grade--</option>
                                            <option value="4">A</option>
                                            <option value="3.7">A-</option>
                                            <option value="3.3">B+</option>
                                            <option value="3">B</option>
                                            <option value="2.7">B-</option>
                                            <option value="2.3">C+</option>
                                            <option value="2">C</option>
                                            <option value="1.7">C-</option>
                                            <option value="1.3">D+</option>
                                            <option value="1">D</option>
                                            <option value="0.7">D-</option>
                                            <option value="0">F</option>
                                    </select>
                                </td>
                                <td class="fw-bold align-middle">Credits:</td>
                                <td>
                                    <input class="form-control credit-inp" type="number" oninput="CalcSemesterGPA('semCard\${semesterCount}')" min="0" placeholder="Credits" />
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="text-center">
                        <button class="btn btn-outline-secondary" type="button" onclick="AddNewCourse('semCard\${semesterCount}')">Add Another Course</button>
                        <h3 class="mt-3">Semester GPA: <span id="semCard\${semesterCount}GPA" class="badge"></span></h3>
                    </div>
                </div>
            </div>
            `);
        }
        function CalcSemesterGPA(semester){
            let totalGradePoints = 0;
            let totalCredits = 0;
            $('#' + semester + ' table tbody tr').each(function (idx, item){
                let tds = item.children;
                let score = $(tds[2].children[0]).find(':selected').val();
                let credit = $(tds[4].children[0]).val();
                if (score.length > 0 && credit.length > 0){
                    let gradePoint = (parseFloat(credit) * parseFloat(score));
                    totalGradePoints += parseFloat(gradePoint.toFixed(2));
                    totalCredits += parseInt(credit);
                }
            });
            let gpa = (totalGradePoints / totalCredits);
            let gpaColor = GetGPAColor(gpa)
            let semesterGPA = $('#' + semester + 'GPA');
            semesterGPA.css('background-color', gpaColor);
            if (isNaN(gpa)){
                if (!(semesterGPA.text() === 'N/A')) {
                    semesterGPA.text('N/A');
                }
            }
            else {
                semesterGPA.text(gpa.toFixed(2));
            }
            CalcOverallGPA();

        }
        function CalcOverallGPA(){
            let overall = $('#overall');
            let overallGPA = $('#overallGPA');
            if (semesterCount > 1) {
                let totalGPA = 0;
                for (let i = 1; i <= semesterCount; i++) {
                    totalGPA += parseFloat($('#semCard' + i + 'GPA').text());
                }
                totalGPA = (totalGPA / semesterCount);
                let gpaColor = GetGPAColor(totalGPA);
                overallGPA.css('background-color', gpaColor);
                if (isNaN(totalGPA)) {
                    if (!(overallGPA.text() === 'N/A')) {
                        overallGPA.text('N/A');
                    }
                }
                else {
                    overallGPA.text(totalGPA.toFixed(2));
                }
                overall.removeClass('visually-hidden');
            }
            else {
                if (!(overall.hasClass('visually-hidden'))){
                    overall.addClass('visually-hidden');
                }
            }
        }
        function GetGPAColor(gpa){
            return gpa >= 3.45 ? '#54B725' : gpa >= 2.45 ? '#B7B400' : '#B71919';
        }
    </script>
</body>
</html>
