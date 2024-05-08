<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>SFAA - Tuition Cost Estimator</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    <br />
    <br />
    <div class="container">
        <div class="p-5 text-center text-light rounded-3" style="background-color: #2980b9">
            <h1 class="fw-bold text-light">Tuition Cost Estimator</h1>
            <p class="lead">
                Shows how much college really costs.
            </p>
        </div>
        <br/>
        <div>
            <h3 class="text-center">Which location would you prefer to attend?</h3>
            <select id="state-select" class="form-select" multiple aria-label="State Select" size="15" onchange="">
                <option value="AL">Alabama</option>
                <option value="AK">Alaska</option>
                <option value="AZ">Arizona</option>
                <option value="AR">Arkansas</option>
                <option value="CA">California</option>
                <option value="CO">Colorado</option>
                <option value="CT">Connecticut</option>
                <option value="DE">Delaware</option>
                <option value="DC">District Of Columbia</option>
                <option value="FL">Florida</option>
                <option value="GA">Georgia</option>
                <option value="HI">Hawaii</option>
                <option value="ID">Idaho</option>
                <option value="IL">Illinois</option>
                <option value="IN">Indiana</option>
                <option value="IA">Iowa</option>
                <option value="KS">Kansas</option>
                <option value="KY">Kentucky</option>
                <option value="LA">Louisiana</option>
                <option value="ME">Maine</option>
                <option value="MD">Maryland</option>
                <option value="MA">Massachusetts</option>
                <option value="MI">Michigan</option>
                <option value="MN">Minnesota</option>
                <option value="MS">Mississippi</option>
                <option value="MO">Missouri</option>
                <option value="MT">Montana</option>
                <option value="NE">Nebraska</option>
                <option value="NV">Nevada</option>
                <option value="NH">New Hampshire</option>
                <option value="NJ">New Jersey</option>
                <option value="NM">New Mexico</option>
                <option value="NY">New York</option>
                <option value="NC">North Carolina</option>
                <option value="ND">North Dakota</option>
                <option value="OH">Ohio</option>
                <option value="OK">Oklahoma</option>
                <option value="OR">Oregon</option>
                <option value="PA">Pennsylvania</option>
                <option value="RI">Rhode Island</option>
                <option value="SC">South Carolina</option>
                <option value="SD">South Dakota</option>
                <option value="TN">Tennessee</option>
                <option value="TX">Texas</option>
                <option value="UT">Utah</option>
                <option value="VT">Vermont</option>
                <option value="VA">Virginia</option>
                <option value="WA">Washington</option>
                <option value="WV">West Virginia</option>
                <option value="WI">Wisconsin</option>
                <option value="WY">Wyoming</option>
            </select>
            <br />
            <h3 class="text-center">Which degree level are you interested in?</h3>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" value="" id="four-year-check" onclick="ValidateForm()">
                <label class="form-check-label" for="four-year-check">
                    Four-year Degree
                </label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" value="" id="two-year-check" onclick="ValidateForm()">
                <label class="form-check-label" for="two-year-check">
                    Two-year Degree
                </label>
            </div>
            <br />
            <h3 class="text-center">What is the size of the school you wish to attend?</h3>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" value="" id="lessThan5k">
                <label class="form-check-label" for="lessThan5k">
                    Fewer Than 5,000
                </label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" value="" id="5kTo10k">
                <label class="form-check-label" for="5kTo10k">
                    5,000 - 10,000
                </label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" value="" id="10kTo15k">
                <label class="form-check-label" for="10kTo15k">
                    10,000 - 15,000
                </label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" value="" id="moreThan15k">
                <label class="form-check-label" for="moreThan15k">
                    More than 15,000
                </label>
            </div>
            <br />
            <button id="schoolSearchBtn" type="button" class="btn btn-outline-secondary" onclick="SearchSchools()" disabled>Find Schools</button>
        </div>
        <br />
        <div id="notFound" class="alert alert-danger text-center" role="alert">
            <b>No Institutions Found.</b>
        </div>
        <div id="schoolsList">
            <div class="row">
                <div class="col-4">
                    <div class="list-group" id="list-schools" role="tablist">
                    </div>
                </div>
                <div class="col-8">
                    <div class="tab-content" id="list-schoolContent">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(function() {
            $('#notFound').hide();
            $('#state-select').change(function() {
                ValidateForm();
            });
        });
        function ValidateForm() {
            if ($('#state-select').val().length > 0 && ($('#four-year-check').is(':checked') || $('#two-year-check').is(':checked'))){
                $('#schoolSearchBtn').removeAttr('disabled')
            }
            else {
                $('#schoolSearchBtn').attr('disabled', 'disabled')
            }
        }
        function FilterSchools(instArray){
            let filterArr = [];
            let finalArr = [];
            const selectedStates = $('#state-select option:selected').toArray().map(s => s.text);
            selectedStates.forEach(function (state, idx){
                const stateFilter = instArray.filter( i => { return i.Address.indexOf(state) > -1 });
                stateFilter.forEach(function (stateInst){
                    filterArr.push(stateInst);
                })
            });
            if (!($('#four-year-check').is(':checked') && $('#two-year-check').is(':checked'))) {
                if ($('#four-year-check').is(':checked')) {
                    filterArr = filterArr.filter( i => { return i.Type.indexOf('4-year') > -1 });
                }
                else {
                    filterArr = filterArr.filter( i => { return i.Type.indexOf('2-year') > -1 });
                }
            }
            console.log($('#lessThan5k').is(':checked'));
            if ($('#lessThan5k').is(':checked')) {
                console.log("< 5k checked");
                const sizeFilter = filterArr.filter( i => { return parseInt(i.StudentPopulation.replace(/,/g, '')) < 5000 });
                sizeFilter.forEach(function (inst){
                    finalArr.push(inst);
                })
            }
            if ($('#5kTo10k').is(':checked')) {
                console.log("5k-10 checked");
                const sizeFilter = filterArr.filter( i => { return parseInt(i.StudentPopulation.replace(/,/g, '')) >= 5000 && parseInt(i.StudentPopulation.replace(/,/g, '')) <= 10000 });
                sizeFilter.forEach(function (inst){
                    finalArr.push(inst);
                })
            }
            if ($('#10kTo15k').is(':checked')) {
                console.log("10k-15k checked");
                const sizeFilter = filterArr.filter( i => { return parseInt(i.StudentPopulation.replace(/,/g, '')) >= 10000 && parseInt(i.StudentPopulation.replace(/,/g, '')) <= 15000 });
                sizeFilter.forEach(function (inst){
                    finalArr.push(inst);
                })
            }
            if ($('#moreThan15k').is(':checked')) {
                console.log("15k > checked");
                const sizeFilter = filterArr.filter( i => { return parseInt(i.StudentPopulation.replace(/,/g, '')) > 15000 });
                sizeFilter.forEach(function (inst){
                    finalArr.push(inst);
                })
            }
            if (finalArr.length === 0) {
                finalArr = filterArr;
            }
            $('#notFound').hide();
            $('#list-schools').empty();
            $('#list-schoolContent').empty();
            if (finalArr.length === 0) {
                $('#notFound').show();
            }
            finalArr.forEach(function (institution){
                const navId = 'nav-' + institution.InstitutionId;
                const contentId = 'list-' + institution.InstitutionId;
                $('#list-schools').append('<a class="list-group-item list-group-item-action" id="'+navId+'" data-bs-toggle="list" href="#'+contentId+'" role="tab" aria-controls="'+contentId+'">'+institution.Name+'</a>')
                $('#list-schoolContent').append('<div class="tab-pane fade" id="'+contentId+'" role="tabpanel" aria-labelledby="'+navId+'"></div>');
                CreateSchoolContent(institution);

            });

        }
        function SearchSchools(){
            $.ajax({
                url: 'tuition',
                type: 'POST',
                data: {
                    tData: true,
                },
                success: function (result) {
                    FilterSchools(result);
                },
                error: function (err) {
                    console.log('error');
                },
            });
        }
        function CreateSchoolContent(instData){
            var tuitionExp = instData.TuitionAndFees;
            var livingArr = instData.LivingArrangement;
            var totalExp = instData.TotalExpenses;
            var netPrcs = instData.NetPrices;
            $('#list-' + instData.InstitutionId).append('<div id="card-'+instData.InstitutionId+'" class="card"></div>');
            let schoolCard = $('#card-'+instData.InstitutionId);
            schoolCard.append('<div class="card-header">'+instData.Name+', '+instData.Address+'</div>')
            schoolCard.append('<div id="body-'+instData.InstitutionId+'" class="card-body"></div>');
            let schoolBody = $('#body-'+instData.InstitutionId);
            schoolBody.append('<p class="card-text">Type: <b>'+instData.Type+'</b></p>');
            schoolBody.append('<p class="card-text">Campus Housing: <b>'+instData.CampusHousing+'</b></p>');
            schoolBody.append('<p class="card-text">School Population: <b>'+instData.StudentPopulation+'</b></p>');
            schoolBody.append('<h4 class="card-text">Tuition & Fees</h4>');
            schoolBody.append('<ul id="tnf-'+instData.InstitutionId+'" class="list-group list-group-flush"></ul>');
            let tnF = $('#tnf-'+instData.InstitutionId);
            if (tuitionExp.InDistrict) {
                tnF.append('<li class="list-group-item">In District <span class="float-end"><b>'+tuitionExp.InDistrict+'</b></span></li>');
            }
            if (tuitionExp.InState) {
                tnF.append('<li class="list-group-item">In State <span class="float-end"><b>'+tuitionExp.InState+'</b></span></li>');
            }
            if (tuitionExp.OutOfState) {
                tnF.append('<li class="list-group-item">Out of State <span class="float-end"><b>'+tuitionExp.OutOfState+'</b></span></li>');
            }
            if (tuitionExp.BooksAndSupplies) {
                tnF.append('<li class="list-group-item">Books & Supplies <span class="float-end"><b>'+tuitionExp.BooksAndSupplies+'</b></span></li>');
            }
            schoolBody.append('<h4 class="card-text">Living Arrangement</h4>');
            schoolBody.append('<ul id="living-'+instData.InstitutionId+'" class="list-group list-group-flush"></ul>');
            let living = $('#living-'+instData.InstitutionId);
            if (livingArr.OnCampus && (livingArr.OnCampus.FoodAndHousing || livingArr.OnCampus.OtherExpenses)) {
                living.append('<h6 class="card-text">On Campus</h6>');
                let onC = $('<ul class="list-group list-group-flush"><ul>');
                living.append(onC);
                if (livingArr.OnCampus.FoodAndHousing) {
                    onC.append('<li class="list-group-item">Food and Housing <span class="float-end"><b>'+livingArr.OnCampus.FoodAndHousing+'</b></span></li>');
                }
                if (livingArr.OnCampus.OtherExpenses) {
                    onC.append('<li class="list-group-item">Other Expenses<span class="float-end"><b>'+livingArr.OnCampus.OtherExpenses+'</b></span></li>');
                }
            }
            if (livingArr.OffCampus && (livingArr.OffCampus.FoodAndHousing || livingArr.OffCampus.OtherExpenses)) {
                living.append('<h6 class="card-text">Off Campus</h6>');
                let offC = $('<ul class="list-group list-group-flush"><ul>');
                living.append(offC);
                if (livingArr.OffCampus.FoodAndHousing) {
                    offC.append('<li class="list-group-item">Food and Housing<span class="float-end"><b>'+livingArr.OffCampus.FoodAndHousing+'</b></span></li>');
                }
                if (livingArr.OffCampus.OtherExpenses) {
                    offC.append('<li class="list-group-item">Other Expenses<span class="float-end"><b>'+livingArr.OffCampus.OtherExpenses+'</b></span></li>');
                }
            }
            if (livingArr.OffCampusWithFamily) {
                living.append('<h6 class="card-text">Off Campus w/ Family</h6>');
                let offCWF = $('<ul class="list-group list-group-flush"><ul>');
                living.append(offCWF);
                if (livingArr.OffCampusWithFamily.OtherExpenses) {
                    offCWF.append('<li class="list-group-item">Other Expenses<span class="float-end"><b>'+livingArr.OffCampusWithFamily.OtherExpenses+'</b></span></li>');
                }
            }
            schoolBody.append('<h4 class="card-text">Total Expenses</h4>');
            schoolBody.append('<ul id="total-'+instData.InstitutionId+'" class="list-group list-group-flush"></ul>');
            let total = $('#total-'+instData.InstitutionId);
            if (totalExp.InDistrictOffCampus || totalExp.InDistrictOffCampusWithFamily) {
                total.append('<h6 class="card-text">In District</h6>')
                let inD = $('<ul class="list-group list-group-flush"><ul>');
                total.append(inD);
                if (totalExp.InDistrictOffCampus) {
                    inD.append('<li class="list-group-item">Off Campus<span class="float-end"><b>'+totalExp.InDistrictOffCampus+'</b></span></li>');
                }
                if (totalExp.InDistrictOffCampusWithFamily) {
                    inD.append('<li class="list-group-item">Off Campus w/ Family<span class="float-end"><b>'+totalExp.InDistrictOffCampusWithFamily+'</b></span></li>');
                }
            }
            if (totalExp.InStateOnCampus || totalExp.InStateOffCampus || totalExp.InStateOffCampusWithFamily) {
                total.append('<h6 class="card-text">In State</h6>')
                let inSt = $('<ul class="list-group list-group-flush"><ul>');
                total.append(inSt);
                if (totalExp.InStateOnCampus) {
                    inSt.append('<li class="list-group-item">On Campus<span class="float-end"><b>'+totalExp.InStateOnCampus+'</b></span></li>');
                }
                if (totalExp.InStateOffCampus) {
                    inSt.append('<li class="list-group-item">Off Campus<span class="float-end"><b>'+totalExp.InStateOffCampus+'</b></span></li>');
                }
                if (totalExp.InStateOffCampusWithFamily) {
                    inSt.append('<li class="list-group-item">Off Campus w/ Family<span class="float-end"><b>'+totalExp.InStateOffCampusWithFamily+'</b></span></li>');
                }
            }
            if (totalExp.OutOfStateOnCampus || totalExp.OutOfStateOffCampus || totalExp.OutOfStateOffCampusWithFamily) {
                total.append('<h6 class="card-text">Out of State</h6>')
                let ooSt = $('<ul class="list-group list-group-flush"><ul>');
                total.append(ooSt);
                if (totalExp.OutOfStateOnCampus) {
                    ooSt.append('<li class="list-group-item">On Campus<span class="float-end"><b>'+totalExp.OutOfStateOnCampus+'</b></span></li>');
                }
                if (totalExp.OutOfStateOffCampus) {
                    ooSt.append('<li class="list-group-item">Off Campus<span class="float-end"><b>'+totalExp.OutOfStateOffCampus+'</b></span></li>');
                }
                if (totalExp.OutOfStateOffCampusWithFamily) {
                    ooSt.append('<li class="list-group-item">Off Campus w/ Family<span class="float-end"><b>'+totalExp.OutOfStateOffCampusWithFamily+'</b></span></li>');
                }
            }
            schoolBody.append('<h4 class="card-text">Average Net Price By Income</h4>');
            schoolBody.append('<ul id="netprc-'+instData.InstitutionId+'" class="list-group list-group-flush"></ul>');

            let netPrc = $('#netprc-'+instData.InstitutionId);
            netPrc.append('<li class="list-group-item">$0 - $30,000<span class="float-end"><b>'+netPrcs.ZeroToThirty+'</b></span></li>');
            netPrc.append('<li class="list-group-item">$30,001 - $48,000<span class="float-end"><b>'+netPrcs.ThirtyToForty+'</b></span></li>');
            netPrc.append('<li class="list-group-item">$48,001 - $75,000<span class="float-end"><b>'+netPrcs.FortyToSeventy+'</b></span></li>');
            netPrc.append('<li class="list-group-item">$75,001 - $110,000<span class="float-end"><b>'+netPrcs.SeventyToOneHundred+'</b></span></li>');
            netPrc.append('<li class="list-group-item">$110,001 and more<span class="float-end"><b>'+netPrcs.OneHundredAndMore+'</b></span></li>');
        }
    </script>
    <jsp:include page="footer.jsp" />
</body>
</html>