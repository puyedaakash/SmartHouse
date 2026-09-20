<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        ${empty house.id ? 'Add Property' : 'Edit Property'} - SmartHouse
    </title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/smarthouse.css">
        
        <style>
        	/* ================= OWNER DETAILS ================= */

.owner-section {
    margin-top: 28px;
    padding: 26px;
    background: linear-gradient(135deg, #f8fbff, #eef5ff);
    border: 1px solid #dbeafe;
    border-radius: 18px;
    box-shadow: 0 8px 24px rgba(37, 99, 235, 0.08);
}

.section-heading {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 22px;
}

.section-heading .icon {
    width: 44px;
    height: 44px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
    background: #2563eb;
    color: white;
    font-size: 21px;
}

.section-heading h3 {
    margin: 0;
    color: #1e293b;
    font-size: 21px;
    font-weight: 700;
}

.section-heading p {
    margin: 4px 0 0;
    color: #64748b;
    font-size: 13px;
}

.owner-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 20px;
}

.owner-field {
    display: flex;
    flex-direction: column;
}

.owner-field.full-width {
    grid-column: 1 / -1;
}

.owner-field label {
    margin-bottom: 8px;
    color: #334155;
    font-size: 14px;
    font-weight: 600;
}

.owner-field label span {
    color: #ef4444;
}

.owner-input-wrapper {
    position: relative;
}

.owner-input-wrapper i {
    position: absolute;
    top: 50%;
    left: 15px;
    transform: translateY(-50%);
    color: #64748b;
    font-size: 16px;
    pointer-events: none;
}

.owner-input {
    width: 100%;
    box-sizing: border-box;
    padding: 13px 15px 13px 44px;
    border: 1px solid #cbd5e1;
    border-radius: 10px;
    background: #ffffff;
    color: #1e293b;
    font-size: 14px;
    outline: none;
    transition: all 0.25s ease;
}

.owner-input::placeholder {
    color: #94a3b8;
}

.owner-input:focus {
    border-color: #2563eb;
    box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.12);
}

.owner-input:valid {
    border-color: #cbd5e1;
}

.owner-note {
    display: flex;
    align-items: center;
    gap: 7px;
    margin-top: 18px;
    padding: 12px 14px;
    background: #ffffff;
    border-left: 4px solid #2563eb;
    border-radius: 8px;
    color: #64748b;
    font-size: 12px;
}

/* Responsive design */
@media (max-width: 768px) {
    .owner-section {
        padding: 20px;
    }

    .owner-grid {
        grid-template-columns: 1fr;
        gap: 16px;
    }

    .owner-field.full-width {
        grid-column: auto;
    }

    .section-heading h3 {
        font-size: 18px;
    }
}

@media (max-width: 480px) {
    .owner-section {
        padding: 16px;
        border-radius: 12px;
    }

    .section-heading .icon {
        width: 38px;
        height: 38px;
        font-size: 18px;
    }

    .owner-input {
        padding: 12px 12px 12px 40px;
    }
}
        </style>

</head>

<body>

<jsp:include page="../common/navbar.jsp" />

