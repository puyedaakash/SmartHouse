<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">

        <!-- Brand -->
        <a class="navbar-brand fw-bold"
           href="${pageContext.request.contextPath}/">
            SmartHouse
        </a>

        <!-- Mobile Toggle -->
        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#mainNavbar"
                aria-controls="mainNavbar"
                aria-expanded="false"
                aria-label="Toggle navigation">

            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Content -->
        <div class="collapse navbar-collapse" id="mainNavbar">

            <!-- Left Navigation -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <!-- Home -->
                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/">
                        Home
                    </a>
                </li>

                <!-- Properties -->
                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/properties">
                        Properties
                    </a>
                </li>

                <!-- USER Navigation -->
                <sec:authorize access="hasRole('USER')">

                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/user/dashboard">
                            Dashboard
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/user/prediction">
                            Predict Price
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/user/favorites">
                            Favorites
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/user/compare">
                            Compare
                        </a>
                    </li>

                </sec:authorize>

                <!-- ADMIN Navigation -->
                <sec:authorize access="hasRole('ADMIN')">

                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/admin/dashboard">
                            Admin Dashboard
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/admin/analytics">
                            Analytics
                        </a>
                    </li>

                </sec:authorize>

            </ul>

            <!-- Right Navigation -->
            <ul class="navbar-nav align-items-lg-center">

                <!-- Anonymous User -->
                <sec:authorize access="isAnonymous()">

                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/login">
                            Login
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="btn btn-primary btn-sm ms-lg-2 px-3"
                           href="${pageContext.request.contextPath}/register">
                            Register
                        </a>
                    </li>

                </sec:authorize>

                <!-- Logged-in USER -->
                <sec:authorize access="hasRole('USER')">

                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/user/profile">
                            Profile
                        </a>
                    </li>

                    <!-- IMPORTANT:
                         Logout is POST because CSRF protection is enabled.
                    -->
                    <li class="nav-item ms-lg-2">

                        <form method="post"
                              action="${pageContext.request.contextPath}/logout"
                              class="d-inline">

                            <sec:csrfInput />

                            <button type="submit"
                                    class="btn btn-outline-light btn-sm px-3">
                                Logout
                            </button>

                        </form>

                    </li>

                </sec:authorize>

                <!-- Logged-in ADMIN -->
                <sec:authorize access="hasRole('ADMIN')">

                    <li class="nav-item ms-lg-2">

                        <form method="post"
                              action="${pageContext.request.contextPath}/logout"
                              class="d-inline">

                            <sec:csrfInput />

                            <button type="submit"
                                    class="btn btn-outline-light btn-sm px-3">
                                Logout
                            </button>

                        </form>

                    </li>

                </sec:authorize>

            </ul>

        </div>

    </div>
</nav>