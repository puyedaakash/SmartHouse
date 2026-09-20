<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Manage Users - SmartHouse</title>

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
    <div class="container py-5">

        <div class="d-flex
                    justify-content-between
                    align-items-center
                    flex-wrap
                    gap-3
                    mb-4">

            <div>
                <span class="badge bg-primary mb-2">
                    USER MANAGEMENT
                </span>

                <h1 class="fw-bold mb-1">
                    Manage Users
                </h1>

                <p class="text-muted mb-0">
                    View registered users on the SmartHouse platform.
                </p>
            </div>

            <a
                href="${pageContext.request.contextPath}/admin/dashboard"
                class="btn btn-outline-secondary">

                ← Dashboard

            </a>
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

                    <c:when test="${empty users}">

                        <div class="text-center py-5">

                            <div class="display-4 mb-3">
                                👥
                            </div>

                            <h4 class="fw-bold">
                                No Users Found
                            </h4>

                            <p class="text-muted mb-0">
                                There are currently no registered users.
                            </p>

                        </div>

                    </c:when>

                    <c:otherwise>

                        <div class="p-4 border-bottom">

                            <h5 class="fw-bold mb-1">
                                User Directory
                            </h5>

                            <p class="text-muted small mb-0">
                                Total users:
                                <strong>${users.size()}</strong>
                            </p>

                        </div>

                        <div class="table-responsive">

                            <table class="table table-hover
                                          align-middle mb-0">

                                <thead class="table-light">

                                    <tr>
                                        <th>#</th>
                                        <th>User ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Status</th>
                                    </tr>

                                </thead>

                                <tbody>

                                    <c:forEach
                                        var="user"
                                        items="${users}"
                                        varStatus="status">

                                        <tr>

                                            <td>
                                                ${status.count}
                                            </td>

                                            <td>
                                                ${user.id}
                                            </td>

                                            <td>
                                                <span class="fw-semibold">
                                                    ${user.name}
                                                </span>
                                            </td>

                                            <td>
                                                ${user.email}
                                            </td>

                                            <td>

                                                <c:choose>

                                                    <c:when test="${user.enabled}">

                                                        <span class="badge bg-success">
                                                            Active
                                                        </span>

                                                    </c:when>

                                                    <c:otherwise>

                                                        <span class="badge bg-danger">
                                                            Disabled
                                                        </span>

                                                    </c:otherwise>

                                                </c:choose>

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

    </div>
</main>

<jsp:include page="../common/footer.jsp" />

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>