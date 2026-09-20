<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Prediction Result - SmartHouse</title>

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

                <span class="badge bg-success mb-3">
                    PREDICTION COMPLETED
                </span>

                <h1 class="fw-bold">
                    Your Estimated House Price
                </h1>

                <p class="text-muted">
                    SmartHouse has generated an estimated property
                    value based on the information you provided.
                </p>

            </div>


            <!-- RESULT CARD -->

            <div class="row justify-content-center">

                <div class="col-xl-9">

                    <div class="card border-0 shadow-sm">

                        <div class="card-body p-4 p-md-5">


                            <!-- PRICE -->

                            <div class="text-center mb-5">

                                <div class="text-muted mb-2">
                                    Estimated Property Value
                                </div>

                                <div class="display-3 fw-bold text-primary">

                                    ₹<fmt:formatNumber
                                        value="${predictedPrice}"
                                        type="number"
                                        groupingUsed="true"
                                        maxFractionDigits="0"
                                        minFractionDigits="0" />

                                </div>

                                <p class="text-muted mt-2 mb-0">
                                    This is an AI-generated estimate,
                                    not a guaranteed selling price.
                                </p>

                            </div>


                            <!-- PROPERTY INFORMATION -->

                            <div class="mb-4">

                                <h4 class="fw-bold mb-3">
                                    Property Details
                                </h4>

                                <hr>

                            </div>


                            <div class="row g-3 mb-5">


                                <!-- AREA -->

                                <div class="col-md-4">

                                    <div class="border rounded p-3">

                                        <small class="text-muted d-block">
                                            Area
                                        </small>

                                        <strong>
                                            ${predictionRequest.area}
                                            sq.ft.
                                        </strong>

                                    </div>

                                </div>


                                <!-- BEDROOMS -->

                                <div class="col-md-4">

                                    <div class="border rounded p-3">

                                        <small class="text-muted d-block">
                                            Bedrooms
                                        </small>

                                        <strong>
                                            ${predictionRequest.bedrooms}
                                        </strong>

                                    </div>

                                </div>


                                <!-- BATHROOMS -->

                                <div class="col-md-4">

                                    <div class="border rounded p-3">

                                        <small class="text-muted d-block">
                                            Bathrooms
                                        </small>

                                        <strong>
                                            ${predictionRequest.bathrooms}
                                        </strong>

                                    </div>

                                </div>


                                <!-- FLOORS -->

                                <div class="col-md-4">

                                    <div class="border rounded p-3">

                                        <small class="text-muted d-block">
                                            Floor
                                        </small>

                                        <strong>
                                            ${predictionRequest.floors}
                                        </strong>

                                    </div>

                                </div>


                                <!-- AGE -->

                                <div class="col-md-4">

                                    <div class="border rounded p-3">

                                        <small class="text-muted d-block">
                                            Property Age
                                        </small>

                                        <strong>
                                            ${predictionRequest.age}
                                            years
                                        </strong>

                                    </div>

                                </div>


                                <!-- FURNISHING -->

                                <div class="col-md-4">

                                    <div class="border rounded p-3">

                                        <small class="text-muted d-block">
                                            Furnishing
                                        </small>

                                        <strong>
                                            ${predictionRequest.furnishing}
                                        </strong>

                                    </div>

                                </div>


                                <!-- PROPERTY TYPE -->

                                <div class="col-md-6">

                                    <div class="border rounded p-3">

                                        <small class="text-muted d-block">
                                            Property Type
                                        </small>

                                        <strong>

                                            <c:choose>

                                                <c:when test="${not empty propertyType}">
                                                    ${propertyType.name}
                                                </c:when>

                                                <c:otherwise>
                                                    —
                                                </c:otherwise>

                                            </c:choose>

                                        </strong>

                                    </div>

                                </div>


                                <!-- LOCATION -->

                                <div class="col-md-6">

                                    <div class="border rounded p-3">

                                        <small class="text-muted d-block">
                                            Location
                                        </small>

                                        <strong>

                                            <c:choose>

                                                <c:when test="${not empty location}">

                                                    ${location.name}

                                                    <c:if test="${not empty location.city}">
                                                        ,
                                                        ${location.city.name}
                                                    </c:if>

                                                </c:when>

                                                <c:otherwise>
                                                    —
                                                </c:otherwise>

                                            </c:choose>

                                        </strong>

                                    </div>

                                </div>

                            </div>


                            <!-- HOW TO INTERPRET -->

                            <div class="alert alert-light border mb-4">

                                <div class="d-flex align-items-start">

                                    <div class="fs-4 me-3">
                                        🤖
                                    </div>

                                    <div>

                                        <h6 class="fw-bold mb-2">
                                            Understanding This Result
                                        </h6>

                                        <p class="text-muted small mb-0">

                                            The predicted price is an estimate
                                            produced by the SmartHouse machine
                                            learning model from the characteristics
                                            submitted in the prediction form.

                                            Actual market prices can vary depending
                                            on property condition, exact locality,
                                            demand, negotiation and other factors.

                                        </p>

                                    </div>

                                </div>

                            </div>


                            <!-- ACTIONS -->

                            <div class="d-flex
                                        justify-content-center
                                        flex-wrap
                                        gap-2">

                                <a
                                    href="${pageContext.request.contextPath}/user/prediction"
                                    class="btn btn-primary">

                                    Predict Another Property

                                </a>


                                <a
                                    href="${pageContext.request.contextPath}/user/prediction-history"
                                    class="btn btn-outline-primary">

                                    View Prediction History

                                </a>


                                <a
                                    href="${pageContext.request.contextPath}/user/dashboard"
                                    class="btn btn-outline-secondary">

                                    Dashboard

                                </a>

                            </div>

                        </div>

                    </div>


                    <!-- DISCLAIMER -->

                    <div class="text-center mt-4">

                        <small class="text-muted">

                            SmartHouse predictions are intended for
                            informational purposes only and should not
                            be considered a professional property valuation.

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