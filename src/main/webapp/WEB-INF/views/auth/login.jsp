<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Login - SmartHouse</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/smarthouse.css">

    <style>

        /* Password field with eye button */
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

                <div class="col-md-6 col-lg-5">

                    <div class="card border-0 shadow-sm">

                        <div class="card-body p-4 p-md-5">

                            <!-- HEADER -->

                            <div class="text-center mb-4">

                                <h2 class="fw-bold">
                                    Welcome Back
                                </h2>

                                <p class="text-muted mb-0">
                                    Login to your SmartHouse account
                                </p>

                            </div>


                            <!-- LOGIN ERROR -->

                            <c:if test="${param.error != null}">

                                <div class="alert alert-danger"
                                     role="alert">

                                    <strong>Login failed.</strong>
                                    Invalid email or password.

                                </div>

                            </c:if>


                            <!-- LOGOUT MESSAGE -->

                            <c:if test="${param.logout != null}">

                                <div class="alert alert-success"
                                     role="alert">

                                    You have been logged out successfully.

                                </div>

                            </c:if>


                            <!-- LOGIN FORM -->

                            <form
                                action="${pageContext.request.contextPath}/login"
                                method="post">


                                <!-- EMAIL -->

                                <div class="mb-3">

                                    <label
                                        for="email"
                                        class="form-label fw-semibold">

                                        Email Address

                                    </label>

                                    <input
                                        type="email"
                                        id="email"
                                        name="username"
                                        class="form-control"
                                        placeholder="Enter your email"
                                        autocomplete="email"
                                        required>

                                </div>


                                <!-- PASSWORD -->

                                <div class="mb-3">

                                    <label
                                        for="password"
                                        class="form-label fw-semibold">

                                        Password

                                    </label>

                                    <div class="password-container">

                                        <input
                                            type="password"
                                            id="password"
                                            name="password"
                                            class="form-control"
                                            placeholder="Enter your password"
                                            autocomplete="current-password"
                                            required>

                                        <button
                                            type="button"
                                            id="togglePassword"
                                            class="eye-button"
                                            aria-label="Show password"
                                            title="Show password"
                                            onclick="togglePasswordVisibility()">

                                            👁️

                                        </button>

                                    </div>

                                </div>


                                <!-- CSRF TOKEN -->

                                <sec:csrfInput />


                                <!-- LOGIN BUTTON -->

                                <div class="d-grid mt-4">

                                    <button
                                        type="submit"
                                        class="btn btn-primary btn-lg">

                                        Login

                                    </button>

                                </div>

                            </form>


                            <!-- REGISTER LINK -->

                            <div class="text-center mt-4">

                                <p class="text-muted mb-0">

                                    Don't have an account?

                                    <a
                                        href="${pageContext.request.contextPath}/register"
                                        class="text-decoration-none fw-semibold">

                                        Create an account

                                    </a>

                                </p>

                            </div>

                        </div>

                    </div>


                    <!-- SECURITY NOTE -->

                    <div class="text-center mt-3">

                        <small class="text-muted">

                            Your account is protected by secure authentication.

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


    <!-- SHOW/HIDE PASSWORD SCRIPT -->

    <script>

        function togglePasswordVisibility() {

            const passwordInput =
                document.getElementById("password");

            const toggleButton =
                document.getElementById("togglePassword");

            if (passwordInput.type === "password") {

                passwordInput.type = "text";

                toggleButton.textContent = "🙈";

                toggleButton.setAttribute(
                    "aria-label",
                    "Hide password"
                );

                toggleButton.setAttribute(
                    "title",
                    "Hide password"
                );

            } else {

                passwordInput.type = "password";

                toggleButton.textContent = "👁️";

                toggleButton.setAttribute(
                    "aria-label",
                    "Show password"
                );

                toggleButton.setAttribute(
                    "title",
                    "Show password"
                );

            }

        }

    </script>

</body>

</html>