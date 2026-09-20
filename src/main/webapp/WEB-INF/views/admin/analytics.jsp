<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Analytics - SmartHouse</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/smarthouse.css">

    <script
        src="https://cdn.jsdelivr.net/npm/chart.js">
    </script>

    <style>

        .analytics-card {
            border: none;
            border-radius: 16px;
        }

        .stat-card {
            border: none;
            border-radius: 16px;
            transition: transform 0.2s ease;
        }

        .stat-card:hover {
            transform: translateY(-3px);
        }

        .stat-icon {
            width: 55px;
            height: 55px;
            border-radius: 14px;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 1.5rem;
        }

        .chart-container {
            position: relative;
            height: 330px;
        }

        .analytics-table th {
            white-space: nowrap;
        }

    </style>

</head>


<body>

<jsp:include page="../common/navbar.jsp" />


<main>

    <div class="container py-5">


        <!-- PAGE HEADER -->

        <div class="text-center mb-5">

            <span class="badge bg-success mb-3">
                ADMIN ANALYTICS
            </span>

            <h1 class="fw-bold">
                SmartHouse Analytics
            </h1>

            <p class="text-muted">
                Monitor platform activity and property market statistics.
            </p>

        </div>


        <!-- ================================================= -->
        <!-- PLATFORM STATISTICS -->
        <!-- ================================================= -->

        <div class="row g-4 mb-5">


            <!-- USERS -->

            <div class="col-md-6 col-xl-3">

                <div class="card stat-card shadow-sm h-100">

                    <div class="card-body p-4">

                        <div class="stat-icon bg-primary-subtle mb-3">
                            👥
                        </div>

                        <small class="text-muted">
                            Total Users
                        </small>

                        <h2 class="fw-bold mb-0">
                            ${stats.totalUsers}
                        </h2>

                    </div>

                </div>

            </div>


            <!-- PROPERTIES -->

            <div class="col-md-6 col-xl-3">

                <div class="card stat-card shadow-sm h-100">

                    <div class="card-body p-4">

                        <div class="stat-icon bg-success-subtle mb-3">
                            🏠
                        </div>

                        <small class="text-muted">
                            Total Properties
                        </small>

                        <h2 class="fw-bold mb-0">
                            ${stats.totalProperties}
                        </h2>

                    </div>

                </div>

            </div>


            <!-- PREDICTIONS -->

            <div class="col-md-6 col-xl-3">

                <div class="card stat-card shadow-sm h-100">

                    <div class="card-body p-4">

                        <div class="stat-icon bg-info-subtle mb-3">
                            🔮
                        </div>

                        <small class="text-muted">
                            Total Predictions
                        </small>

                        <h2 class="fw-bold mb-0">
                            ${stats.totalPredictions}
                        </h2>

                    </div>

                </div>

            </div>


            <!-- FAVORITES -->

            <div class="col-md-6 col-xl-3">

                <div class="card stat-card shadow-sm h-100">

                    <div class="card-body p-4">

                        <div class="stat-icon bg-danger-subtle mb-3">
                            ❤️
                        </div>

                        <small class="text-muted">
                            Total Favorites
                        </small>

                        <h2 class="fw-bold mb-0">
                            ${stats.totalFavorites}
                        </h2>

                    </div>

                </div>

            </div>

        </div>


        <!-- ================================================= -->
        <!-- PROPERTY PRICE STATISTICS -->
        <!-- ================================================= -->

        <div class="row g-4 mb-5">


            <!-- AVERAGE -->

            <div class="col-md-4">

                <div class="card analytics-card shadow-sm h-100">

                    <div class="card-body p-4">

                        <small class="text-muted">
                            Average Property Price
                        </small>

                        <h3 class="fw-bold text-primary mt-2">
                            ${averagePropertyPriceFormatted}
                        </h3>

                    </div>

                </div>

            </div>


            <!-- HIGHEST -->

            <div class="col-md-4">

                <div class="card analytics-card shadow-sm h-100">

                    <div class="card-body p-4">

                        <small class="text-muted">
                            Highest Property Price
                        </small>

                        <h3 class="fw-bold text-danger mt-2">
                            ${highestPropertyPriceFormatted}
                        </h3>

                    </div>

                </div>

            </div>


            <!-- LOWEST -->

            <div class="col-md-4">

                <div class="card analytics-card shadow-sm h-100">

                    <div class="card-body p-4">

                        <small class="text-muted">
                            Lowest Property Price
                        </small>

                        <h3 class="fw-bold text-success mt-2">
                            ${lowestPropertyPriceFormatted}
                        </h3>

                    </div>

                </div>

            </div>

        </div>


        <!-- ================================================= -->
        <!-- CHARTS -->
        <!-- ================================================= -->

        <div class="row g-4 mb-5">


            <!-- PROPERTY TYPE DISTRIBUTION -->

            <div class="col-lg-6">

                <div class="card analytics-card shadow-sm">

                    <div class="card-body p-4">

                        <h5 class="fw-bold mb-1">
                            Property Distribution by Type
                        </h5>

                        <p class="text-muted small">
                            Number of properties for each property type.
                        </p>

                        <div class="chart-container">

                            <canvas id="propertyTypeChart"></canvas>

                        </div>

                    </div>

                </div>

            </div>


            <!-- CITY DISTRIBUTION -->

            <div class="col-lg-6">

                <div class="card analytics-card shadow-sm">

                    <div class="card-body p-4">

                        <h5 class="fw-bold mb-1">
                            Property Distribution by City
                        </h5>

                        <p class="text-muted small">
                            Number of properties available in each city.
                        </p>

                        <div class="chart-container">

                            <canvas id="cityChart"></canvas>

                        </div>

                    </div>

                </div>

            </div>


            <!-- AVERAGE PRICE TYPE -->

            <div class="col-lg-6">

                <div class="card analytics-card shadow-sm">

                    <div class="card-body p-4">

                        <h5 class="fw-bold mb-1">
                            Average Price by Property Type
                        </h5>

                        <p class="text-muted small">
                            Average property price for each property type.
                        </p>

                        <div class="chart-container">

                            <canvas id="propertyTypePriceChart"></canvas>

                        </div>

                    </div>

                </div>

            </div>


            <!-- AVERAGE PRICE CITY -->

            <div class="col-lg-6">

                <div class="card analytics-card shadow-sm">

                    <div class="card-body p-4">

                        <h5 class="fw-bold mb-1">
                            Average Price by City
                        </h5>

                        <p class="text-muted small">
                            Average property price across cities.
                        </p>

                        <div class="chart-container">

                            <canvas id="cityPriceChart"></canvas>

                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- ================================================= -->
        <!-- PROPERTY TYPE TABLE -->
        <!-- ================================================= -->

        <div class="card analytics-card shadow-sm mb-4">

            <div class="card-body p-4">

                <h5 class="fw-bold mb-1">
                    Property Type Analytics
                </h5>

                <p class="text-muted small">
                    Property count and average price by type.
                </p>


                <div class="table-responsive">

                    <table class="table table-hover
                                  align-middle
                                  analytics-table">

                        <thead class="table-light">

                            <tr>

                                <th>
                                    Property Type
                                </th>

                                <th>
                                    Properties
                                </th>

                                <th>
                                    Average Price
                                </th>

                            </tr>

                        </thead>


                        <tbody>

                            <c:forEach
                                var="row"
                                items="${propertyTypeAnalytics}">

                                <tr>

                                    <td class="fw-semibold">
                                        ${row.name}
                                    </td>

                                    <td>
                                        ${row.count}
                                    </td>

                                    <td>
                                        ${row.averagePriceFormatted}
                                    </td>

                                </tr>

                            </c:forEach>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>


        <!-- ================================================= -->
        <!-- CITY TABLE -->
        <!-- ================================================= -->

        <div class="card analytics-card shadow-sm mb-4">

            <div class="card-body p-4">

                <h5 class="fw-bold mb-1">
                    City Analytics
                </h5>

                <p class="text-muted small">
                    Property count and average price by city.
                </p>


                <div class="table-responsive">

                    <table class="table table-hover
                                  align-middle
                                  analytics-table">

                        <thead class="table-light">

                            <tr>

                                <th>
                                    City
                                </th>

                                <th>
                                    Properties
                                </th>

                                <th>
                                    Average Price
                                </th>

                            </tr>

                        </thead>


                        <tbody>

                            <c:forEach
                                var="row"
                                items="${cityAnalytics}">

                                <tr>

                                    <td class="fw-semibold">
                                        ${row.name}
                                    </td>

                                    <td>
                                        ${row.count}
                                    </td>

                                    <td>
                                        ${row.averagePriceFormatted}
                                    </td>

                                </tr>

                            </c:forEach>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>


        <!-- ================================================= -->
        <!-- DISTRICT TABLE -->
        <!-- ================================================= -->

        <div class="card analytics-card shadow-sm mb-4">

            <div class="card-body p-4">

                <h5 class="fw-bold mb-1">
                    District Analytics
                </h5>

                <p class="text-muted small">
                    Property count and average price by district.
                </p>


                <div class="table-responsive">

                    <table class="table table-hover
                                  align-middle
                                  analytics-table">

                        <thead class="table-light">

                            <tr>

                                <th>
                                    District
                                </th>

                                <th>
                                    Properties
                                </th>

                                <th>
                                    Average Price
                                </th>

                            </tr>

                        </thead>


                        <tbody>

                            <c:forEach
                                var="row"
                                items="${districtAnalytics}">

                                <tr>

                                    <td class="fw-semibold">
                                        ${row.name}
                                    </td>

                                    <td>
                                        ${row.count}
                                    </td>

                                    <td>
                                        ${row.averagePriceFormatted}
                                    </td>

                                </tr>

                            </c:forEach>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>


        <!-- ================================================= -->
        <!-- STATE TABLE -->
        <!-- ================================================= -->

        <div class="card analytics-card shadow-sm mb-5">

            <div class="card-body p-4">

                <h5 class="fw-bold mb-1">
                    State Analytics
                </h5>

                <p class="text-muted small">
                    Property count and average price by state.
                </p>


                <div class="table-responsive">

                    <table class="table table-hover
                                  align-middle
                                  analytics-table">

                        <thead class="table-light">

                            <tr>

                                <th>
                                    State
                                </th>

                                <th>
                                    Properties
                                </th>

                                <th>
                                    Average Price
                                </th>

                            </tr>

                        </thead>


                        <tbody>

                            <c:forEach
                                var="row"
                                items="${stateAnalytics}">

                                <tr>

                                    <td class="fw-semibold">
                                        ${row.name}
                                    </td>

                                    <td>
                                        ${row.count}
                                    </td>

                                    <td>
                                        ${row.averagePriceFormatted}
                                    </td>

                                </tr>

                            </c:forEach>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>


        <!-- ACTIONS -->

        <div class="d-flex
                    justify-content-center
                    flex-wrap
                    gap-2">

            <a
                href="${pageContext.request.contextPath}/admin/dashboard"
                class="btn btn-outline-secondary">

                ← Admin Dashboard

            </a>


            <a
                href="${pageContext.request.contextPath}/properties"
                class="btn btn-primary">

                View Properties

            </a>

        </div>

    </div>

