<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard - SmartHouse</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/smarthouse.css">

</head>


<body>

<jsp:include page="../common/navbar.jsp" />


<main>

    <div class="container-fluid py-5 px-lg-5">


        <!-- WELCOME -->

        <div class="mb-5">

            <span class="badge bg-primary mb-2">
                ADMIN PANEL
            </span>

            <h1 class="fw-bold mb-2">
                Admin Dashboard
            </h1>

            <p class="text-muted mb-0">
                Manage SmartHouse properties, master data,
                users and platform analytics.
            </p>

        </div>


        <!-- PROPERTY MANAGEMENT -->

        <div class="mb-5">

            <div class="mb-3">

                <h4 class="fw-bold mb-1">
                    Property Management
                </h4>

                <p class="text-muted">
                    Manage the properties available on SmartHouse.
                </p>

            </div>


            <div class="row g-4">


                <!-- PROPERTIES -->

                <div class="col-md-6 col-xl-4">

                    <div class="card
                                border-0
                                shadow-sm
                                h-100">

                        <div class="card-body p-4">

                            <div class="fs-1 mb-3">
                                🏠
                            </div>

                            <h5 class="fw-bold">
                                Properties
                            </h5>

                            <p class="text-muted">

                                Create, update, view and delete
                                property records.

                            </p>

                            <a
                                href="${pageContext.request.contextPath}/admin/houses"
                                class="btn btn-primary">

                                Manage Properties →

                            </a>

                        </div>

                    </div>

                </div>


                <!-- ANALYTICS -->

                <div class="col-md-6 col-xl-4">

                    <div class="card
                                border-0
                                shadow-sm
                                h-100">

                        <div class="card-body p-4">

                            <div class="fs-1 mb-3">
                                📊
                            </div>

                            <h5 class="fw-bold">
                                Analytics
                            </h5>

                            <p class="text-muted">

                                View property statistics,
                                prices and market distribution.

                            </p>

                            <a
                                href="${pageContext.request.contextPath}/admin/analytics"
                                class="btn btn-outline-primary">

                                View Analytics →

                            </a>

                        </div>

                    </div>

                </div>


                <!-- USERS -->

                <div class="col-md-6 col-xl-4">

                    <div class="card
                                border-0
                                shadow-sm
                                h-100">

                        <div class="card-body p-4">

                            <div class="fs-1 mb-3">
                                👥
                            </div>

                            <h5 class="fw-bold">
                                Users
                            </h5>

                            <p class="text-muted">

                                Manage registered users and
                                platform accounts.

                            </p>

                            <a
                                href="${pageContext.request.contextPath}/admin/users"
                                class="btn btn-outline-primary">

                                Manage Users →

                            </a>

                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- LOCATION MASTER DATA -->

        <div class="mb-5">

            <div class="mb-3">

                <h4 class="fw-bold mb-1">
                    Location Master Data
                </h4>

                <p class="text-muted">
                    Maintain the property location hierarchy.
                </p>

            </div>


            <div class="row g-4">


                <!-- STATES -->

                <div class="col-md-6 col-xl-3">

                    <div class="card
                                border-0
                                shadow-sm
                                h-100">

                        <div class="card-body p-4">

                            <div class="fs-1 mb-3">
                                🌍
                            </div>

                            <h5 class="fw-bold">
                                States
                            </h5>

                            <p class="text-muted small">

                                Manage states used by the
                                location hierarchy.

                            </p>

                            <a
                                href="${pageContext.request.contextPath}/admin/states"
                                class="btn btn-sm btn-outline-primary">

                                Manage States

                            </a>

                        </div>

                    </div>

                </div>


                <!-- DISTRICTS -->

                <div class="col-md-6 col-xl-3">

                    <div class="card
                                border-0
                                shadow-sm
                                h-100">

                        <div class="card-body p-4">

                            <div class="fs-1 mb-3">
                                🗺️
                            </div>

                            <h5 class="fw-bold">
                                Districts
                            </h5>

                            <p class="text-muted small">

                                Manage districts and
                                state relationships.

                            </p>

                            <a
                                href="${pageContext.request.contextPath}/admin/districts"
                                class="btn btn-sm btn-outline-primary">

                                Manage Districts

                            </a>

                        </div>

                    </div>

                </div>


                <!-- CITIES -->

                <div class="col-md-6 col-xl-3">

                    <div class="card
                                border-0
                                shadow-sm
                                h-100">

                        <div class="card-body p-4">

                            <div class="fs-1 mb-3">
                                🏙️
                            </div>

                            <h5 class="fw-bold">
                                Cities
                            </h5>

                            <p class="text-muted small">

                                Manage cities and their
                                district relationships.

                            </p>

                            <a
                                href="${pageContext.request.contextPath}/admin/cities"
                                class="btn btn-sm btn-outline-primary">

                                Manage Cities

                            </a>

                        </div>

                    </div>

                </div>


                <!-- LOCATIONS -->

                <div class="col-md-6 col-xl-3">

                    <div class="card
                                border-0
                                shadow-sm
                                h-100">

                        <div class="card-body p-4">

                            <div class="fs-1 mb-3">
                                📍
                            </div>

                            <h5 class="fw-bold">
                                Locations
                            </h5>

                            <p class="text-muted small">

                                Manage local areas used by
                                properties.

                            </p>

                            <a
                                href="${pageContext.request.contextPath}/admin/locations"
                                class="btn btn-sm btn-outline-primary">

                                Manage Locations

                            </a>

                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- PROPERTY MASTER DATA -->

        <div class="mb-5">

            <div class="mb-3">

                <h4 class="fw-bold mb-1">
                    Property Master Data
                </h4>

                <p class="text-muted">
                    Configure property categories and facilities.
                </p>

            </div>


            <div class="row g-4">


                <!-- PROPERTY TYPES -->

                <div class="col-md-6 col-xl-4">

                    <div class="card
                                border-0
                                shadow-sm
                                h-100">

                        <div class="card-body p-4">

                            <div class="fs-1 mb-3">
                                🏘️
                            </div>

                            <h5 class="fw-bold">
                                Property Types
                            </h5>

                            <p class="text-muted">

                                Manage Apartment, Villa,
                                Bungalow, Plot and other categories.

                            </p>

                            <a
                                href="${pageContext.request.contextPath}/admin/property-types"
                                class="btn btn-outline-primary">

                                Manage Types →

                            </a>

                        </div>

                    </div>

                </div>


                <!-- AMENITIES -->

                <div class="col-md-6 col-xl-4">

                    <div class="card
                                border-0
                                shadow-sm
                                h-100">

                        <div class="card-body p-4">

                            <div class="fs-1 mb-3">
                                ⭐
                            </div>

                            <h5 class="fw-bold">
                                Amenities
                            </h5>

                            <p class="text-muted">

                                Manage facilities such as Parking,
                                Gym, Pool, Security and more.

                            </p>

                            <a
                                href="${pageContext.request.contextPath}/admin/amenities"
                                class="btn btn-outline-primary">

                                Manage Amenities →

                            </a>

                        </div>

                    </div>

                </div>


                <!-- MODEL -->

                <div class="col-md-6 col-xl-4">

                    <div class="card
                                border-0
                                shadow-sm
                                h-100">

                        <div class="card-body p-4">

                            <div class="fs-1 mb-3">
                                🤖
                            </div>

                            <h5 class="fw-bold">
                                Prediction Engine
                            </h5>

                            <p class="text-muted">

                                House price prediction is powered
                                by the SmartHouse ML module.

                            </p>

                            <span class="badge bg-success">
                                ML Enabled
                            </span>

                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- LOCATION HIERARCHY -->

        <div class="card
                    border-0
                    shadow-sm
                    mb-5">

            <div class="card-body p-4">

                <div class="row align-items-center">

                    <div class="col-lg-8">

                        <h5 class="fw-bold mb-2">
                            SmartHouse Data Hierarchy
                        </h5>

                        <p class="text-muted mb-0">

                            All property records follow a structured
                            location hierarchy to keep search,
                            analytics and prediction data consistent.

                        </p>

                    </div>


                    <div class="col-lg-4 text-lg-end mt-3 mt-lg-0">

                        <span class="badge bg-light text-dark border p-2">

                            State
                            →
                            District
                            →
                            City
                            →
                            Location
                            →
                            Property

                        </span>

                    </div>

                </div>

            </div>

        </div>


        <!-- ADMIN NOTICE -->

        <div class="alert alert-light border">

            <div class="d-flex align-items-start">

                <div class="fs-4 me-3">
                    🔐
                </div>

                <div>

                    <h6 class="fw-bold mb-1">
                        Administrator Access
                    </h6>

                    <p class="text-muted small mb-0">

                        You are viewing the SmartHouse administration
                        panel. Changes made here can affect property
                        listings, search results, analytics and the
                        prediction workflow.

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