<main>

    <div class="container py-5">

        <div class="row justify-content-center">

            <div class="col-xl-10">

                <div class="text-center mb-5">

                    <span class="badge bg-primary mb-3">
                        PROPERTY MANAGEMENT
                    </span>

                    <h1 class="fw-bold">
                        ${empty house.id ? 'Add Property' : 'Edit Property'}
                    </h1>

                    <p class="text-muted">
                        ${empty house.id
                            ? 'Add a property to the SmartHouse marketplace.'
                            : 'Update the selected property information.'}
                    </p>

                </div>

                <div class="card border-0 shadow-sm">

                    <div class="card-body p-4 p-md-5">

                        <form
                            method="post"
                            action="${pageContext.request.contextPath}/admin/houses/save"
                            enctype="multipart/form-data">

                            <sec:csrfInput />

                            <input
                                type="hidden"
                                name="id"
                                value="${house.id}">

                            <!-- BASIC INFORMATION -->

                            <div class="mb-4">

                                <h5 class="fw-bold mb-3">
                                    Basic Information
                                </h5>

                                <div class="border-bottom"></div>

                            </div>

                            <div class="row g-4">

                                <!-- TITLE -->

                                <div class="col-12">

                                    <label
                                        for="title"
                                        class="form-label fw-semibold">

                                        Property Title

                                    </label>

                                    <input
                                        type="text"
                                        id="title"
                                        name="title"
                                        class="form-control"
                                        value="${house.title}"
                                        placeholder="Example: Premium 3 BHK Apartment in Wakad"
                                        maxlength="150"
                                        required>

                                </div>

                                <!-- PRICE -->

                                <div class="col-md-6">

                                    <label
                                        for="price"
                                        class="form-label fw-semibold">

                                        Price (₹)

                                    </label>

                                    <input
                                        type="number"
                                        id="price"
                                        name="price"
                                        class="form-control"
                                        value="${house.price}"
                                        placeholder="Example: 8500000"
                                        min="0"
                                        step="0.01"
                                        required>

                                </div>

                                <!-- AREA -->

                                <div class="col-md-6">

                                    <label
                                        for="area"
                                        class="form-label fw-semibold">

                                        Area (sq.ft.)

                                    </label>

                                    <input
                                        type="number"
                                        id="area"
                                        name="area"
                                        class="form-control"
                                        value="${house.area}"
                                        placeholder="Example: 1200"
                                        min="1"
                                        step="0.01"
                                        required>

                                </div>

                                <!-- BEDROOMS -->

                                <div class="col-md-4">

                                    <label
                                        for="bedrooms"
                                        class="form-label fw-semibold">

                                        Bedrooms

                                    </label>

                                    <input
                                        type="number"
                                        id="bedrooms"
                                        name="bedrooms"
                                        class="form-control"
                                        value="${house.bedrooms}"
                                        min="0"
                                        max="20"
                                        required>

                                </div>

                                <!-- BATHROOMS -->

                                <div class="col-md-4">

                                    <label
                                        for="bathrooms"
                                        class="form-label fw-semibold">

                                        Bathrooms

                                    </label>

                                    <input
                                        type="number"
                                        id="bathrooms"
                                        name="bathrooms"
                                        class="form-control"
                                        value="${house.bathrooms}"
                                        min="0"
                                        max="20"
                                        required>

                                </div>

                                <!-- FLOORS -->

                                <div class="col-md-4">

                                    <label
                                        for="floors"
                                        class="form-label fw-semibold">

                                        Floor

                                    </label>

                                    <input
                                        type="number"
                                        id="floors"
                                        name="floors"
                                        class="form-control"
                                        value="${house.floors}"
                                        min="1"
                                        max="100"
                                        required>

                                </div>

                                <!-- FURNISHING -->

                                <div class="col-md-6">

                                    <label
                                        for="furnishing"
                                        class="form-label fw-semibold">

                                        Furnishing

                                    </label>

                                    <select
                                        id="furnishing"
                                        name="furnishing"
                                        class="form-select"
                                        required>

                                        <option value="">
                                            Select furnishing
                                        </option>

                                        <option
                                            value="Unfurnished"
                                            ${house.furnishing == 'Unfurnished'
                                                ? 'selected' : ''}>

                                            Unfurnished

                                        </option>

                                        <option
                                            value="Semi-Furnished"
                                            ${house.furnishing == 'Semi-Furnished'
                                                ? 'selected' : ''}>

                                            Semi-Furnished

                                        </option>

                                        <option
                                            value="Fully Furnished"
                                            ${house.furnishing == 'Fully Furnished'
                                                ? 'selected' : ''}>

                                            Fully Furnished

                                        </option>

                                    </select>

                                </div>

                                <!-- PROPERTY TYPE -->

                                <div class="col-md-6">

                                    <label
                                        for="propertyTypeId"
                                        class="form-label fw-semibold">

                                        Property Type

                                    </label>

                                    <select
                                        id="propertyTypeId"
                                        name="propertyTypeId"
                                        class="form-select"
                                        required>

                                        <option value="">
                                            Select property type
                                        </option>

                                        <c:forEach
                                            var="propertyType"
                                            items="${propertyTypes}">

                                            <option
                                                value="${propertyType.id}"
                                                ${house.propertyType != null &&
                                                  house.propertyType.id == propertyType.id
                                                    ? 'selected' : ''}>

                                                ${propertyType.name}

                                            </option>

                                        </c:forEach>

                                    </select>

                                </div>

                            </div>

                            <!-- LOCATION -->

                            <div class="mt-5 mb-4">

                                <h5 class="fw-bold mb-3">
                                    Property Location
                                </h5>

                                <div class="border-bottom"></div>

                            </div>

                            <div class="row g-4">

                                <div class="col-12">

                                    <label
                                        for="locationId"
                                        class="form-label fw-semibold">

                                        Location

                                    </label>

                                    <select
                                        id="locationId"
                                        name="locationId"
                                        class="form-select"
                                        required>

                                        <option value="">
                                            Select location
                                        </option>

                                        <c:forEach
                                            var="location"
                                            items="${locations}">

                                            <option
                                                value="${location.id}"
                                                ${house.location != null &&
                                                  house.location.id == location.id
                                                    ? 'selected' : ''}>

                                                ${location.name}

                                            </option>

                                        </c:forEach>

                                    </select>

                                    <div class="form-text">
                                        Select the locality where the property is located.
                                    </div>

                                </div>

                            </div>

                            <!-- PROPERTY IMAGE -->

                            <div class="mt-5 mb-4">

                                <h5 class="fw-bold mb-3">
                                    Property Photo
                                </h5>

                                <div class="border-bottom"></div>

                            </div>

                            <div class="mb-4">

                                <label
                                    for="imageFile"
                                    class="form-label fw-semibold">

                                    Upload Home Photo

                                </label>

                                <input
                                    type="file"
                                    id="imageFile"
                                    name="imageFile"
                                    class="form-control"
                                    accept="image/jpeg,image/png,image/webp">

                                <div class="form-text">
                                    Accepted formats: JPG, JPEG, PNG and WEBP.
                                    Maximum size: 5 MB.
                                </div>

                                <c:if test="${not empty house.imagePath}">

                                    <div class="mt-3">

                                        <p class="small text-muted mb-2">
                                            Current property photo:
                                        </p>

                                        <img
                                            src="${pageContext.request.contextPath}/uploads/properties/${house.imagePath}"
                                            alt="Current property photo"
                                            style="width:220px;
                                                   height:150px;
                                                   object-fit:cover;
                                                   border-radius:10px;
                                                   border:1px solid #ddd;">

                                        <p class="small text-muted mt-2">
                                            Select a new image only if you want
                                            to replace the current photo.
                                        </p>

                                    </div>

                                </c:if>

                            </div>

                            <!-- DESCRIPTION -->

                            <div class="mt-5 mb-4">

                                <h5 class="fw-bold mb-3">
                                    Description
                                </h5>

                                <div class="border-bottom"></div>

                            </div>

                            <div class="mb-4">

                                <label
                                    for="description"
                                    class="form-label fw-semibold">

                                    Property Description

                                </label>

                                <textarea
                                    id="description"
                                    name="description"
                                    class="form-control"
                                    rows="6"
                                    maxlength="2000"
                                    placeholder="Describe the property, surroundings and features.">${house.description}</textarea>

                            </div>

                            <!-- AMENITIES -->

                            <div class="mt-5 mb-4">

                                <h5 class="fw-bold mb-3">
                                    Amenities
                                </h5>

                                <div class="border-bottom"></div>

                            </div>

                            <div class="mb-4">

                                <label class="form-label fw-semibold">
                                    Available Amenities
                                </label>

                                <div class="row g-3">

                                    <c:forEach
                                        var="amenity"
                                        items="${amenities}">

                                        <c:set
                                            var="isSelected"
                                            value="false" />

                                        <c:forEach
                                            var="selectedAmenity"
                                            items="${house.amenities}">

                                            <c:if
                                                test="${selectedAmenity.id == amenity.id}">

                                                <c:set
                                                    var="isSelected"
                                                    value="true" />

                                            </c:if>

                                        </c:forEach>

                                        <div class="col-md-4 col-sm-6">

                                            <div class="form-check border rounded p-3">

                                                <input
                                                    type="checkbox"
                                                    name="amenityIds"
                                                    value="${amenity.id}"
                                                    id="amenity-${amenity.id}"
                                                    class="form-check-input"
                                                    ${isSelected ? 'checked' : ''}>

                                                <label
                                                    for="amenity-${amenity.id}"
                                                    class="form-check-label">

                                                    ${amenity.name}

                                                </label>

                                            </div>

                                        </div>

                                    </c:forEach>

                                </div>

                                <c:if test="${empty amenities}">

                                    <div class="alert alert-warning mt-3">
                                        No amenities are available.
                                        Add amenities from the master-data section first.
                                    </div>

                                </c:if>

                            </div>

                            <!-- INFORMATION -->

                            <div class="alert alert-light border mt-5">

                                <h6 class="fw-bold mb-2">
                                    Property Information
                                </h6>

                                <p class="text-muted small mb-0">

                                    Ensure that the property information,
                                    location, property type, amenities and
                                    uploaded photo are correct.

                                </p>

                            </div>

    <!-- ================= PROPERTY OWNER DETAILS ================= -->

