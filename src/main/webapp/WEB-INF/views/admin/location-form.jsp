<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        ${empty location.id ? 'Add Location' : 'Edit Location'} - SmartHouse
    </title>

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

        <div class="row justify-content-center">

            <div class="col-lg-7">


                <!-- HEADER -->

                <div class="text-center mb-5">

                    <span class="badge bg-primary mb-3">
                        MASTER DATA
                    </span>

                    <h1 class="fw-bold">

                        ${empty location.id
                            ? 'Add Location'
                            : 'Edit Location'}

                    </h1>

                    <p class="text-muted">

                        ${empty location.id
                            ? 'Add a local area and associate it with a city.'
                            : 'Update the selected location information.'}

                    </p>

                </div>


                <!-- FORM CARD -->

                <div class="card border-0 shadow-sm">

                    <div class="card-body p-4 p-md-5">


                        <form:form
                            modelAttribute="location"
                            method="post"
                            action="${pageContext.request.contextPath}/admin/locations/save">


                            <!-- CSRF -->

                            <sec:csrfInput />


                            <!-- LOCATION NAME -->

                            <div class="mb-4">

                                <label
                                    for="name"
                                    class="form-label fw-semibold">

                                    Location Name

                                </label>

                                <form:input
                                    path="name"
                                    id="name"
                                    cssClass="form-control form-control-lg"
                                    placeholder="Enter location name"
                                    maxlength="100"
                                    required="required" />

                                <form:errors
                                    path="name"
                                    cssClass="text-danger small d-block mt-1" />

                                <div class="form-text">

                                    Example: Wakad, Baner, Hinjewadi,
                                    Kharadi or Andheri.

                                </div>

                            </div>


                            <!-- CITY -->

                            <div class="mb-4">

                                <label
                                    for="city"
                                    class="form-label fw-semibold">

                                    City

                                </label>

                                <form:select
                                    path="city.id"
                                    id="city"
                                    cssClass="form-select form-select-lg"
                                    required="required">

                                    <form:option
                                        value=""
                                        label="Select city" />

                                    <form:options
                                        items="${cities}"
                                        itemValue="id"
                                        itemLabel="name" />

                                </form:select>

                                <form:errors
                                    path="city"
                                    cssClass="text-danger small d-block mt-1" />

                                <div class="form-text">

                                    Select the city in which this
                                    location is situated.

                                </div>

                            </div>


                            <!-- HIERARCHY PREVIEW -->

                            <div class="alert alert-light border">

                                <div class="d-flex">

                                    <div class="me-3 fs-4">
                                        📍
                                    </div>

                                    <div>

                                        <h6 class="fw-bold">
                                            Location Hierarchy
                                        </h6>

                                        <p class="text-muted small mb-0">

                                            State → District → City →
                                            Location → Property

                                        </p>

                                    </div>

                                </div>

                            </div>


                            <!-- ACTION BUTTONS -->

                            <div class="d-flex
                                        justify-content-between
                                        align-items-center
                                        flex-wrap
                                        gap-2
                                        mt-4">


                                <a
                                    href="${pageContext.request.contextPath}/admin/locations"
                                    class="btn btn-outline-secondary">

                                    ← Cancel

                                </a>


                                <button
                                    type="submit"
                                    class="btn btn-primary btn-lg px-4">

                                    ${empty location.id
                                        ? 'Add Location'
                                        : 'Update Location'}

                                </button>

                            </div>

                        </form:form>

                    </div>

                </div>


                <!-- INFORMATION -->

                <div class="text-center mt-4">

                    <small class="text-muted">

                        Only administrators can manage location
                        master data.

                    </small>

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