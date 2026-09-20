<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>

<fmt:setLocale value="en_IN" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Properties - SmartHouse</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/smarthouse.css">

    <style>
        .property-card {
            border-radius: 16px;
            overflow: hidden;
            transition: transform 0.25s ease,
                        box-shadow 0.25s ease;
        }

        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12) !important;
        }

        .property-image {
            width: 100%;
            height: 220px;
            object-fit: cover;
            display: block;
        }

        .property-image-container {
            position: relative;
            overflow: hidden;
            background-color: #f1f3f5;
        }

        .property-type-badge {
            position: absolute;
            top: 14px;
            left: 14px;
            background-color: rgba(255, 255, 255, 0.95);
            color: #212529;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .property-price {
            color: #198754;
            font-size: 1.35rem;
            font-weight: 700;
        }

        .feature-box {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 10px 5px;
            text-align: center;
        }

        .feature-value {
            font-weight: 600;
            font-size: 0.95rem;
        }

        .feature-label {
            color: #6c757d;
            font-size: 0.78rem;
        }

        .action-button {
            border-radius: 8px;
        }
    </style>
</head>

<body class="bg-light">

    <jsp:include page="../common/navbar.jsp" />

    <main>
        <div class="container py-5">

            <!-- Page Header -->
            <div class="mb-4">
                <span class="badge bg-primary mb-2">
                    PROPERTY EXPLORER
                </span>

                <h1 class="fw-bold mb-2">
                    Find Your Property
                </h1>

                <p class="text-muted mb-0">
                    Explore properties available on SmartHouse
                    and compare them based on your requirements.
                </p>
            </div>

            <!-- Search and Filter Section -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body p-4">

                    <form
                        method="get"
                        action="${pageContext.request.contextPath}/properties/search">

                        <div class="row g-3 align-items-end">

                            <div class="col-lg-4">
                                <label
                                    for="keyword"
                                    class="form-label fw-semibold">
                                    Search
                                </label>

                                <input
                                    type="text"
                                    id="keyword"
                                    name="keyword"
                                    value="${keyword}"
                                    class="form-control"
                                    placeholder="Search by property title">
                            </div>

                            <div class="col-lg-3">
                                <label
                                    for="propertyTypeId"
                                    class="form-label fw-semibold">
                                    Property Type
                                </label>

                                <select
                                    id="propertyTypeId"
                                    name="propertyTypeId"
                                    class="form-select">

                                    <option value="">
                                        All Property Types
                                    </option>

                                    <c:forEach
                                        var="propertyType"
                                        items="${propertyTypes}">

                                        <c:choose>
                                            <c:when
                                                test="${propertyType.id == propertyTypeId}">

                                                <option
                                                    value="${propertyType.id}"
                                                    selected="selected">

                                                    ${propertyType.name}

                                                </option>
                                            </c:when>

                                            <c:otherwise>

                                                <option
                                                    value="${propertyType.id}">

                                                    ${propertyType.name}

                                                </option>
                                            </c:otherwise>
                                        </c:choose>

                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-lg-3">
                                <label
                                    for="locationId"
                                    class="form-label fw-semibold">
                                    Location
                                </label>

                                <select
                                    id="locationId"
                                    name="locationId"
                                    class="form-select">

                                    <option value="">
                                        All Locations
                                    </option>

                                    <c:forEach
                                        var="location"
                                        items="${locations}">

                                        <c:choose>
                                            <c:when
                                                test="${location.id == locationId}">

                                                <option
                                                    value="${location.id}"
                                                    selected="selected">

                                                    ${location.name}

                                                </option>
                                            </c:when>

                                            <c:otherwise>

                                                <option
                                                    value="${location.id}">

                                                    ${location.name}

                                                </option>
                                            </c:otherwise>
                                        </c:choose>

                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-lg-2">
                                <button
                                    type="submit"
                                    class="btn btn-primary w-100">

                                    Search

                                </button>
                            </div>

                        </div>
                    </form>

                </div>
            </div>

            <!-- Property Count -->
            <div class="d-flex
                        justify-content-between
                        align-items-center
                        flex-wrap
                        gap-2
                        mb-4">

                <div>
                    <h5 class="fw-bold mb-1">
                        Available Properties
                    </h5>

                    <p class="text-muted small mb-0">

                        <c:choose>
                            <c:when test="${not empty houses}">
                                Showing
                                <strong>${houses.size()}</strong>
                                properties.
                            </c:when>

                            <c:otherwise>
                                No properties match your search.
                            </c:otherwise>
                        </c:choose>

                    </p>
                </div>

                <a
                    href="${pageContext.request.contextPath}/properties"
                    class="btn btn-sm btn-outline-secondary">

                    Clear Filters

                </a>
            </div>

            <!-- Properties Section -->
            <c:choose>

                <c:when test="${empty houses}">

                    <div class="card border-0 shadow-sm">
                        <div class="card-body text-center py-5">

                            <div class="display-4 mb-3">
                                🏠
                            </div>

                            <h4 class="fw-bold">
                                No Properties Found
                            </h4>

                            <p class="text-muted mb-4">
                                Try changing your search criteria
                                or clearing the filters.
                            </p>

                            <a
                                href="${pageContext.request.contextPath}/properties"
                                class="btn btn-primary">

                                View All Properties

                            </a>

                        </div>
                    </div>

                </c:when>

                <c:otherwise>

                    <div class="row g-4">

                        <c:forEach
                            var="house"
                            items="${houses}">

                            <div class="col-md-6 col-xl-4">

                                <div class="card
                                            border-0
                                            shadow-sm
                                            h-100
                                            property-card">

                                    <!-- Property Image -->
                                    <div class="property-image-container">

                                        <c:choose>

                                            <%-- Show uploaded image if available --%>
                                            <c:when test="${not empty house.imagePath}">

                                                <img
                                                    src="${pageContext.request.contextPath}/uploads/properties/${house.imagePath}"
                                                    alt="${house.title}"
                                                    class="property-image">

                                            </c:when>

                                            <%-- Show default image if no image exists --%>
                                            <c:otherwise>

                                                <img
                                                    src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=900&q=85"
                                                    alt="Default property image"
                                                    class="property-image">

                                            </c:otherwise>

                                        </c:choose>

                                        <c:if test="${not empty house.propertyType}">

                                            <span class="property-type-badge">
                                                ${house.propertyType.name}
                                            </span>

                                        </c:if>

                                    </div>

                                    <!-- Property Details -->
                                    <div class="card-body p-4">

                                        <h5 class="fw-bold mb-2">
                                            ${house.title}
                                        </h5>

                                        <p class="text-muted small mb-3">

                                            📍

                                            <c:choose>

                                                <c:when
                                                    test="${not empty house.location}">

                                                    ${house.location.name}

                                                </c:when>

                                                <c:otherwise>

                                                    Location unavailable

                                                </c:otherwise>

                                            </c:choose>

                                        </p>

                                        <!-- Property Features -->
                                        <div class="row g-2 mb-3">

                                            <div class="col-4">
                                                <div class="feature-box">

                                                    <div class="feature-value">
                                                        ${house.bedrooms}
                                                    </div>

                                                    <div class="feature-label">
                                                        Beds
                                                    </div>

                                                </div>
                                            </div>

                                            <div class="col-4">
                                                <div class="feature-box">

                                                    <div class="feature-value">
                                                        ${house.bathrooms}
                                                    </div>

                                                    <div class="feature-label">
                                                        Baths
                                                    </div>

                                                </div>
                                            </div>

                                            <div class="col-4">
                                                <div class="feature-box">

                                                    <div class="feature-value">
                                                        ${house.area}
                                                    </div>

                                                    <div class="feature-label">
                                                        Sq.ft.
                                                    </div>

                                                </div>
                                            </div>

                                        </div>

                                        <!-- Property Price -->
                                        <div class="mb-3">

                                            <small class="text-muted">
                                                Estimated Property Price
                                            </small>

                                            <div class="property-price">

                                                ₹<fmt:formatNumber
                                                    value="${house.price}"
                                                    type="number"
                                                    groupingUsed="true"
                                                    maxFractionDigits="0" />

                                            </div>
                                        </div>

                                        <!-- View Details Button -->
                                        <a
                                            href="${pageContext.request.contextPath}/properties/${house.id}"
                                            class="btn btn-primary
                                                   action-button
                                                   w-100
                                                   mb-2">

                                            View Details

                                        </a>

                                        <!-- User Actions -->
                                        <sec:authorize access="hasRole('USER')">

                                            <div class="row g-2">

                                                <div class="col-6">

                                                    <form
                                                        method="post"
                                                        action="${pageContext.request.contextPath}/user/favorites/toggle/${house.id}">

                                                        <sec:csrfInput />

                                                        <button
                                                            type="submit"
                                                            class="btn btn-outline-danger
                                                                   action-button
                                                                   w-100">

                                                            ♥ Favorite

                                                        </button>

                                                    </form>

                                                </div>

                                                <div class="col-6">

                                                    <form
                                                        method="post"
                                                        action="${pageContext.request.contextPath}/user/compare/add/${house.id}">

                                                        <sec:csrfInput />

                                                        <button
                                                            type="submit"
                                                            class="btn btn-outline-primary
                                                                   action-button
                                                                   w-100">

                                                            Compare

                                                        </button>

                                                    </form>

                                                </div>

                                            </div>

                                        </sec:authorize>

                                    </div>

                                </div>

                            </div>

                        </c:forEach>

                    </div>

                </c:otherwise>

            </c:choose>

        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
    </script>

</body>
</html>