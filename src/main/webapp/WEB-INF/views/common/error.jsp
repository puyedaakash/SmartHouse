<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Error - SmartHouse</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/smarthouse.css">

</head>


<body class="bg-light">

<jsp:include page="navbar.jsp" />


<main>

    <div class="container py-5">

        <div class="row justify-content-center">

            <div class="col-lg-7 col-xl-6">


                <div class="card border-0 shadow-sm">

                    <div class="card-body text-center p-5">


                        <!-- ERROR ICON -->

                        <div class="display-1 mb-4">
                            ⚠️
                        </div>


                        <!-- TITLE -->

                        <h1 class="fw-bold mb-3">
                            Something Went Wrong
                        </h1>


                        <!-- MESSAGE -->

                        <p class="text-muted mb-4">

                            <c:choose>

                                <c:when test="${not empty errorMessage}">

                                    ${errorMessage}

                                </c:when>

                                <c:otherwise>

                                    We were unable to process your request.
                                    Please try again.

                                </c:otherwise>

                            </c:choose>

                        </p>


                        <!-- ACTIONS -->

                        <div class="d-flex
                                    justify-content-center
                                    flex-wrap
                                    gap-2">


                            <a
                                href="${pageContext.request.contextPath}/"
                                class="btn btn-primary px-4">

                                Go to Home

                            </a>


                            <button
                                type="button"
                                class="btn btn-outline-secondary px-4"
                                onclick="history.back();">

                                ← Go Back

                            </button>


                        </div>

                    </div>

                </div>


                <!-- SUPPORT MESSAGE -->

                <div class="text-center mt-4">

                    <small class="text-muted">

                        If the problem continues, please try again
                        after refreshing the page.

                    </small>

                </div>

            </div>

        </div>

    </div>

</main>


<jsp:include page="footer.jsp" />


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>