<div class="owner-section">

    <div class="section-heading">
        <div class="icon">
            <i class="fas fa-user-tie"></i>
        </div>

        <div>
            <h3>Property Owner Details</h3>
            <p>Provide the contact information of the property owner</p>
        </div>
    </div>

    <div class="owner-grid">

        <!-- Owner Name -->
        <div class="owner-field">
            <label for="ownerName">
                Owner Full Name <span>*</span>
            </label>

            <div class="owner-input-wrapper">
                <i class="fas fa-user"></i>

                <input
                    type="text"
                    id="ownerName"
                    name="owner.name"
                    class="owner-input"
                    value="${house.owner.name}"
                    placeholder="Enter owner's full name"
                    maxlength="100"
                    required>
            </div>
        </div>

        <!-- Owner Contact -->
        <div class="owner-field">
            <label for="ownerContactNumber">
                Contact Number <span>*</span>
            </label>

            <div class="owner-input-wrapper">
                <i class="fas fa-phone"></i>

                <input
                    type="tel"
                    id="ownerContactNumber"
                    name="owner.contactNumber"
                    class="owner-input"
                    value="${house.owner.contactNumber}"
                    placeholder="Enter 10-digit mobile number"
                    pattern="[6-9][0-9]{9}"
                    maxlength="10"
                    required>
            </div>
        </div>

        <!-- Owner Email -->
        <div class="owner-field full-width">
            <label for="ownerEmail">
                Email Address <small>(Optional)</small>
            </label>

            <div class="owner-input-wrapper">
                <i class="fas fa-envelope"></i>

                <input
                    type="email"
                    id="ownerEmail"
                    name="owner.email"
                    class="owner-input"
                    value="${house.owner.email}"
                    placeholder="Enter owner's email address"
                    maxlength="100">
            </div>
        </div>

    </div>

    <div class="owner-note">
        <i class="fas fa-shield-alt"></i>
        Owner contact details will be used only for property-related communication.
    </div>

</div>
</div>

                            <!-- ACTIONS -->

                            <div class="d-flex
                                        justify-content-between
                                        align-items-center
                                        flex-wrap
                                        gap-2
                                        mt-4">

                                <a
                                    href="${pageContext.request.contextPath}/admin/houses"
                                    class="btn btn-outline-secondary">

                                    ← Cancel

                                </a>

                                <button
                                    type="submit"
                                    class="btn btn-primary btn-lg px-5">

                                    ${empty house.id
                                        ? 'Add Property'
                                        : 'Update Property'}

                                </button>

                            </div>

                        </form>

                    </div>

                </div>

                <div class="text-center mt-4">

                    <small class="text-muted">
                        Only administrators can create or modify property records.
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