</main>


<jsp:include page="../common/footer.jsp" />


<script>

    /*
     * ---------------------------------------------------------
     * PROPERTY TYPE DISTRIBUTION
     * ---------------------------------------------------------
     */

    const propertyTypeLabels = [
        <c:forEach
            var="row"
            items="${propertyTypeAnalytics}"
            varStatus="status">

            '${row.name}'
            <c:if test="${!status.last}">,</c:if>

        </c:forEach>
    ];


    const propertyTypeCounts = [
        <c:forEach
            var="row"
            items="${propertyTypeAnalytics}"
            varStatus="status">

            ${row.count}
            <c:if test="${!status.last}">,</c:if>

        </c:forEach>
    ];


    new Chart(
        document.getElementById('propertyTypeChart'),
        {
            type: 'doughnut',

            data: {
                labels: propertyTypeLabels,

                datasets: [
                    {
                        label: 'Properties',
                        data: propertyTypeCounts
                    }
                ]
            },

            options: {
                responsive: true,
                maintainAspectRatio: false,

                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        }
    );


    /*
     * ---------------------------------------------------------
     * CITY DISTRIBUTION
     * ---------------------------------------------------------
     */

    const cityLabels = [
        <c:forEach
            var="row"
            items="${cityAnalytics}"
            varStatus="status">

            '${row.name}'
            <c:if test="${!status.last}">,</c:if>

        </c:forEach>
    ];


    const cityCounts = [
        <c:forEach
            var="row"
            items="${cityAnalytics}"
            varStatus="status">

            ${row.count}
            <c:if test="${!status.last}">,</c:if>

        </c:forEach>
    ];


    new Chart(
        document.getElementById('cityChart'),
        {
            type: 'bar',

            data: {
                labels: cityLabels,

                datasets: [
                    {
                        label: 'Properties',
                        data: cityCounts
                    }
                ]
            },

            options: {
                responsive: true,
                maintainAspectRatio: false,

                scales: {
                    y: {
                        beginAtZero: true,

                        ticks: {
                            precision: 0
                        }
                    }
                }
            }
        }
    );


    /*
     * ---------------------------------------------------------
     * AVERAGE PRICE BY PROPERTY TYPE
     * ---------------------------------------------------------
     */

    const propertyTypePriceLabels = [
        <c:forEach
            var="row"
            items="${propertyTypeAnalytics}"
            varStatus="status">

            '${row.name}'
            <c:if test="${!status.last}">,</c:if>

        </c:forEach>
    ];


    const propertyTypePrices = [
        <c:forEach
            var="row"
            items="${propertyTypeAnalytics}"
            varStatus="status">

            ${row.averagePrice}
            <c:if test="${!status.last}">,</c:if>

        </c:forEach>
    ];


    new Chart(
        document.getElementById('propertyTypePriceChart'),
        {
            type: 'bar',

            data: {
                labels: propertyTypePriceLabels,

                datasets: [
                    {
                        label: 'Average Price',
                        data: propertyTypePrices
                    }
                ]
            },

            options: {
                responsive: true,
                maintainAspectRatio: false,

                scales: {

                    y: {

                        beginAtZero: true,

                        ticks: {

                            callback: function(value) {

                                if (value >= 10000000) {
                                    return '₹'
                                        + (value / 10000000)
                                            .toFixed(1)
                                        + ' Cr';
                                }

                                if (value >= 100000) {
                                    return '₹'
                                        + (value / 100000)
                                            .toFixed(1)
                                        + ' L';
                                }

                                return '₹'
                                    + value.toLocaleString('en-IN');

                            }

                        }

                    }

                },

                plugins: {

                    tooltip: {

                        callbacks: {

                            label: function(context) {

                                const value = context.raw;

                                if (value >= 10000000) {
                                    return 'Average: ₹'
                                        + (value / 10000000)
                                            .toFixed(2)
                                        + ' Crore';
                                }

                                if (value >= 100000) {
                                    return 'Average: ₹'
                                        + (value / 100000)
                                            .toFixed(2)
                                        + ' Lakh';
                                }

                                return 'Average: ₹'
                                    + value.toLocaleString('en-IN');

                            }

                        }

                    }

                }

            }

        }
    );


    /*
     * ---------------------------------------------------------
     * AVERAGE PRICE BY CITY
     * ---------------------------------------------------------
     */

    const cityPriceLabels = [
        <c:forEach
            var="row"
            items="${cityAnalytics}"
            varStatus="status">

            '${row.name}'
            <c:if test="${!status.last}">,</c:if>

        </c:forEach>
    ];


    const cityPrices = [
        <c:forEach
            var="row"
            items="${cityAnalytics}"
            varStatus="status">

            ${row.averagePrice}
            <c:if test="${!status.last}">,</c:if>

        </c:forEach>
    ];


    new Chart(
        document.getElementById('cityPriceChart'),
        {
            type: 'bar',

            data: {
                labels: cityPriceLabels,

                datasets: [
                    {
                        label: 'Average Price',
                        data: cityPrices
                    }
                ]
            },

            options: {
                responsive: true,
                maintainAspectRatio: false,

                scales: {

                    y: {

                        beginAtZero: true,

                        ticks: {

                            callback: function(value) {

                                if (value >= 10000000) {
                                    return '₹'
                                        + (value / 10000000)
                                            .toFixed(1)
                                        + ' Cr';
                                }

                                if (value >= 100000) {
                                    return '₹'
                                        + (value / 100000)
                                            .toFixed(1)
                                        + ' L';
                                }

                                return '₹'
                                    + value.toLocaleString('en-IN');

                            }

                        }

                    }

                },

                plugins: {

                    tooltip: {

                        callbacks: {

                            label: function(context) {

                                const value = context.raw;

                                if (value >= 10000000) {
                                    return 'Average: ₹'
                                        + (value / 10000000)
                                            .toFixed(2)
                                        + ' Crore';
                                }

                                if (value >= 100000) {
                                    return 'Average: ₹'
                                        + (value / 100000)
                                            .toFixed(2)
                                        + ' Lakh';
                                }

                                return 'Average: ₹'
                                    + value.toLocaleString('en-IN');

                            }

                        }

                    }

                }

            }

        }
    );

</script>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>