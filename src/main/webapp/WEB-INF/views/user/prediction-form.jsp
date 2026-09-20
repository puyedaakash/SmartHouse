<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Predict House Price - SmartHouse</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/smarthouse.css">

</head>


<body class="bg-light">

<jsp:include page="../common/navbar.jsp" />


<main>

    <div class="container py-5">


        <!-- HEADER -->

        <div class="text-center mb-5">

            <span class="badge bg-primary mb-3">
                AI POWERED PREDICTION
            </span>

            <h1 class="fw-bold">
                Predict House Price
            </h1>

            <p class="text-muted mx-auto"
               style="max-width: 700px;">

                Enter the property characteristics below and
                SmartHouse will estimate the property's market value
                using the trained machine learning model.

            </p>

        </div>


        <!-- ERROR MESSAGE -->

        <c:if test="${not empty predictionError}">

            <div class="row justify-content-center mb-4">

                <div class="col-lg-9">

                    <div class="alert alert-danger">

                        <strong>
                            Prediction Failed:
                        </strong>

                        ${predictionError}

                    </div>

                </div>

            </div>

        </c:if>


        <!-- PREDICTION FORM -->

        <div class="row justify-content-center">

            <div class="col-xl-9">


                <div class="card border-0 shadow-sm">

                    <div class="card-body p-4 p-md-5">


                        <form:form
                            modelAttribute="predictionRequest"
                            method="post"
                            action="${pageContext.request.contextPath}/user/prediction">


                            <!-- CSRF -->

                            <sec:csrfInput />


                            <!-- PROPERTY CHARACTERISTICS -->

                            <div class="mb-4">

                                <h4 class="fw-bold mb-1">
                                    Property Characteristics
                                </h4>

                                <p class="text-muted small">
                                    Enter the physical characteristics
                                    of the property.
                                </p>

                                <hr>

                            </div>


                            <div class="row g-4">


                                <!-- AREA -->

                                <div class="col-md-6">

                                    <label
                                        for="area"
                                        class="form-label fw-semibold">

                                        Area (sq.ft.)

                                    </label>

                                    <form:input
                                        path="area"
                                        id="area"
                                        type="number"
                                        step="0.01"
                                        min="100"
                                        cssClass="form-control form-control-lg"
                                        placeholder="Example: 1200"
                                        required="required" />

                                    <form:errors
                                        path="area"
                                        cssClass="text-danger small d-block mt-1" />

                                    <div class="form-text">
                                        Minimum 100 sq.ft.
                                    </div>

                                </div>


                                <!-- BEDROOMS -->

                                <div class="col-md-6">

                                    <label
                                        for="bedrooms"
                                        class="form-label fw-semibold">

                                        Bedrooms

                                    </label>

                                    <form:input
                                        path="bedrooms"
                                        id="bedrooms"
                                        type="number"
                                        min="1"
                                        max="20"
                                        cssClass="form-control form-control-lg"
                                        placeholder="Example: 3"
                                        required="required" />

                                    <form:errors
                                        path="bedrooms"
                                        cssClass="text-danger small d-block mt-1" />

                                </div>


                                <!-- BATHROOMS -->

                                <div class="col-md-6">

                                    <label
                                        for="bathrooms"
                                        class="form-label fw-semibold">

                                        Bathrooms

                                    </label>

                                    <form:input
                                        path="bathrooms"
                                        id="bathrooms"
                                        type="number"
                                        min="1"
                                        max="20"
                                        cssClass="form-control form-control-lg"
                                        placeholder="Example: 2"
                                        required="required" />

                                    <form:errors
                                        path="bathrooms"
                                        cssClass="text-danger small d-block mt-1" />

                                </div>


                                <!-- FLOORS -->

                                <div class="col-md-6">

                                    <label
                                        for="floors"
                                        class="form-label fw-semibold">

                                        Floor

                                    </label>

                                    <form:input
                                        path="floors"
                                        id="floors"
                                        type="number"
                                        min="1"
                                        max="100"
                                        cssClass="form-control form-control-lg"
                                        placeholder="Example: 5"
                                        required="required" />

                                    <form:errors
                                        path="floors"
                                        cssClass="text-danger small d-block mt-1" />

                                </div>


                                <!-- PROPERTY AGE -->

                                <div class="col-md-6">

                                    <label
                                        for="age"
                                        class="form-label fw-semibold">

                                        Property Age (years)

                                    </label>

                                    <form:input
                                        path="age"
                                        id="age"
                                        type="number"
                                        min="0"
                                        max="200"
                                        cssClass="form-control form-control-lg"
                                        placeholder="Example: 5"
                                        required="required" />

                                    <form:errors
                                        path="age"
                                        cssClass="text-danger small d-block mt-1" />

                                    <div class="form-text">
                                        Enter 0 for a new property.
                                    </div>

                                </div>


                                <!-- FURNISHING -->

                                <div class="col-md-6">

                                    <label
                                        for="furnishing"
                                        class="form-label fw-semibold">

                                        Furnishing

                                    </label>

                                    <form:select
                                        path="furnishing"
                                        id="furnishing"
                                        cssClass="form-select form-select-lg"
                                        required="required">

                                        <form:option
                                            value=""
                                            label="Select furnishing" />

                                        <form:option
                                            value="Unfurnished"
                                            label="Unfurnished" />

                                        <form:option
                                            value="Semi-Furnished"
                                            label="Semi-Furnished" />

                                        <form:option
                                            value="Fully Furnished"
                                            label="Fully Furnished" />

                                    </form:select>

                                    <form:errors
                                        path="furnishing"
                                        cssClass="text-danger small d-block mt-1" />

                                </div>


                                <!-- PROPERTY TYPE -->

                                <div class="col-md-6">

                                    <label
                                        for="propertyTypeId"
                                        class="form-label fw-semibold">

                                        Property Type

                                    </label>

                                    <form:select
                                        path="propertyTypeId"
                                        id="propertyTypeId"
                                        cssClass="form-select form-select-lg"
                                        required="required">

                                        <form:option
                                            value=""
                                            label="Select property type" />

                                        <form:options
                                            items="${propertyTypes}"
                                            itemValue="id"
                                            itemLabel="name" />

                                    </form:select>

                                    <form:errors
                                        path="propertyTypeId"
                                        cssClass="text-danger small d-block mt-1" />

                                </div>


                                <!-- LOCATION -->

                                <div class="col-md-6">

                                    <label
                                        for="locationId"
                                        class="form-label fw-semibold">

                                        Location

                                    </label>

                                    <form:select
                                        path="locationId"
                                        id="locationId"
                                        cssClass="form-select form-select-lg"
                                        required="required">

                                        <form:option
                                            value=""
                                            label="Select location" />

                                        <form:options
                                            items="${locations}"
                                            itemValue="id"
                                            itemLabel="name" />

                                    </form:select>

                                    <form:errors
                                        path="locationId"
                                        cssClass="text-danger small d-block mt-1" />

                                    <div class="form-text">
                                        Select the locality of the property.
                                    </div>

                                </div>

                            </div>


                            <!-- MODEL INFORMATION -->

                            <div class="alert alert-light border mt-5">

                                <div class="d-flex align-items-start">

                                    <div class="fs-4 me-3">
                                        🤖
                                    </div>

                                    <div>

                                        <h6 class="fw-bold mb-1">
                                            How the Prediction Works
                                        </h6>

                                        <p class="text-muted small mb-0">

                                            SmartHouse analyzes the property
                                            characteristics you provide and
                                            passes them through the trained
                                            house-price prediction model to
                                            estimate a property value.

                                        </p>

                                    </div>

                                </div>

                            </div>


                            <!-- ACTIONS -->

                            <div class="d-flex
                                        justify-content-between
                                        align-items-center
                                        flex-wrap
                                        gap-2
                                        mt-4">


                                <a
                                    href="${pageContext.request.contextPath}/user/dashboard"
                                    class="btn btn-outline-secondary">

                                    ← Dashboard

                                </a>


                                <button
                                    type="submit"
                                    class="btn btn-primary btn-lg px-5">

                                    🤖 Predict House Price

                                </button>

                            </div>


                        </form:form>

                    </div>

                </div>


                <!-- DISCLAIMER -->

                <div class="text-center mt-4">

                    <small class="text-muted">

                        The predicted value is an estimate generated
                        by the SmartHouse model and should not be treated
                        as a guaranteed market or transaction price.

                    </small>

                </div>

            </div>

        </div>

    </div>

</main>


<jsp:include page="../common/footer.jsp" />


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>