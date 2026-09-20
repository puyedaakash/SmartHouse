<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Compare Properties - SmartHouse</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/smarthouse.css">

    <style>
        body {
            background: #f6f8fb;
        }

        .compare-card {
            border: none;
            border-radius: 18px;
            overflow: hidden;
            transition: 0.25s ease;
        }

        .compare-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.12) !important;
        }

        .property-placeholder {
            height: 190px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        .compare-value {
            font-weight: 600;
        }

        .comparison-table th {
            min-width: 150px;
            white-space: nowrap;
        }

        .empty-icon {
            font-size: 4rem;
        }

        .action-button {
            border-radius: 10px;
            padding: 10px 16px;
            font-weight: 600;
        }

        @media (max-width: 576px) {
            .action-bar {
                align-items: stretch !important;
            }
        }
    </style>
</head>

<body>

<jsp:include page="../common/navbar.jsp" />

<main>
    <div class="container py-5">

        <div class="text-center mb-5">
            <h1 class="fw-bold">Compare Properties</h1>
            <p class="text-muted">
                Compare up to three properties side by side.
            </p>
        </div>

        <c:choose>

            <c:when test="${empty houses}">

                <div class="card border-0 shadow-sm">
                    <div class="card-body text-center py-5">

                        <div class="empty-icon mb-3">⚖️</div>

                        <h3 class="fw-bold">
                            No Properties to Compare
                        </h3>

                        <p class="text-muted mb-4">
                            Add properties to your comparison list
                            from the property details page.
                        </p>

                        <a href="${pageContext.request.contextPath}/properties"
                           class="btn btn-primary action-button">
                            Browse Properties
                        </a>

                    </div>
                </div>

            </c:when>

            <c:otherwise>

                <div class="d-flex justify-content-between align-items-center
                            flex-wrap gap-3 mb-4 action-bar">

                    <span class="badge bg-primary fs-6">
                        ${houses.size()} / 3 Properties
                    </span>

                    <div class="d-flex gap-2 flex-wrap">

                        <a href="${pageContext.request.contextPath}/properties"
                           class="btn btn-outline-primary action-button">
                            + Add Property
                        </a>

                        <form action="${pageContext.request.contextPath}/user/compare/clear"
                              method="post">

                            <sec:csrfInput />

                            <button type="submit"
                                    class="btn btn-outline-danger action-button">
                                Clear Comparison
                            </button>
                        </form>

                    </div>
                </div>

                <div class="row g-4 mb-5">

                    <c:forEach var="house" items="${houses}">

                        <div class="col-lg-4 col-md-6">

                            <div class="card compare-card shadow-sm h-100">

                                <div class="property-placeholder">
                                    <div class="text-center">
                                        <div class="display-3">🏠</div>
                                        <small>Property Image</small>
                                    </div>
                                </div>

                                <div class="card-body">

                                    <c:if test="${not empty house.propertyType}">
                                        <span class="badge bg-primary mb-2">
                                            ${house.propertyType.name}
                                        </span>
                                    </c:if>

                                    <h5 class="fw-bold">
                                        ${house.title}
                                    </h5>

                                    <p class="text-muted small">
                                        📍 ${house.location.name}
                                    </p>

                                    <h4 class="text-primary fw-bold">
                                        ₹${house.price}
                                    </h4>

                                    <div class="row g-2 mt-3">

                                        <div class="col-4">
                                            <div class="bg-light rounded p-2 text-center">
                                                <small class="text-muted d-block">
                                                    Area
                                                </small>
                                                <span class="compare-value">
                                                    ${house.area}
                                                </span>
                                                <small class="text-muted">
                                                    sq.ft.
                                                </small>
                                            </div>
                                        </div>

                                        <div class="col-4">
                                            <div class="bg-light rounded p-2 text-center">
                                                <small class="text-muted d-block">
                                                    Beds
                                                </small>
                                                <span class="compare-value">
                                                    ${house.bedrooms}
                                                </span>
                                            </div>
                                        </div>

                                        <div class="col-4">
                                            <div class="bg-light rounded p-2 text-center">
                                                <small class="text-muted d-block">
                                                    Baths
                                                </small>
                                                <span class="compare-value">
                                                    ${house.bathrooms}
                                                </span>
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <div class="card-footer bg-white border-0 p-3">

                                    <div class="d-grid gap-2">

                                        <a href="${pageContext.request.contextPath}/properties/${house.id}"
                                           class="btn btn-outline-primary action-button">
                                            View Details
                                        </a>

                                        <form action="${pageContext.request.contextPath}/user/compare/remove"
                                              method="post">

                                            <sec:csrfInput />

                                            <input type="hidden"
                                                   name="houseId"
                                                   value="${house.id}">

                                            <button type="submit"
                                                    class="btn btn-outline-danger
                                                           action-button w-100">
                                                Remove from Compare
                                            </button>
                                        </form>

                                    </div>
                                </div>

                            </div>
                        </div>

                    </c:forEach>

                </div>

                <div class="card border-0 shadow-sm">

                    <div class="card-body p-0">

                        <div class="p-4">
                            <h4 class="fw-bold mb-1">
                                Detailed Comparison
                            </h4>

                            <p class="text-muted mb-0">
                                Compare important property characteristics.
                            </p>
                        </div>

                        <div class="table-responsive">

                            <table class="table table-bordered
                                          align-middle mb-0">

                                <thead class="table-light">
                                    <tr>
                                        <th>Feature</th>

                                        <c:forEach var="house" items="${houses}">
                                            <th class="text-center">
                                                ${house.title}
                                            </th>
                                        </c:forEach>
                                    </tr>
                                </thead>

                                <tbody>

                                    <tr>
                                        <th>Price</th>

                                        <c:forEach var="house" items="${houses}">
                                            <td class="text-center text-primary fw-bold">
                                                ₹${house.price}
                                            </td>
                                        </c:forEach>
                                    </tr>

                                    <tr>
                                        <th>Property Type</th>

                                        <c:forEach var="house" items="${houses}">
                                            <td class="text-center">
                                                ${house.propertyType.name}
                                            </td>
                                        </c:forEach>
                                    </tr>

                                    <tr>
                                        <th>Area</th>

                                        <c:forEach var="house" items="${houses}">
                                            <td class="text-center">
                                                ${house.area} sq.ft.
                                            </td>
                                        </c:forEach>
                                    </tr>

                                    <tr>
                                        <th>Bedrooms</th>

                                        <c:forEach var="house" items="${houses}">
                                            <td class="text-center">
                                                ${house.bedrooms}
                                            </td>
                                        </c:forEach>
                                    </tr>

                                    <tr>
                                        <th>Bathrooms</th>

                                        <c:forEach var="house" items="${houses}">
                                            <td class="text-center">
                                                ${house.bathrooms}
                                            </td>
                                        </c:forEach>
                                    </tr>

                                    <tr>
                                        <th>Floors</th>

                                        <c:forEach var="house" items="${houses}">
                                            <td class="text-center">
                                                ${house.floors}
                                            </td>
                                        </c:forEach>
                                    </tr>

                                    <tr>
                                        <th>Furnishing</th>

                                        <c:forEach var="house" items="${houses}">
                                            <td class="text-center">
                                                ${house.furnishing}
                                            </td>
                                        </c:forEach>
                                    </tr>

                                    <tr>
                                        <th>Location</th>

                                        <c:forEach var="house" items="${houses}">
                                            <td class="text-center">
                                                ${house.location.name}
                                            </td>
                                        </c:forEach>
                                    </tr>

                                    <tr>
                                        <th>Amenities</th>

                                        <c:forEach var="house" items="${houses}">
                                            <td>
                                                <c:choose>

                                                    <c:when test="${not empty house.amenities}">

                                                        <c:forEach var="amenity"
                                                                   items="${house.amenities}">

                                                            <span class="badge bg-light
                                                                         text-dark border m-1">
                                                                ${amenity.name}
                                                            </span>

                                                        </c:forEach>

                                                    </c:when>

                                                    <c:otherwise>
                                                        <span class="text-muted">
                                                            No amenities
                                                        </span>
                                                    </c:otherwise>

                                                </c:choose>
                                            </td>
                                        </c:forEach>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </c:otherwise>

        </c:choose>

    </div>
</main>

<jsp:include page="../common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>