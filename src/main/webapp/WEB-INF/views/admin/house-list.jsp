<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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

        .property-table th {
            white-space: nowrap;
        }

        .property-table td {
            vertical-align: middle;
        }

        .property-icon {
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            font-size: 24px;
        }

        .property-title {
            font-weight: 600;
        }

        .price-value {
            font-weight: 600;
            white-space: nowrap;
        }

        .action-buttons {
            white-space: nowrap;
        }

    </style>

</head>

<body>

    <jsp:include page="../common/navbar.jsp" />

    <main>

        <div class="container-fluid py-5 px-lg-5">

            <div class="d-flex justify-content-between
                        align-items-center flex-wrap gap-3 mb-4">

                <div>

                    <span class="badge bg-primary mb-2">
                        PROPERTY MANAGEMENT
                    </span>

                    <h1 class="fw-bold mb-1">
                        Properties
                    </h1>

                    <p class="text-muted mb-0">
                        Manage properties available on the SmartHouse platform.
                    </p>

                </div>

                <div class="d-flex gap-2">

                    <a
                        href="${pageContext.request.contextPath}/admin/dashboard"
                        class="btn btn-outline-secondary">

                        ← Dashboard

                    </a>

                    <a
                        href="${pageContext.request.contextPath}/admin/houses/new"
                        class="btn btn-primary">

                        + Add Property

                    </a>

                </div>

            </div>


            <c:if test="${not empty successMessage}">

                <div class="alert alert-success" role="alert">
                    ${successMessage}
                </div>

            </c:if>


            <c:if test="${not empty errorMessage}">

                <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                </div>

            </c:if>


            <div class="card border-0 shadow-sm">

                <div class="card-body p-0">

                    <c:choose>

                        <c:when test="${empty houses}">

                            <div class="text-center py-5">

                                <div class="display-4 mb-3">
                                    🏠
                                </div>

                                <h4 class="fw-bold">
                                    No Properties Found
                                </h4>

                                <p class="text-muted">
                                    Add the first property to the SmartHouse platform.
                                </p>

                                <a
                                    href="${pageContext.request.contextPath}/admin/houses/new"
                                    class="btn btn-primary">

                                    + Add Property

                                </a>

                            </div>

                        </c:when>


                        <c:otherwise>

                            <div class="p-4 border-bottom">

                                <h5 class="fw-bold mb-1">
                                    Property Directory
                                </h5>

                                <p class="text-muted small mb-0">

                                    Total properties:
                                    <strong>${houses.size()}</strong>

                                </p>

                            </div>


                            <div class="table-responsive">

                                <table class="table table-hover
                                              align-middle mb-0 property-table">

                                    <thead class="table-light">

                                        <tr>

                                            <th>#</th>

                                            <th>Property</th>

                                            <th>Type</th>

                                            <th>Location</th>

                                            <th>Area</th>

                                            <th>Bedrooms</th>

                                            <th>Price</th>

                                            <th class="text-end">
                                                Actions
                                            </th>

                                        </tr>

                                    </thead>


                                    <tbody>

                                        <c:forEach
                                            var="house"
                                            items="${houses}"
                                            varStatus="status">

                                            <tr>

                                                <td>
                                                    ${status.count}
                                                </td>


                                                <td>

                                                    <div class="d-flex
                                                                align-items-center gap-3">

                                                        <div class="property-icon">
                                                            🏠
                                                        </div>

                                                        <div>

                                                            <div class="property-title">
                                                                ${house.title}
                                                            </div>

                                                            <small class="text-muted">

                                                                Property ID:
                                                                ${house.id}

                                                            </small>

                                                        </div>

                                                    </div>

                                                </td>


                                                <td>

                                                    <c:choose>

                                                        <c:when test="${not empty house.propertyType}">

                                                            <span class="badge
                                                                         bg-light
                                                                         text-dark
                                                                         border">

                                                                ${house.propertyType.name}

                                                            </span>

                                                        </c:when>

                                                        <c:otherwise>

                                                            <span class="text-muted">
                                                                —
                                                            </span>

                                                        </c:otherwise>

                                                    </c:choose>

                                                </td>


                                                <td>

                                                    <c:choose>

                                                        <c:when test="${not empty house.location}">

                                                            ${house.location.name}

                                                        </c:when>

                                                        <c:otherwise>

                                                            <span class="text-muted">
                                                                —
                                                            </span>

                                                        </c:otherwise>

                                                    </c:choose>

                                                </td>


                                                <td>

                                                    ${house.area}

                                                    <span class="text-muted">
                                                        sq.ft.
                                                    </span>

                                                </td>


                                                <td>

                                                    <span class="badge
                                                                 bg-light
                                                                 text-dark
                                                                 border">

                                                        ${house.bedrooms} BHK

                                                    </span>

                                                </td>


                                                <td>

                                                    <span class="price-value">

                                                        <c:choose>

                                                            <%-- One crore or more --%>

                                                            <c:when test="${house.price >= 10000000}">

                                                                ₹<fmt:formatNumber
                                                                    value="${house.price / 10000000}"
                                                                    minFractionDigits="2"
                                                                    maxFractionDigits="2" />
                                                                Cr

                                                            </c:when>


                                                            <%-- Below one crore --%>

                                                            <c:otherwise>

                                                                ₹<fmt:formatNumber
                                                                    value="${house.price}"
                                                                    type="number"
                                                                    groupingUsed="true"
                                                                    maxFractionDigits="0" />

                                                            </c:otherwise>

                                                        </c:choose>

                                                    </span>

                                                </td>


                                                <td class="text-end">

                                                    <div class="d-flex
                                                                justify-content-end
                                                                gap-2
                                                                action-buttons">

                                                        <a
                                                            href="${pageContext.request.contextPath}/properties/${house.id}"
                                                            class="btn btn-sm btn-outline-secondary">

                                                            View

                                                        </a>


                                                        <a
                                                            href="${pageContext.request.contextPath}/admin/houses/edit/${house.id}"
                                                            class="btn btn-sm btn-outline-primary">

                                                            Edit

                                                        </a>


                                                        <form
                                                            action="${pageContext.request.contextPath}/admin/houses/delete/${house.id}"
                                                            method="post"
                                                            class="d-inline">

                                                            <sec:csrfInput />

                                                            <button
                                                                type="submit"
                                                                class="btn btn-sm btn-outline-danger"
                                                                onclick="return confirm('Are you sure you want to delete this property?');">

                                                                Delete

                                                            </button>

                                                        </form>

                                                    </div>

                                                </td>

                                            </tr>

                                        </c:forEach>

                                    </tbody>

                                </table>

                            </div>

                        </c:otherwise>

                    </c:choose>

                </div>

            </div>


            <div class="alert alert-light border mt-4">

                <div class="d-flex">

                    <div class="me-3 fs-4">
                        🏡
                    </div>

                    <div>

                        <h6 class="fw-bold mb-1">
                            Property Management
                        </h6>

                        <p class="text-muted small mb-0">

                            Properties use the configured location,
                            property type and amenities master data.
                            These properties are also used for property
                            browsing, comparison and analytics.

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