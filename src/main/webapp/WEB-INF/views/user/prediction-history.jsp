<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Prediction History - SmartHouse</title>

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

            <div class="d-flex justify-content-between align-items-center
                        flex-wrap gap-3 mb-4">

                <div>
                    <span class="badge bg-primary mb-2">
                        MY ACTIVITY
                    </span>

                    <h1 class="fw-bold mb-1">
                        Prediction History
                    </h1>

                    <p class="text-muted mb-0">
                        Review the house price predictions you have generated.
                    </p>
                </div>

                <a
                    href="${pageContext.request.contextPath}/user/prediction"
                    class="btn btn-primary">

                    + New Prediction

                </a>
            </div>

            <div class="card border-0 shadow-sm">

                <div class="card-body p-0">

                    <c:choose>

                        <c:when test="${empty predictions}">

                            <div class="text-center py-5 px-3">

                                <div class="display-4 mb-3">
                                    🤖
                                </div>

                                <h4 class="fw-bold">
                                    No Predictions Yet
                                </h4>

                                <p class="text-muted mx-auto"
                                   style="max-width: 500px;">

                                    You have not generated any house price
                                    predictions yet. Create your first
                                    prediction to see it appear here.

                                </p>

                                <a
                                    href="${pageContext.request.contextPath}/user/prediction"
                                    class="btn btn-primary mt-2">

                                    Predict House Price

                                </a>

                            </div>

                        </c:when>

                        <c:otherwise>

                            <div class="table-responsive">

                                <table class="table table-hover align-middle mb-0">

                                    <thead class="table-light">

                                        <tr>
                                            <th class="px-4">#</th>
                                            <th>Date &amp; Time</th>
                                            <th>Property Type</th>
                                            <th>Location</th>
                                            <th>Area</th>
                                            <th>Beds / Baths</th>
                                            <th class="text-end px-4">
                                                Predicted Price
                                            </th>
                                        </tr>

                                    </thead>

                                    <tbody>

                                        <c:forEach
                                            var="prediction"
                                            items="${predictions}"
                                            varStatus="status">

                                            <tr>

                                                <td class="px-4 fw-semibold">
                                                    ${status.index + 1}
                                                </td>

                                                <td>

                                                    <c:choose>

                                                        <c:when
                                                            test="${not empty prediction.predictedAt}">

                                                            <span
                                                                class="prediction-date"
                                                                data-date="${prediction.predictedAt}">

                                                                ${prediction.predictedAt}

                                                            </span>

                                                        </c:when>

                                                        <c:otherwise>
                                                            —
                                                        </c:otherwise>

                                                    </c:choose>

                                                </td>

                                                <td>

                                                    <c:choose>

                                                        <c:when
                                                            test="${not empty prediction.propertyType}">

                                                            ${prediction.propertyType.name}

                                                        </c:when>

                                                        <c:otherwise>
                                                            —
                                                        </c:otherwise>

                                                    </c:choose>

                                                </td>

                                                <td>

                                                    <c:choose>

                                                        <c:when
                                                            test="${not empty prediction.location}">

                                                            <strong>
                                                                ${prediction.location.name}
                                                            </strong>

                                                            <c:if
                                                                test="${not empty prediction.location.city}">

                                                                <br>

                                                                <small class="text-muted">
                                                                    ${prediction.location.city.name}
                                                                </small>

                                                            </c:if>

                                                        </c:when>

                                                        <c:otherwise>
                                                            —
                                                        </c:otherwise>

                                                    </c:choose>

                                                </td>

                                                <td>

                                                    <c:choose>

                                                        <c:when
                                                            test="${not empty prediction.area}">

                                                            ${prediction.area}
                                                            sq.ft.

                                                        </c:when>

                                                        <c:otherwise>
                                                            —
                                                        </c:otherwise>

                                                    </c:choose>

                                                </td>

                                                <td>

                                                    <span class="fw-semibold">
                                                        ${prediction.bedrooms}
                                                    </span>

                                                    <span class="text-muted">
                                                        bed
                                                    </span>

                                                    <span class="mx-1">/</span>

                                                    <span class="fw-semibold">
                                                        ${prediction.bathrooms}
                                                    </span>

                                                    <span class="text-muted">
                                                        bath
                                                    </span>

                                                </td>

                                                <td class="text-end px-4">

                                                    <span
                                                        class="badge bg-success-subtle
                                                               text-success-emphasis
                                                               fs-6">

                                                        ₹<fmt:formatNumber
                                                            value="${prediction.predictedPrice}"
                                                            type="number"
                                                            groupingUsed="true"
                                                            maxFractionDigits="0" />

                                                    </span>

                                                </td>

                                            </tr>

                                        </c:forEach>

                                    </tbody>

                                </table>

                            </div>

                            <div
                                class="border-top p-3 px-4 d-flex
                                       justify-content-between align-items-center
                                       flex-wrap gap-2">

                                <small class="text-muted">

                                    Total predictions:
                                    <strong>${predictions.size()}</strong>

                                </small>

                                <a
                                    href="${pageContext.request.contextPath}/user/prediction"
                                    class="btn btn-sm btn-primary">

                                    Create New Prediction

                                </a>

                            </div>

                        </c:otherwise>

                    </c:choose>

                </div>

            </div>

            <div class="row g-4 mt-4">

                <div class="col-md-6">

                    <div class="card border-0 shadow-sm h-100">

                        <div class="card-body">

                            <h5 class="fw-bold">
                                📊 About Your History
                            </h5>

                            <p class="text-muted small mb-0">

                                Every successful prediction is stored in
                                your account so you can review previous
                                estimates and compare your property
                                evaluations over time.

                            </p>

                        </div>

                    </div>

                </div>

                <div class="col-md-6">

                    <div class="card border-0 shadow-sm h-100">

                        <div class="card-body">

                            <h5 class="fw-bold">
                                🤖 Remember
                            </h5>

                            <p class="text-muted small mb-0">

                                Prediction results are estimates generated
                                by the SmartHouse machine learning model.
                                Actual property prices may differ based on
                                market conditions and property-specific
                                factors.

                            </p>

                        </div>

                    </div>

                </div>

            </div>

        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
    </script>

    <script>

        document.querySelectorAll(".prediction-date").forEach(function(element) {

            const rawDate = element.getAttribute("data-date");

            if (rawDate) {

                const formattedDate = rawDate.replace(
                    /\.(\d{3})\d+$/,
                    ".$1"
                );

                const date = new Date(formattedDate);

                if (!isNaN(date.getTime())) {

                    element.textContent = date.toLocaleString("en-IN", {
                        day: "2-digit",
                        month: "short",
                        year: "numeric",
                        hour: "2-digit",
                        minute: "2-digit",
                        hour12: true
                    });

                }

            }

        });

    </script>

</body>

</html>