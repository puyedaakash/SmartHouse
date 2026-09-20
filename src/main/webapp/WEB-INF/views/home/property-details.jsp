<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Property Details | SmartHouse</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <style>
        body {
            background-color: #f5f7fb;
            font-family: Arial, sans-serif;
        }

        .navbar-brand {
            font-size: 25px;
            font-weight: bold;
        }

        .property-container {
            margin-top: 40px;
            margin-bottom: 50px;
        }

        .property-card {
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .property-image {
            width: 100%;
            height: 420px;
            object-fit: cover;
        }

        .property-title {
            font-size: 30px;
            font-weight: bold;
            color: #222;
        }

        .property-price {
            font-size: 27px;
            font-weight: bold;
            color: #198754;
        }

        .property-location {
            color: #6c757d;
            font-size: 16px;
        }

        .info-box {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 18px;
            height: 100%;
        }

        .info-box h6 {
            color: #6c757d;
            margin-bottom: 8px;
        }

        .info-box p {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 0;
        }

        .section-title {
            font-size: 23px;
            font-weight: bold;
            margin-top: 30px;
            margin-bottom: 20px;
        }

        .amenity-box {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 14px;
            text-align: center;
        }

        .description {
            line-height: 1.8;
            color: #555;
        }

        .footer {
            background-color: #212529;
            color: white;
            padding: 20px;
            text-align: center;
            margin-top: 50px;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">

    <div class="container">

        <a class="navbar-brand"
           href="${pageContext.request.contextPath}/">
            SmartHouse
        </a>

        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarContent">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div class="collapse navbar-collapse" id="navbarContent">

            <ul class="navbar-nav ms-auto">

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/">
                        Home
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link active"
                       href="${pageContext.request.contextPath}/properties">
                        Properties
                    </a>
                </li>

                <sec:authorize access="isAuthenticated()">

                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/user/favorites">
                            Favorites
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/user/compare">
                            Compare
                        </a>
                    </li>

                    <li class="nav-item">

                        <form method="post"
                              action="${pageContext.request.contextPath}/logout"
                              class="d-inline">

                            <sec:csrfInput />

                            <button type="submit"
                                    class="btn btn-link nav-link">
                                Logout
                            </button>

                        </form>

                    </li>

                </sec:authorize>

                <sec:authorize access="!isAuthenticated()">

                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/login">
                            Login
                        </a>
                    </li>

                </sec:authorize>

            </ul>

        </div>

    </div>

</nav>


<div class="container property-container">

    <c:choose>

        <c:when test="${empty house}">

            <div class="alert alert-danger text-center">

                <h3>Property not found</h3>

                <a href="${pageContext.request.contextPath}/properties"
                   class="btn btn-primary mt-3">
                    Back to Properties
                </a>

            </div>

        </c:when>

        <c:otherwise>

            <div class="property-card">

                <c:choose>

                    <c:when test="${not empty house.imagePath}">

                        <img
                            src="${pageContext.request.contextPath}/uploads/properties/${house.imagePath}"
                            alt="Property Image"
                            class="property-image">

                    </c:when>

                    <c:otherwise>

                        <div class="d-flex justify-content-center
                                    align-items-center bg-secondary
                                    text-white property-image">

                            <h4>No Image Available</h4>

                        </div>

                    </c:otherwise>

                </c:choose>


                <div class="p-4">

                    <div class="d-flex justify-content-between
                                align-items-start flex-wrap">

                        <div>

                            <h1 class="property-title">
                                ${house.title}
                            </h1>

                            <p class="property-location">
                                📍 ${house.location.name}
                            </p>

                            <p class="text-muted">
                                Property ID: ${house.id}
                            </p>

                        </div>

                        <div class="text-end">

                            <div class="property-price">
                                ₹ ${house.price}
                            </div>

                            <span class="badge bg-primary">
                                ${house.propertyType.name}
                            </span>

                        </div>

                    </div>


                    <div class="row g-3 mt-3">

                        <div class="col-md-6">

                            <sec:authorize access="isAuthenticated()">

                                <form method="post"
                                      action="${pageContext.request.contextPath}/user/favorites/toggle/${house.id}">

                                    <sec:csrfInput />

                                    <button type="submit"
                                            class="btn btn-outline-danger w-100">

                                        <c:choose>

                                            <c:when test="${isFavorite}">
                                                ♥ Remove from Favorites
                                            </c:when>

                                            <c:otherwise>
                                                ♡ Add to Favorites
                                            </c:otherwise>

                                        </c:choose>

                                    </button>

                                </form>

                            </sec:authorize>

                            <sec:authorize access="!isAuthenticated()">

                                <a href="${pageContext.request.contextPath}/login"
                                   class="btn btn-outline-danger w-100">
                                    Login to Add Favorite
                                </a>

                            </sec:authorize>

                        </div>


                        <div class="col-md-6">

                            <sec:authorize access="isAuthenticated()">

                                <c:choose>

                                    <c:when test="${isInComparison}">

                                        <button type="button"
                                                class="btn btn-outline-secondary w-100"
                                                disabled>
                                            Already in Comparison
                                        </button>

                                    </c:when>

                                    <c:otherwise>

                                        <form method="post"
                                              action="${pageContext.request.contextPath}/user/compare/add/${house.id}">

                                            <sec:csrfInput />

                                            <button type="submit"
                                                    class="btn btn-outline-primary w-100">
                                                Add to Compare
                                            </button>

                                        </form>

                                    </c:otherwise>

                                </c:choose>

                            </sec:authorize>

                            <sec:authorize access="!isAuthenticated()">

                                <a href="${pageContext.request.contextPath}/login"
                                   class="btn btn-outline-primary w-100">
                                    Login to Compare
                                </a>

                            </sec:authorize>

                        </div>

                    </div>


                    <h2 class="section-title">
                        Property Information
                    </h2>

                    <div class="row g-3">

                        <div class="col-md-4 col-sm-6">
                            <div class="info-box">
                                <h6>Area</h6>
                                <p>${house.area} sq. ft.</p>
                            </div>
                        </div>

                        <div class="col-md-4 col-sm-6">
                            <div class="info-box">
                                <h6>Bedrooms</h6>
                                <p>${house.bedrooms}</p>
                            </div>
                        </div>

                        <div class="col-md-4 col-sm-6">
                            <div class="info-box">
                                <h6>Bathrooms</h6>
                                <p>${house.bathrooms}</p>
                            </div>
                        </div>

                        <div class="col-md-4 col-sm-6">
                            <div class="info-box">
                                <h6>Floors</h6>
                                <p>${house.floors}</p>
                            </div>
                        </div>

                        <div class="col-md-4 col-sm-6">
                            <div class="info-box">
                                <h6>Furnishing</h6>
                                <p>${house.furnishing}</p>
                            </div>
                        </div>

                        <div class="col-md-4 col-sm-6">
                            <div class="info-box">
                                <h6>Property Type</h6>
                                <p>${house.propertyType.name}</p>
                            </div>
                        </div>

                    </div>


                    <h2 class="section-title">
                        Amenities
                    </h2>

                    <c:choose>

                        <c:when test="${not empty house.amenities}">

                            <div class="row g-3">

                                <c:forEach var="amenity"
                                           items="${house.amenities}">

                                    <div class="col-md-3 col-sm-6">

                                        <div class="amenity-box">
                                            ✓ ${amenity.name}
                                        </div>

                                    </div>

                                </c:forEach>

                            </div>

                        </c:when>

                        <c:otherwise>

                            <p class="text-muted">
                                No amenities available for this property.
                            </p>

                        </c:otherwise>

                    </c:choose>


                    <h2 class="section-title">
                        Description
                    </h2>

                    <p class="description">

                        <c:choose>

                            <c:when test="${not empty house.description}">
                                ${house.description}
                            </c:when>

                            <c:otherwise>
                                No description available for this property.
                            </c:otherwise>

                        </c:choose>

                    </p>


                    <!-- OWNER CONTACT DETAILS -->

                    <c:if test="${not empty house.owner}">

                        <h2 class="section-title">
                            Owner Contact Details
                        </h2>

                        <div class="card border-0 bg-light p-4">

                            <div class="row g-3">

                                <div class="col-md-6">

                                    <h6 class="text-muted">
                                        Owner Name
                                    </h6>

                                    <p class="fw-bold mb-0">
                                        ${house.owner.name}
                                    </p>

                                </div>


                                <div class="col-md-6">

                                    <h6 class="text-muted">
                                        Contact Number
                                    </h6>

                                    <p class="fw-bold mb-0">

                                        <a href="tel:${house.owner.contactNumber}">
                                            ${house.owner.contactNumber}
                                        </a>

                                    </p>

                                </div>


                                <c:if test="${not empty house.owner.email}">

                                    <div class="col-md-6">

                                        <h6 class="text-muted">
                                            Email Address
                                        </h6>

                                        <p class="fw-bold mb-0">

                                            <a href="mailto:${house.owner.email}">
                                                ${house.owner.email}
                                            </a>

                                        </p>

                                    </div>

                                </c:if>

                            </div>

                        </div>

                    </c:if>


                    <div class="mt-4">

                        <a href="${pageContext.request.contextPath}/properties"
                           class="btn btn-secondary">
                            ← Back to Properties
                        </a>

                    </div>

                </div>

            </div>

        </c:otherwise>

    </c:choose>

</div>


<footer class="footer">

    <p class="mb-0">
        © 2026 SmartHouse. All Rights Reserved.
    </p>

</footer>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>