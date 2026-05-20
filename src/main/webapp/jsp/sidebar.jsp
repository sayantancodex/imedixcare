<nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-white sidebar collapse border-end shadow-sm">
    <div class="position-sticky pt-3 sidebar-sticky">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link active py-3" aria-current="page" href="dashboard">
                    <i class="bi bi-speedometer2 me-2 fs-5"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link py-3" href="patients">
                    <i class="bi bi-people me-2 fs-5"></i>
                    Patients
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link py-3" href="tests">
                    <i class="bi bi-microscope me-2 fs-5"></i>
                    Diagnostic Tests
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link py-3" href="chat">
                    <i class="bi bi-chat-dots me-2 fs-5"></i>
                    Chat Module
                    <span class="badge rounded-pill bg-danger float-end mt-1">5</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link py-3" href="video">
                    <i class="bi bi-camera-video me-2 fs-5"></i>
                    Video Conference
                </a>
            </li>
        </ul>

        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted text-uppercase small">
            <span>Admin Tools</span>
        </h6>
        <ul class="nav flex-column mb-2">
            <li class="nav-item">
                <a class="nav-link py-3" href="invite">
                    <i class="bi bi-person-plus me-2 fs-5"></i>
                    Invite Doctors
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link py-3" href="reports">
                    <i class="bi bi-file-earmark-pdf me-2 fs-5"></i>
                    System Reports
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link py-3" href="settings">
                    <i class="bi bi-gear-wide-connected me-2 fs-5"></i>
                    Settings
                </a>
            </li>
            <li class="nav-item mt-5">
                <a class="nav-link py-3 text-danger" href="logout">
                    <i class="bi bi-box-arrow-left me-2 fs-5"></i>
                    Logout
                </a>
            </li>
        </ul>
    </div>
</nav>

<style>
    .sidebar .nav-link {
        font-weight: 500;
        color: #333;
        transition: all 0.2s;
        border-radius: 0 50px 50px 0;
        margin-right: 15px;
    }
    .sidebar .nav-link:hover {
        color: #0d6efd;
        background-color: rgba(13, 110, 253, 0.05);
    }
    .sidebar .nav-link.active {
        color: #fff;
        background-color: #0d6efd;
        box-shadow: 0 4px 10px rgba(13, 110, 253, 0.3);
    }
    .sidebar-sticky {
        height: calc(100vh - 48px);
        overflow-x: hidden;
        overflow-y: auto;
    }
</style>
