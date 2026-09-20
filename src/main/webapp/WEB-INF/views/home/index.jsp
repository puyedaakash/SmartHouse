<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SmartHouse - House Price Prediction</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

</head>

<body>

<!-- ================= NAVBAR ================= -->

<jsp:include page="../common/navbar.jsp" />


<!-- ================= HERO SECTION ================= -->

<section class="bg-dark text-white py-5">

    <div class="container py-5">

        <div class="row align-items-center">

            <div class="col-lg-7">

                <span class="badge bg-primary mb-3">
                    SmartHouse Platform
                </span>

                <h1 class="display-4 fw-bold mb-3">

                    Find the Right Property.
                    Predict Its Value.

                </h1>

                <p class="lead text-light mb-4">

                    SmartHouse is a house price prediction and
                    property analytics platform that helps you
                    explore properties and make smarter decisions.

                </p>


                <div class="d-flex flex-wrap gap-3">

                    <!-- Browse Properties -->

                    <a
                        href="${pageContext.request.contextPath}/properties"
                        class="btn btn-primary btn-lg">

                        Browse Properties

                    </a>


                    <!-- Predict Price -->

                    <a
                        href="${pageContext.request.contextPath}/login"
                        class="btn btn-outline-light btn-lg">

                        Predict House Price

                    </a>

                </div>

            </div>


            <div class="col-lg-5 mt-5 mt-lg-0">

                <div class="card shadow-lg border-0">

                    <div class="card-body p-4 text-dark">

                        <h4 class="fw-bold mb-3">
                            Smart Property Insights
                        </h4>

                        <div class="mb-3">

                            <h6 class="text-muted mb-1">
                                Property Search
                            </h6>

                            <p class="mb-0">
                                Explore properties by location,
                                type and other features.
                            </p>

                        </div>


                        <div class="mb-3">

                            <h6 class="text-muted mb-1">
                                Price Prediction
                            </h6>

                            <p class="mb-0">
                                Estimate property prices using
                                machine-learning based analysis.
                            </p>

                        </div>


                        <div>

                            <h6 class="text-muted mb-1">
                                Property Analytics
                            </h6>

                            <p class="mb-0">
                                Understand property characteristics
                                and pricing trends.
                            </p>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- ================= FEATURES ================= -->

<section class="py-5">

    <div class="container">

        <div class="text-center mb-5">

            <h2 class="fw-bold">
                Everything You Need
            </h2>

            <p class="text-muted">
                SmartHouse combines property discovery
                with intelligent price analysis.
            </p>

        </div>


        <div class="row g-4">


            <!-- Property Search -->

            <div class="col-md-4">

                <div class="card h-100 shadow-sm border-0">

                    <div class="card-body text-center p-4">

                        <div class="display-5 mb-3">
                            🏠
                        </div>

                        <h4 class="fw-bold">
                            Property Search
                        </h4>

                        <p class="text-muted">

                            Browse available properties
                            and explore their details,
                            locations and features.

                        </p>

                        <a
                            href="${pageContext.request.contextPath}/properties"
                            class="btn btn-outline-primary">

                            Explore Properties

                        </a>

                    </div>

                </div>

            </div>


            <!-- Price Prediction -->

            <div class="col-md-4">

                <div class="card h-100 shadow-sm border-0">

                    <div class="card-body text-center p-4">

                        <div class="display-5 mb-3">
                            📊
                        </div>

                        <h4 class="fw-bold">
                            Price Prediction
                        </h4>

                        <p class="text-muted">

                            Enter property characteristics
                            and get an estimated house price
                            based on the prediction model.

                        </p>

                        <a
                            href="${pageContext.request.contextPath}/login"
                            class="btn btn-outline-primary">

                            Predict Price

                        </a>

                    </div>

                </div>

            </div>


            <!-- Analytics -->

            <div class="col-md-4">

                <div class="card h-100 shadow-sm border-0">

                    <div class="card-body text-center p-4">

                        <div class="display-5 mb-3">
                            📈
                        </div>

                        <h4 class="fw-bold">
                            Property Analytics
                        </h4>

                        <p class="text-muted">

                            Analyze property characteristics
                            and understand factors that influence
                            house prices.

                        </p>

                        <a
                            href="${pageContext.request.contextPath}/properties"
                            class="btn btn-outline-primary">

                            View Properties

                        </a>

                    </div>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- ================= HOW IT WORKS ================= -->

<section class="bg-light py-5">

    <div class="container">

        <div class="text-center mb-5">

            <h2 class="fw-bold">
                How SmartHouse Works
            </h2>

            <p class="text-muted">
                Simple steps to make better property decisions.
            </p>

        </div>


        <div class="row g-4 text-center">


            <div class="col-md-4">

                <div class="card border-0 shadow-sm h-100">

                    <div class="card-body p-4">

                        <div class="display-6 mb-3">
                            1
                        </div>

                        <h5 class="fw-bold">
                            Explore
                        </h5>

                        <p class="text-muted mb-0">

                            Browse properties and explore
                            locations, property types and features.

                        </p>

                    </div>

                </div>

            </div>


            <div class="col-md-4">

                <div class="card border-0 shadow-sm h-100">

                    <div class="card-body p-4">

                        <div class="display-6 mb-3">
                            2
                        </div>

                        <h5 class="fw-bold">
                            Enter Property Details
                        </h5>

                        <p class="text-muted mb-0">

                            Provide information such as area,
                            bedrooms, bathrooms and location.

                        </p>

                    </div>

                </div>

            </div>


            <div class="col-md-4">

                <div class="card border-0 shadow-sm h-100">

                    <div class="card-body p-4">

                        <div class="display-6 mb-3">
                            3
                        </div>

                        <h5 class="fw-bold">
                            Get Insights
                        </h5>

                        <p class="text-muted mb-0">

                            Receive a predicted property price
                            and useful property insights.

                        </p>

                    </div>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- ================= CTA ================= -->

<section class="py-5">

    <div class="container">

        <div class="card bg-primary text-white border-0 shadow">

            <div class="card-body text-center p-5">

                <h2 class="fw-bold">
                    Ready to Explore Properties?
                </h2>

                <p class="lead mb-4">

                    Discover properties and use SmartHouse
                    to understand their potential value.

                </p>

                <a
                    href="${pageContext.request.contextPath}/properties"
                    class="btn btn-light btn-lg">

                    Browse Properties

                </a>

            </div>

        </div>

    </div>

</section>


<!-- ================= FOOTER ================= -->

<jsp:include page="../common/footer.jsp" />


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>