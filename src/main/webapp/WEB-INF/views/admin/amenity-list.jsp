<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Amenities - SmartHouse</title>

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

            <div class="d-flex justify-content-between
                        align-items-center flex-wrap gap-3 mb-4">

                <div>
                    <span class="badge bg-primary mb-2">
                        MASTER DATA
                    </span>

                    <h1 class="fw-bold mb-1">
                        Amenities
                    </h1>

                    <p class="text-muted mb-0">
                        Manage amenities that can be associated
                        with SmartHouse properties.
                    </p>
                </div>

                <div class="d-flex gap-2">

                    <a
                        href="${pageContext.request.contextPath}/admin/dashboard"
                        class="btn btn-outline-secondary">

                        ← Dashboard
                    </a>

                    <a
                        href="${pageContext.request.contextPath}/admin/amenities/new"
                        class="btn btn-primary">

                        + Add Amenity
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

                        <c:when test="${empty amenities}">

                            <div class="text-center py-5">

                                <div class="display-4 mb-3">
                                    ⭐
                                </div>

                                <h4 class="fw-bold">
                                    No Amenities Found
                                </h4>

                                <p class="text-muted">
                                    Add amenities that can later be assigned
                                    to properties.
                                </p>

                                <a
                                    href="${pageContext.request.contextPath}/admin/amenities/new"
                                    class="btn btn-primary">

                                    + Add Amenity
                                </a>

                            </div>

                        </c:when>

                        <c:otherwise>

                            <div class="p-4 border-bottom">

                                <h5 class="fw-bold mb-1">
                                    Amenity Directory
                                </h5>

                                <p class="text-muted small mb-0">
                                    Total amenities:
                                    <strong>${amenities.size()}</strong>
                                </p>

                            </div>

                            <div class="table-responsive">

                                <table class="table table-hover
                                              align-middle mb-0">

                                    <thead class="table-light">

                                        <tr>
                                            <th>#</th>
                                            <th>Amenity</th>
                                            <th>ID</th>
                                            <th class="text-end">
                                                Actions
                                            </th>
                                        </tr>

                                    </thead>

                                    <tbody>

                                        <c:forEach
                                            var="amenity"
                                            items="${amenities}"
                                            varStatus="status">

                                            <tr>

                                                <td>
                                                    ${status.count}
                                                </td>

                                                <td>
                                                    <div class="d-flex
                                                                align-items-center
                                                                gap-3">

                                                        <div
                                                            class="rounded-circle
                                                                   bg-light
                                                                   border
                                                                   d-flex
                                                                   align-items-center
                                                                   justify-content-center"
                                                            style="width: 42px;
                                                                   height: 42px;">

                                                            ⭐

                                                        </div>

                                                        <span class="fw-semibold">
                                                            ${amenity.name}
                                                        </span>

                                                    </div>
                                                </td>

                                                <td>
                                                    <span class="text-muted">
                                                        ${amenity.id}
                                                    </span>
                                                </td>

                                                <td class="text-end">

                                                    <div class="d-flex
                                                                justify-content-end
                                                                gap-2">

                                                        <a
                                                            href="${pageContext.request.contextPath}/admin/amenities/edit/${amenity.id}"
                                                            class="btn btn-sm btn-outline-primary">

                                                            Edit
                                                        </a>

                                                        <form
                                                            action="${pageContext.request.contextPath}/admin/amenities/delete/${amenity.id}"
                                                            method="post"
                                                            class="d-inline">

                                                            <sec:csrfInput />

                                                            <button
                                                                type="submit"
                                                                class="btn btn-sm btn-outline-danger"
                                                                onclick="return confirm('Are you sure you want to delete this amenity?');">

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

                        <h6 class="fw-bold mb-2">
                            Common Property Amenities
                        </h6>

                        <p class="text-muted small mb-0">
                            Parking · Swimming Pool · Gym · Lift ·
                            Security · Power Backup · WiFi · Garden ·
                            Club House · CCTV · Children Play Area ·
                            Intercom · Visitor Parking · Fire Safety
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