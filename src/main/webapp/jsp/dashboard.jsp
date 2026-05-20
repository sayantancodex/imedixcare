<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | iMediXCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .card-stat {
            border: none;
            border-radius: 15px;
            transition: transform 0.3s;
        }
        .card-stat:hover {
            transform: translateY(-5px);
        }
        .icon-box {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
    </style>
</head>
<body class="bg-light">

<%@ include file="header.jsp" %>

<div class="container-fluid">
    <div class="row">
        <%@ include file="sidebar.jsp" %>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2 fw-bold">Hospital Overview</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group me-2">
                        <button type="button" class="btn btn-sm btn-outline-secondary">Share</button>
                        <button type="button" class="btn btn-sm btn-outline-secondary">Export</button>
                    </div>
                    <button type="button" class="btn btn-sm btn-primary dropdown-toggle">
                        <i class="bi bi-calendar-event me-1"></i> This week
                    </button>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="row g-4 mb-4">
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card card-stat shadow-sm">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="icon-box bg-primary-subtle text-primary me-3">
                                    <i class="bi bi-people-fill"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-1">Total Patients</h6>
                                    <h3 class="mb-0 fw-bold">1,284</h3>
                                </div>
                            </div>
                            <div class="mt-3 small text-success">
                                <i class="bi bi-arrow-up"></i> 12.5% <span class="text-muted">Since last month</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card card-stat shadow-sm">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="icon-box bg-warning-subtle text-warning me-3">
                                    <i class="bi bi-hourglass-split"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-1">Pending Tests</h6>
                                    <h3 class="mb-0 fw-bold">42</h3>
                                </div>
                            </div>
                            <div class="mt-3 small text-danger">
                                <i class="bi bi-arrow-up"></i> 5.2% <span class="text-muted">High priority</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card card-stat shadow-sm">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="icon-box bg-success-subtle text-success me-3">
                                    <i class="bi bi-check2-circle"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-1">Reports Ready</h6>
                                    <h3 class="mb-0 fw-bold">112</h3>
                                </div>
                            </div>
                            <div class="mt-3 small text-success">
                                <i class="bi bi-check"></i> 98% <span class="text-muted">Accuracy rate</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="card card-stat shadow-sm">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="icon-box bg-info-subtle text-info me-3">
                                    <i class="bi bi-cash-stack"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-1">Total Revenue</h6>
                                    <h3 class="mb-0 fw-bold">$12.4K</h3>
                                </div>
                            </div>
                            <div class="mt-3 small text-success">
                                <i class="bi bi-arrow-up"></i> 8.4% <span class="text-muted">Weekly growth</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Patients Table -->
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <div class="card-header bg-white py-3 border-0">
                    <div class="row align-items-center">
                        <div class="col">
                            <h5 class="mb-0 fw-bold">Pending Diagnostic Tests</h5>
                        </div>
                        <div class="col-auto">
                            <button class="btn btn-primary btn-sm rounded-pill px-3">View All</button>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light">
                            <tr>
                                <th class="ps-4">Patient Name</th>
                                <th>Patient ID</th>
                                <th>Test Type</th>
                                <th>Assigned Doctor</th>
                                <th>Status</th>
                                <th class="text-end pe-4">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="ps-4">
                                    <div class="d-flex align-items-center">
                                        <img src="https://ui-avatars.com/api/?name=Robert+Brown&background=random" class="rounded-circle me-2" width="35" height="35">
                                        <div class="fw-semibold">Robert Brown</div>
                                    </div>
                                </td>
                                <td>P-1001</td>
                                <td>Blood Pathology</td>
                                <td>Dr. John Smith</td>
                                <td><span class="badge bg-warning-subtle text-warning border border-warning px-3 rounded-pill">Pending</span></td>
                                <td class="text-end pe-4">
                                    <button class="btn btn-sm btn-outline-primary rounded-pill"><i class="bi bi-whatsapp"></i> Notify</button>
                                    <button class="btn btn-sm btn-light rounded-circle ms-1"><i class="bi bi-three-dots-vertical"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td class="ps-4">
                                    <div class="d-flex align-items-center">
                                        <img src="https://ui-avatars.com/api/?name=Emily+Davis&background=random" class="rounded-circle me-2" width="35" height="35">
                                        <div class="fw-semibold">Emily Davis</div>
                                    </div>
                                </td>
                                <td>P-1002</td>
                                <td>Psych Assessment</td>
                                <td>Dr. Sarah Wilson</td>
                                <td><span class="badge bg-info-subtle text-info border border-info px-3 rounded-pill">In Progress</span></td>
                                <td class="text-end pe-4">
                                    <button class="btn btn-sm btn-outline-primary rounded-pill"><i class="bi bi-whatsapp"></i> Notify</button>
                                    <button class="btn btn-sm btn-light rounded-circle ms-1"><i class="bi bi-three-dots-vertical"></i></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
