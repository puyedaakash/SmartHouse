<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>User Dashboard - SmartHouse</title>

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


        <!-- WELCOME -->

        <div class="mb-5">

            <span class="badge bg-primary mb-2">
                SMART HOUSE
            </span>

            <h1 class="fw-bold mb-2">
                Welcome to Your Dashboard
            </h1>

            <p class="text-muted mb-0">

                Explore properties, predict house prices,
                manage favorites and compare properties.

            </p>

        </div>


        <!-- MAIN FEATURES -->

        <div class="row g-4 mb-5">


            <!-- PREDICTION -->

            <div class="col-md-6 col-xl-4">

                <div class="card border-0 shadow-sm h-100">

                    <div class="card-body p-4">

                        <div class="fs-1 mb-3">
                            🤖
                        </div>

                        <h5 class="fw-bold">
                            Predict House Price
                        </h5>

                        <p class="text-muted">

                            Estimate the market value of a property
                            using the SmartHouse machine learning
                            prediction engine.

                        </p>

                        <a
                            href="${pageContext.request.contextPath}/user/prediction"
                            class="btn btn-primary">

                            Predict Price →

                        </a>

                    </div>

                </div>

            </div>


            <!-- BROWSE -->

            <div class="col-md-6 col-xl-4">

                <div class="card border-0 shadow-sm h-100">

                    <div class="card-body p-4">

                        <div class="fs-1 mb-3">
                            🏠
                        </div>

                        <h5 class="fw-bold">
                            Browse Properties
                        </h5>

                        <p class="text-muted">

                            Explore available properties and
                            view detailed information about each
                            property.

                        </p>

                        <a
                            href="${pageContext.request.contextPath}/properties"
                            class="btn btn-outline-primary">

                            Browse Properties →

                        </a>

                    </div>

                </div>

            </div>


            <!-- HISTORY -->

            <div class="col-md-6 col-xl-4">

                <div class="card border-0 shadow-sm h-100">

                    <div class="card-body p-4">

                        <div class="fs-1 mb-3">
                            📜
                        </div>

                        <h5 class="fw-bold">
                            Prediction History
                        </h5>

                        <p class="text-muted">

                            Review your previous house price
                            predictions and compare your results.

                        </p>

                        <a
                            href="${pageContext.request.contextPath}/user/prediction-history"
                            class="btn btn-outline-primary">

                            View History →

                        </a>

                    </div>

                </div>

            </div>


            <!-- FAVORITES -->

            <div class="col-md-6 col-xl-4">

                <div class="card border-0 shadow-sm h-100">

                    <div class="card-body p-4">

                        <div class="fs-1 mb-3">
                            ❤️
                        </div>

                        <h5 class="fw-bold">
                            Favorite Properties
                        </h5>

                        <p class="text-muted">

                            Keep track of properties you are
                            interested in and access them quickly.

                        </p>

                        <a
                            href="${pageContext.request.contextPath}/user/favorites"
                            class="btn btn-outline-danger">

                            View Favorites →

                        </a>

                    </div>

                </div>

            </div>


            <!-- COMPARE -->

            <div class="col-md-6 col-xl-4">

                <div class="card border-0 shadow-sm h-100">

                    <div class="card-body p-4">

                        <div class="fs-1 mb-3">
                            ⚖️
                        </div>

                        <h5 class="fw-bold">
                            Compare Properties
                        </h5>

                        <p class="text-muted">

                            Compare up to three properties side by
                            side using their key characteristics.

                        </p>

                        <a
                            href="${pageContext.request.contextPath}/user/compare"
                            class="btn btn-outline-primary">

                            Compare Properties →

                        </a>

                    </div>

                </div>

            </div>


            <!-- PROFILE -->

            <div class="col-md-6 col-xl-4">

                <div class="card border-0 shadow-sm h-100">

                    <div class="card-body p-4">

                        <div class="fs-1 mb-3">
                            👤
                        </div>

                        <h5 class="fw-bold">
                            My Profile
                        </h5>

                        <p class="text-muted">

                            Manage your account information and
                            update your password.

                        </p>

                        <a
                            href="${pageContext.request.contextPath}/user/profile"
                            class="btn btn-outline-secondary">

                            Manage Profile →

                        </a>

                    </div>

                </div>

            </div>

        </div>


        <!-- QUICK ACCESS -->

        <div class="card border-0 shadow-sm mb-4">

            <div class="card-body p-4">

                <div class="row align-items-center">


                    <div class="col-lg-8">

                        <h5 class="fw-bold mb-2">
                            Find Your Next Property
                        </h5>

                        <p class="text-muted mb-0">

                            Search properties by title, property type
                            and location, then save or compare the
                            properties that interest you.

                        </p>

                    </div>


                    <div class="col-lg-4
                                text-lg-end
                                mt-3
                                mt-lg-0">

                        <a
                            href="${pageContext.request.contextPath}/properties"
                            class="btn btn-primary">

                            Explore Properties →

                        </a>

                    </div>

                </div>

            </div>

        </div>


        <!-- PREDICTION INFORMATION -->

        <div class="alert alert-light border mb-4">

            <div class="d-flex align-items-start">

                <div class="fs-4 me-3">
                    💡
                </div>

                <div>

                    <h6 class="fw-bold mb-1">
                        SmartHouse Prediction
                    </h6>

                    <p class="text-muted small mb-0">

                        The prediction engine considers property
                        characteristics such as area, bedrooms,
                        bathrooms, floors, property type, location,
                        furnishing and property age.

                    </p>

                </div>

            </div>

        </div>


        <!-- SECURITY INFORMATION -->

        <div class="alert alert-light border">

            <div class="d-flex align-items-start">

                <div class="fs-4 me-3">
                    🔐
                </div>

                <div>

                    <h6 class="fw-bold mb-1">
                        Your Account
                    </h6>

                    <p class="text-muted small mb-0">

                        Your prediction history, favorites and
                        profile information are available only to
                        your authenticated account.

                    </p>

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