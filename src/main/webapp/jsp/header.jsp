<%@ page import="com.imedixcare.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>
<header class="navbar navbar-dark sticky-top bg-primary flex-md-nowrap p-0 shadow">
    <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3 fs-6" href="#">
        <i class="bi bi-hospital-fill me-2"></i> iMediXCare
    </a>
    <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="w-100 d-none d-md-block px-3">
        <input class="form-control form-control-dark w-100 rounded-pill bg-light text-dark border-0" type="text" placeholder="Search Patients, Tests, Reports..." aria-label="Search">
    </div>
    <div class="navbar-nav flex-row">
        <div class="nav-item text-nowrap px-3 d-flex align-items-center">
            <div class="dropdown">
                <a href="#" class="d-block link-light text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                    <img src="https://ui-avatars.com/api/?name=<%= user.getFullName() %>&background=0D6EFD&color=fff" alt="mdo" width="32" height="32" class="rounded-circle border border-2 border-white">
                    <span class="ms-2 d-none d-sm-inline text-white small"><%= user.getFullName() %></span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end shadow">
                    <li><h6 class="dropdown-header"><%= user.getRole() %></h6></li>
                    <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i> Profile</a></li>
                    <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i> Settings</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="logout"><i class="bi bi-box-arrow-right me-2"></i> Sign out</a></li>
                </ul>
            </div>
            <div class="position-relative ms-3">
                <i class="bi bi-bell fs-5 text-white cursor-pointer"></i>
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.6rem;">
                    3+
                </span>
            </div>
        </div>
    </div>
</header>
