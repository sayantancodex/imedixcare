<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.imedixcare.model.Patient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Patients | iMediXCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<%@ include file="header.jsp" %>

<div class="container-fluid">
    <div class="row">
        <%@ include file="sidebar.jsp" %>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">Patient Management</h2>
                <button class="btn btn-primary rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#addPatientModal">
                    <i class="bi bi-plus-lg me-2"></i> Register Patient
                </button>
            </div>

            <!-- Filters -->
            <div class="card border-0 shadow-sm rounded-4 mb-4">
                <div class="card-body">
                    <form class="row g-3">
                        <div class="col-md-4">
                            <input type="text" class="form-control" placeholder="Search by name or ID...">
                        </div>
                        <div class="col-md-3">
                            <select class="form-select">
                                <option value="">Status: All</option>
                                <option>Pending</option>
                                <option>In Progress</option>
                                <option>Completed</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select class="form-select">
                                <option value="">Department: All</option>
                                <option>Pathology</option>
                                <option>Psychology</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button type="button" class="btn btn-outline-primary w-100">Filter</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Patient Table -->
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light">
                            <tr>
                                <th class="ps-4">Patient Details</th>
                                <th>Phone</th>
                                <th>Investigation</th>
                                <th>Status</th>
                                <th class="text-end pe-4">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                List<Patient> patients = (List<Patient>) request.getAttribute("patients");
                                if (patients != null) {
                                    for (Patient p : patients) {
                            %>
                            <tr>
                                <td class="ps-4">
                                    <div class="d-flex align-items-center">
                                        <img src="https://ui-avatars.com/api/?name=<%= p.getFullName() %>&background=random" class="rounded-circle me-2" width="40" height="40">
                                        <div>
                                            <div class="fw-bold"><%= p.getFullName() %></div>
                                            <div class="small text-muted"><%= p.getPatientIdStr() %> | <%= p.getGender() %></div>
                                        </div>
                                    </div>
                                </td>
                                <td><%= p.getPhone() %></td>
                                <td><%= p.getInvestigationType() %></td>
                                <td>
                                    <% if ("PENDING".equals(p.getTestStatus())) { %>
                                        <span class="badge bg-warning-subtle text-warning border border-warning px-3 rounded-pill">Pending</span>
                                    <% } else if ("IN_PROGRESS".equals(p.getTestStatus())) { %>
                                        <span class="badge bg-info-subtle text-info border border-info px-3 rounded-pill">In Progress</span>
                                    <% } else { %>
                                        <span class="badge bg-success-subtle text-success border border-success px-3 rounded-pill">Completed</span>
                                    <% } %>
                                </td>
                                <td class="text-end pe-4">
                                    <button class="btn btn-sm btn-outline-primary rounded-pill whatsapp-btn" data-id="<%= p.getId() %>">
                                        <i class="bi bi-whatsapp"></i> Notify
                                    </button>
                                    <div class="dropdown d-inline-block ms-1">
                                        <button class="btn btn-sm btn-light rounded-circle" data-bs-toggle="dropdown">
                                            <i class="bi bi-three-dots-vertical"></i>
                                        </button>
                                        <ul class="dropdown-menu shadow">
                                            <li><a class="dropdown-item" href="#"><i class="bi bi-eye me-2"></i> View Profile</a></li>
                                            <li><a class="dropdown-item" href="#"><i class="bi bi-pencil me-2"></i> Edit</a></li>
                                            <li><a class="dropdown-item" href="chat?patientId=<%= p.getId() %>"><i class="bi bi-chat-dots me-2"></i> Chat</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item text-danger" href="#"><i class="bi bi-trash me-2"></i> Delete</a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                            <% 
                                    }
                                } 
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Toast for Notifications -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <div id="whatsappToast" class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                <i class="bi bi-check-circle me-2"></i> WhatsApp notification sent successfully!
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.querySelectorAll('.whatsapp-btn').forEach(btn => {
        btn.onclick = function() {
            const id = this.getAttribute('data-id');
            const originalHtml = this.innerHTML;
            this.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span> Sending...';
            this.disabled = true;

            fetch('send-whatsapp', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `patientId=${id}`
            })
            .then(res => res.json())
            .then(data => {
                if (data.status === 'SUCCESS') {
                    const toast = new bootstrap.Toast(document.getElementById('whatsappToast'));
                    toast.show();
                } else {
                    alert('Error sending WhatsApp: ' + data.status);
                }
            })
            .catch(err => alert('Error: ' + err))
            .finally(() => {
                this.innerHTML = originalHtml;
                this.disabled = false;
            });
        };
    });
</script>
</body>
</html>
