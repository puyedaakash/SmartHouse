<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Profile - SmartHouse</title>

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

            <div class="col-xl-9">


                <!-- PAGE HEADER -->

                <div class="text-center mb-5">

                    <span class="badge bg-primary mb-3">
                        Account
                    </span>

                    <h1 class="fw-bold">
                        My Profile
                    </h1>

                    <p class="text-muted">
                        Manage your SmartHouse account information.
                    </p>

                </div>


                <!-- SUCCESS MESSAGE -->

                <c:if test="${not empty successMessage}">

                    <div class="alert alert-success"
                         role="alert">

                        ${successMessage}

                    </div>

                </c:if>


                <!-- ERROR MESSAGE -->

                <c:if test="${not empty errorMessage}">

                    <div class="alert alert-danger"
                         role="alert">

                        ${errorMessage}

                    </div>

                </c:if>


                <div class="row g-4">


                    <!-- ACCOUNT INFORMATION -->

                    <div class="col-lg-5">

                        <div class="card border-0 shadow-sm h-100">

                            <div class="card-body p-4">


                                <div class="text-center mb-4">

                                    <div
                                        class="rounded-circle
                                               bg-primary
                                               text-white
                                               d-inline-flex
                                               align-items-center
                                               justify-content-center"
                                        style="width: 90px;
                                               height: 90px;
                                               font-size: 2rem;">

                                        👤

                                    </div>

                                    <h4 class="fw-bold mt-3 mb-1">

                                        ${user.name}

                                    </h4>

                                    <p class="text-muted mb-0">

                                        SmartHouse User

                                    </p>

                                </div>


                                <hr>


                                <div class="mb-3">

                                    <small class="text-muted d-block">
                                        Full Name
                                    </small>

                                    <span class="fw-semibold">
                                        ${user.name}
                                    </span>

                                </div>


                                <div class="mb-3">

                                    <small class="text-muted d-block">
                                        Email Address
                                    </small>

                                    <span class="fw-semibold">
                                        ${user.email}
                                    </span>

                                </div>


                                <div>

                                    <small class="text-muted d-block">
                                        Account Status
                                    </small>

                                    <span class="badge bg-success">
                                        Active
                                    </span>

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- EDIT PROFILE -->

                    <div class="col-lg-7">

                        <div class="card border-0 shadow-sm mb-4">

                            <div class="card-body p-4">

                                <h5 class="fw-bold mb-1">
                                    Update Profile
                                </h5>

                                <p class="text-muted small mb-4">
                                    Update your display name.
                                </p>


                                <form
                                    method="post"
                                    action="${pageContext.request.contextPath}/user/profile/update-name">


                                    <sec:csrfInput />


                                    <div class="mb-3">

                                        <label
                                            for="name"
                                            class="form-label fw-semibold">

                                            Full Name

                                        </label>

                                        <input
                                            type="text"
                                            id="name"
                                            name="name"
                                            value="${user.name}"
                                            class="form-control"
                                            minlength="2"
                                            maxlength="100"
                                            required>

                                    </div>


                                    <button
                                        type="submit"
                                        class="btn btn-primary">

                                        Save Changes

                                    </button>

                                </form>

                            </div>

                        </div>


                        <!-- CHANGE PASSWORD -->

                        <div class="card border-0 shadow-sm">

                            <div class="card-body p-4">

                                <h5 class="fw-bold mb-1">
                                    Change Password
                                </h5>

                                <p class="text-muted small mb-4">
                                    Use a strong password to protect your account.
                                </p>


                                <form
                                    method="post"
                                    action="${pageContext.request.contextPath}/user/profile/change-password">


                                    <sec:csrfInput />


                                    <!-- CURRENT PASSWORD -->

                                    <div class="mb-3">

                                        <label
                                            for="currentPassword"
                                            class="form-label fw-semibold">

                                            Current Password

                                        </label>

                                        <input
                                            type="password"
                                            id="currentPassword"
                                            name="currentPassword"
                                            class="form-control"
                                            autocomplete="current-password"
                                            required>

                                    </div>


                                    <!-- NEW PASSWORD -->

                                    <div class="mb-3">

                                        <label
                                            for="newPassword"
                                            class="form-label fw-semibold">

                                            New Password

                                        </label>

                                        <input
                                            type="password"
                                            id="newPassword"
                                            name="newPassword"
                                            class="form-control"
                                            minlength="8"
                                            autocomplete="new-password"
                                            required>

                                        <div class="form-text">
                                            Password must contain at least 8 characters.
                                        </div>

                                    </div>


                                    <!-- CONFIRM PASSWORD -->

                                    <div class="mb-3">

                                        <label
                                            for="confirmPassword"
                                            class="form-label fw-semibold">

                                            Confirm New Password

                                        </label>

                                        <input
                                            type="password"
                                            id="confirmPassword"
                                            name="confirmPassword"
                                            class="form-control"
                                            minlength="8"
                                            autocomplete="new-password"
                                            required>

                                    </div>


                                    <button
                                        type="submit"
                                        class="btn btn-outline-primary">

                                        Change Password

                                    </button>

                                </form>

                            </div>

                        </div>

                    </div>

                </div>


                <!-- QUICK LINKS -->

                <div class="card border-0 shadow-sm mt-4">

                    <div class="card-body p-4">

                        <h5 class="fw-bold mb-3">
                            Quick Access
                        </h5>

                        <div class="d-flex
                                    flex-wrap
                                    gap-2">

                            <a
                                href="${pageContext.request.contextPath}/user/prediction"
                                class="btn btn-outline-primary">

                                🔮 Predict Price

                            </a>

                            <a
                                href="${pageContext.request.contextPath}/user/prediction-history"
                                class="btn btn-outline-primary">

                                📊 Prediction History

                            </a>

                            <a
                                href="${pageContext.request.contextPath}/user/favorites"
                                class="btn btn-outline-danger">

                                ❤️ Favorites

                            </a>

                            <a
                                href="${pageContext.request.contextPath}/user/compare"
                                class="btn btn-outline-secondary">

                                ⚖️ Compare

                            </a>

                            <a
                                href="${pageContext.request.contextPath}/user/dashboard"
                                class="btn btn-outline-dark">

                                ← Dashboard

                            </a>

                        </div>

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

</body>

</html>