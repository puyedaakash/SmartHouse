<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Favorites - SmartHouse</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/smarthouse.css">

    <style>
        body {
            background: #f6f8fb;
        }

        .page-header {
            padding: 45px 20px;
            border-radius: 22px;
            color: white;
            background: linear-gradient(135deg, #dc3545, #8b1e2d);
        }

        .favorite-card {
            border: none;
            border-radius: 18px;
            overflow: hidden;
            transition: 0.25s ease;
        }

        .favorite-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.12) !important;
        }

        .property-placeholder {
            height: 210px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        .property-price {
            color: #0d6efd;
            font-size: 1.4rem;
            font-weight: 700;
        }

        .feature-box {
            padding: 12px 5px;
            text-align: center;
            background: #f8f9fa;
            border-radius: 10px;
        }

        .feature-label {
            display: block;
            color: #6c757d;
            font-size: 0.78rem;
        }

        .action-button {
            border-radius: 10px;
            padding: 11px;
            font-weight: 600;
        }

        .empty-card {
            border: none;
            border-radius: 20px;
        }

        @media (max-width: 576px) {
            .page-header {
                padding: 30px 15px;
            }

            .page-header h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>

<body>

    <jsp:include page="../common/navbar.jsp" />

    <main>
        <div class="container py-5">

            <div class="page-header text-center mb-5">
                <div class="display-4 mb-2">❤️</div>

                <h1 class="fw-bold">My Favorites</h1>

                <p class="mb-0">
                    Properties you have saved for later.
                </p>
            </div>

            <!-- Success message -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show"
                     role="alert">
                    ${successMessage}

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="alert">
                    </button>
                </div>
            </c:if>

            <!-- Error message -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show"
                     role="alert">
                    ${errorMessage}

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="alert">
                    </button>
                </div>
            </c:if>

            <c:choose>

                <c:when test="${empty favorites}">

                    <div class="card empty-card shadow-sm">

                        <div class="card-body text-center py-5">

                            <div class="display-1 mb-3">🏠</div>

                            <h3 class="fw-bold">
                                No Favorite Properties
                            </h3>

                            <p class="text-muted mb-4">
                                You have not saved any properties yet.
                                Browse properties and add your favorites.
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
                                flex-wrap gap-3 mb-4">

                        <p class="text-muted mb-0">
                            <strong>${favorites.size()}</strong>
                            saved properties
                        </p>

                        <a href="${pageContext.request.contextPath}/properties"
                           class="btn btn-outline-primary action-button">

                            + Browse More Properties

                        </a>

                    </div>

                    <div class="row g-4">

                        <c:forEach var="favorite" items="${favorites}">

                            <c:set var="house" value="${favorite.house}" />

                            <div class="col-xl-4 col-lg-6 col-md-6">

                                <div class="card favorite-card shadow-sm h-100">

                                    <div class="property-placeholder">

                                        <div class="text-center">
                                            <div class="display-3">🏠</div>
                                            <small>Property Image</small>
                                        </div>

                                    </div>

                                    <div class="card-body p-4">

                                        <c:if test="${not empty house.propertyType}">

                                            <span class="badge bg-primary mb-2">
                                                ${house.propertyType.name}
                                            </span>

                                        </c:if>

                                        <h5 class="fw-bold">
                                            ${house.title}
                                        </h5>

                                        <p class="text-muted small">
                                            📍

                                            <c:choose>

                                                <c:when test="${not empty house.location}">
                                                    ${house.location.name}
                                                </c:when>

                                                <c:otherwise>
                                                    Location unavailable
                                                </c:otherwise>

                                            </c:choose>
                                        </p>

                                        <div class="property-price mb-3">
                                            ₹${house.price}
                                        </div>

                                        <div class="row g-2 mb-4">

                                            <div class="col-4">
                                                <div class="feature-box">
                                                    <strong>${house.area}</strong>
                                                    <span class="feature-label">
                                                        Sq.ft.
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="col-4">
                                                <div class="feature-box">
                                                    <strong>${house.bedrooms}</strong>
                                                    <span class="feature-label">
                                                        Beds
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="col-4">
                                                <div class="feature-box">
                                                    <strong>${house.bathrooms}</strong>
                                                    <span class="feature-label">
                                                        Baths
                                                    </span>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="d-grid gap-2">

                                            <!-- View property -->
                                            <a href="${pageContext.request.contextPath}/properties/${house.id}"
                                               class="btn btn-primary action-button">

                                                View Property

                                            </a>

                                            <!-- Remove from favorites -->
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/user/favorites/toggle/${house.id}">

                                                <sec:csrfInput />

                                                <button type="submit"
                                                        class="btn btn-outline-danger
                                                               action-button w-100">

                                                    ❤️ Remove from Favorites

                                                </button>

                                            </form>

                                            <!-- Add to compare -->
                                            <form action="${pageContext.request.contextPath}/user/compare/add"
                                                  method="post">

                                                <sec:csrfInput />

                                                <input type="hidden"
                                                       name="houseId"
                                                       value="${house.id}">

                                                <button type="submit"
                                                        class="btn btn-outline-secondary
                                                               action-button w-100">

                                                    ⚖️ Add to Compare

                                                </button>

                                            </form>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </c:forEach>

                    </div>

                    <div class="alert alert-light border mt-5">

                        <strong>💡 Manage Your Favorites</strong>

                        <p class="text-muted small mb-0 mt-2">
                            Your favorite properties are saved to your account.
                            You can review them or add them to your comparison list.
                        </p>

                    </div>

                    <div class="text-center mt-4">

                        <a href="${pageContext.request.contextPath}/user/dashboard"
                           class="btn btn-outline-secondary action-button">

                            ← Back to Dashboard

                        </a>

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