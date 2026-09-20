<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Create Account - SmartHouse</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/smarthouse.css">

    <style>
        .password-container {
            position: relative;
        }

        .password-container input {
            padding-right: 48px;
        }

        .eye-button {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            border: none;
            background: transparent;
            color: #6c757d;
            font-size: 20px;
            cursor: pointer;
            padding: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .eye-button:hover {
            color: #0d6efd;
        }

        .eye-button:focus {
            outline: none;
            box-shadow: none;
        }
    </style>
</head>

<body class="bg-light">

    <jsp:include page="../common/navbar.jsp" />

    <main>
        <div class="container py-5">

            <div class="row justify-content-center">

                <div class="col-md-7 col-lg-6">

                    <div class="card border-0 shadow-sm">

                        <div class="card-body p-4 p-md-5">

                            <!-- HEADER -->
                            <div class="text-center mb-4">

                                <h2 class="fw-bold">
                                    Create Your Account
                                </h2>

                                <p class="text-muted mb-0">
                                    Join SmartHouse and explore smarter property decisions.
                                </p>

                            </div>

                            <!-- GENERAL ERROR -->
                            <c:if test="${registrationError != null}">

                                <div class="alert alert-danger">
                                    ${registrationError}
                                </div>

                            </c:if>

                            <!-- REGISTRATION FORM -->
                            <form:form
                                modelAttribute="registrationRequest"
                                method="post"
                                action="${pageContext.request.contextPath}/register">

                                <!-- CSRF -->
                                <sec:csrfInput />

                                <!-- NAME -->
                                <div class="mb-3">

                                    <label
                                        for="name"
                                        class="form-label fw-semibold">
                                        Full Name
                                    </label>

                                    <form:input
                                        path="name"
                                        id="name"
                                        cssClass="form-control"
                                        placeholder="Enter your full name"
                                        autocomplete="name" />

                                    <form:errors
                                        path="name"
                                        cssClass="text-danger small d-block mt-1" />

                                </div>

                                <!-- EMAIL -->
                                <div class="mb-3">

                                    <label
                                        for="email"
                                        class="form-label fw-semibold">
                                        Email Address
                                    </label>

                                    <form:input
                                        path="email"
                                        id="email"
                                        type="email"
                                        cssClass="form-control"
                                        placeholder="Enter your email address"
                                        autocomplete="email" />

                                    <form:errors
                                        path="email"
                                        cssClass="text-danger small d-block mt-1" />

                                </div>

                                <!-- PASSWORD -->
                                <div class="mb-3">

                                    <label
                                        for="password"
                                        class="form-label fw-semibold">
                                        Password
                                    </label>

                                    <div class="password-container">

                                        <form:password
                                            path="password"
                                            id="password"
                                            cssClass="form-control"
                                            placeholder="Create a password"
                                            autocomplete="new-password" />

                                        <button
                                            type="button"
                                            id="togglePassword"
                                            class="eye-button"
                                            aria-label="Show password"
                                            title="Show password"
                                            onclick="togglePasswordVisibility('password', 'togglePassword')">
                                            👁️
                                        </button>

                                    </div>

                                    <form:errors
                                        path="password"
                                        cssClass="text-danger small d-block mt-1" />

                                    <div class="form-text">
                                        Password must contain at least 8 characters.
                                    </div>

                                </div>

                                <!-- CONFIRM PASSWORD -->
                                <div class="mb-3">

                                    <label
                                        for="confirmPassword"
                                        class="form-label fw-semibold">
                                        Confirm Password
                                    </label>

                                    <div class="password-container">

                                        <form:password
                                            path="confirmPassword"
                                            id="confirmPassword"
                                            cssClass="form-control"
                                            placeholder="Re-enter your password"
                                            autocomplete="new-password" />

                                        <button
                                            type="button"
                                            id="toggleConfirmPassword"
                                            class="eye-button"
                                            aria-label="Show password"
                                            title="Show password"
                                            onclick="togglePasswordVisibility('confirmPassword', 'toggleConfirmPassword')">
                                            👁️
                                        </button>

                                    </div>

                                    <form:errors
                                        path="confirmPassword"
                                        cssClass="text-danger small d-block mt-1" />

                                </div>

                                <!-- REGISTER BUTTON -->
                                <div class="d-grid mt-4">

                                    <button
                                        type="submit"
                                        class="btn btn-primary btn-lg">
                                        Create Account
                                    </button>

                                </div>

                            </form:form>

                            <!-- LOGIN LINK -->
                            <div class="text-center mt-4">

                                <p class="text-muted mb-0">

                                    Already have an account?

                                    <a
                                        href="${pageContext.request.contextPath}/login"
                                        class="text-decoration-none fw-semibold">
                                        Login here
                                    </a>

                                </p>

                            </div>

                        </div>

                    </div>

                    <!-- INFORMATION -->
                    <div class="text-center mt-3">

                        <small class="text-muted">

                            By creating an account, you can save predictions,
                            favorite properties and compare properties.

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

    <!-- PASSWORD VISIBILITY SCRIPT -->
    <script>
        function togglePasswordVisibility(inputId, buttonId) {

            const passwordInput = document.getElementById(inputId);
            const toggleButton = document.getElementById(buttonId);

            if (passwordInput.type === "password") {

                passwordInput.type = "text";

                toggleButton.textContent = "🙈";
                toggleButton.setAttribute("aria-label", "Hide password");
                toggleButton.setAttribute("title", "Hide password");

            } else {

                passwordInput.type = "password";

                toggleButton.textContent = "👁️";
                toggleButton.setAttribute("aria-label", "Show password");
                toggleButton.setAttribute("title", "Show password");

            }
        }
    </script>

</body>
</html>