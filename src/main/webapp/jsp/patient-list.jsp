<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.imedixcare.model.Patient, com.imedixcare.model.User" %>
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
                                <th>Assigned Doctor</th>
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
                                <td><%= p.getInvestigationType() != null ? p.getInvestigationType() : "N/A" %></td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="https://ui-avatars.com/api/?name=<%= p.getAssignedDoctorName() != null ? p.getAssignedDoctorName() : "U" %>&background=E0E0E0&color=444" class="rounded-circle me-2" width="28" height="28">
                                        <span><%= p.getAssignedDoctorName() != null ? p.getAssignedDoctorName() : "Unassigned" %></span>
                                    </div>
                                </td>
                                <td>
                                    <% if ("PENDING".equals(p.getTestStatus())) { %>
                                        <span class="badge bg-warning-subtle text-warning border border-warning px-3 rounded-pill">Pending</span>
                                    <% } else if ("IN_PROGRESS".equals(p.getTestStatus())) { %>
                                        <span class="badge bg-info-subtle text-info border border-info px-3 rounded-pill">In Progress</span>
                                    <% } else if ("COMPLETED".equals(p.getTestStatus())) { %>
                                        <span class="badge bg-success-subtle text-success border border-success px-3 rounded-pill">Completed</span>
                                    <% } else { %>
                                        <span class="badge bg-danger-subtle text-danger border border-danger px-3 rounded-pill">Cancelled</span>
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
                                            <li><a class="dropdown-item" href="javascript:void(0);" onclick="viewPatient(<%= p.getId() %>)"><i class="bi bi-eye me-2"></i> View Profile</a></li>
                                            <li><a class="dropdown-item" href="javascript:void(0);" onclick="editPatient(<%= p.getId() %>)"><i class="bi bi-pencil me-2"></i> Edit</a></li>
                                            <li><a class="dropdown-item" href="chat?patientId=<%= p.getId() %>"><i class="bi bi-chat-dots me-2"></i> Chat</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item text-danger" href="javascript:void(0);" onclick="deletePatient(<%= p.getId() %>, '<%= p.getFullName().replace("'", "\\'") %>')"><i class="bi bi-trash me-2"></i> Delete</a></li>
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

<!-- Add Patient Modal -->
<%
    List<User> doctors = (List<User>) request.getAttribute("doctors");
%>
<div class="modal fade" id="addPatientModal" tabindex="-1" aria-labelledby="addPatientModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow">
            <div class="modal-header border-0 bg-primary text-white rounded-top-4 p-4">
                <h5 class="modal-title fw-bold" id="addPatientModalLabel">
                    <i class="bi bi-person-plus-fill me-2"></i>Register New Patient
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="patients?action=add" method="POST">
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Full Name *</label>
                            <input type="text" name="fullName" class="form-control rounded-3" placeholder="e.g. John Doe" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Phone Number *</label>
                            <input type="tel" name="phone" class="form-control rounded-3" placeholder="e.g. +919876543210" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Email Address</label>
                            <input type="email" name="email" class="form-control rounded-3" placeholder="e.g. john@example.com">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Gender</label>
                            <select name="gender" class="form-select rounded-3">
                                <option value="MALE">Male</option>
                                <option value="FEMALE">Female</option>
                                <option value="OTHER">Other</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Date of Birth</label>
                            <input type="date" name="dob" class="form-control rounded-3">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Assigned Doctor / Practitioner</label>
                            <select name="assignedDoctorId" class="form-select rounded-3">
                                <option value="">Select Doctor</option>
                                <% if (doctors != null) { %>
                                    <% for (User doc : doctors) { %>
                                        <option value="<%= doc.getId() %>"><%= doc.getFullName() %> (<%= doc.getRole() %>)</option>
                                    <% } %>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Investigation Type</label>
                            <input type="text" name="investigationType" class="form-control rounded-3" placeholder="e.g. Pathology - Blood Test">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Test Status</label>
                            <select name="testStatus" class="form-select rounded-3">
                                <option value="PENDING" selected>Pending</option>
                                <option value="IN_PROGRESS">In Progress</option>
                                <option value="COMPLETED">Completed</option>
                                <option value="CANCELLED">Cancelled</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Residential Address</label>
                            <textarea name="address" class="form-control rounded-3" rows="3" placeholder="Enter complete address..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 p-4 pt-0">
                    <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary rounded-pill px-4">Register Patient</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Patient Modal -->
<div class="modal fade" id="editPatientModal" tabindex="-1" aria-labelledby="editPatientModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow">
            <div class="modal-header border-0 bg-info text-white rounded-top-4 p-4">
                <h5 class="modal-title fw-bold" id="editPatientModalLabel">
                    <i class="bi bi-pencil-square me-2"></i>Edit Patient Profile
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="patients?action=update" method="POST">
                <input type="hidden" name="id" id="editId">
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Full Name *</label>
                            <input type="text" name="fullName" id="editFullName" class="form-control rounded-3" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Phone Number *</label>
                            <input type="tel" name="phone" id="editPhone" class="form-control rounded-3" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Email Address</label>
                            <input type="email" name="email" id="editEmail" class="form-control rounded-3">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Gender</label>
                            <select name="gender" id="editGender" class="form-select rounded-3">
                                <option value="MALE">Male</option>
                                <option value="FEMALE">Female</option>
                                <option value="OTHER">Other</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Date of Birth</label>
                            <input type="date" name="dob" id="editDob" class="form-control rounded-3">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Assigned Doctor / Practitioner</label>
                            <select name="assignedDoctorId" id="editAssignedDoctorId" class="form-select rounded-3">
                                <option value="">Select Doctor</option>
                                <% if (doctors != null) { %>
                                    <% for (User doc : doctors) { %>
                                        <option value="<%= doc.getId() %>"><%= doc.getFullName() %> (<%= doc.getRole() %>)</option>
                                    <% } %>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Investigation Type</label>
                            <input type="text" name="investigationType" id="editInvestigationType" class="form-control rounded-3">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Test Status</label>
                            <select name="testStatus" id="editTestStatus" class="form-select rounded-3">
                                <option value="PENDING">Pending</option>
                                <option value="IN_PROGRESS">In Progress</option>
                                <option value="COMPLETED">Completed</option>
                                <option value="CANCELLED">Cancelled</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Residential Address</label>
                            <textarea name="address" id="editAddress" class="form-control rounded-3" rows="3"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 p-4 pt-0">
                    <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-info text-white rounded-pill px-4">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- View Profile Modal -->
<div class="modal fade" id="viewPatientModal" tabindex="-1" aria-labelledby="viewPatientModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow">
            <div class="modal-header border-0 bg-dark text-white rounded-top-4 p-4">
                <h5 class="modal-title fw-bold" id="viewPatientModalLabel">
                    <i class="bi bi-person-vcard me-2"></i>Patient Profile Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <div class="d-flex align-items-center mb-4">
                    <img id="viewAvatar" src="" class="rounded-circle me-3 border border-2 border-primary" width="64" height="64">
                    <div>
                        <h4 class="fw-bold mb-1" id="viewFullName"></h4>
                        <span class="badge bg-secondary-subtle text-secondary border border-secondary px-3 rounded-pill" id="viewPatientIdStr"></span>
                        <span class="badge bg-light text-dark border border-gray px-3 rounded-pill" id="viewGender"></span>
                    </div>
                </div>
                
                <hr class="text-muted">

                <div class="row g-3">
                    <div class="col-6">
                          <div class="small text-muted">Phone Number</div>
                          <div class="fw-semibold" id="viewPhone"></div>
                    </div>
                    <div class="col-6">
                          <div class="small text-muted">Email Address</div>
                          <div class="fw-semibold" id="viewEmail"></div>
                    </div>
                    <div class="col-6">
                          <div class="small text-muted">Date of Birth</div>
                          <div class="fw-semibold" id="viewDob"></div>
                    </div>
                    <div class="col-6">
                          <div class="small text-muted">Assigned Doctor</div>
                          <div class="fw-semibold text-primary" id="viewAssignedDoctor"></div>
                    </div>
                    <div class="col-6">
                          <div class="small text-muted">Investigation Type</div>
                          <div class="fw-semibold" id="viewInvestigation"></div>
                    </div>
                    <div class="col-6">
                          <div class="small text-muted">Test Status</div>
                          <div class="mt-1" id="viewStatusBadge"></div>
                    </div>
                    <div class="col-12">
                          <div class="small text-muted">Residential Address</div>
                          <div class="fw-semibold p-2 bg-light rounded" id="viewAddress"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-4 pt-0">
                <button type="button" class="btn btn-secondary rounded-pill px-4 w-100" data-bs-dismiss="modal">Close Profile</button>
            </div>
        </div>
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

    function viewPatient(id) {
        fetch('patients?action=get&id=' + id)
            .then(res => {
                if (!res.ok) throw new Error('Patient not found');
                return res.json();
            })
            .then(data => {
                document.getElementById('viewFullName').textContent = data.fullName;
                document.getElementById('viewPatientIdStr').textContent = data.patientIdStr;
                document.getElementById('viewGender').textContent = data.gender;
                document.getElementById('viewPhone').textContent = data.phone;
                document.getElementById('viewEmail').textContent = data.email || 'N/A';
                document.getElementById('viewDob').textContent = data.dob || 'N/A';
                document.getElementById('viewAssignedDoctor').textContent = data.assignedDoctorName || 'Unassigned';
                document.getElementById('viewInvestigation').textContent = data.investigationType || 'N/A';
                document.getElementById('viewAddress').textContent = data.address || 'No address provided';
                document.getElementById('viewAvatar').src = 'https://ui-avatars.com/api/?name=' + encodeURIComponent(data.fullName) + '&background=random&size=128';
                
                let badgeHtml = '';
                if (data.testStatus === 'PENDING') {
                    badgeHtml = '<span class="badge bg-warning-subtle text-warning border border-warning px-3 rounded-pill">Pending</span>';
                } else if (data.testStatus === 'IN_PROGRESS') {
                    badgeHtml = '<span class="badge bg-info-subtle text-info border border-info px-3 rounded-pill">In Progress</span>';
                } else if (data.testStatus === 'COMPLETED') {
                    badgeHtml = '<span class="badge bg-success-subtle text-success border border-success px-3 rounded-pill">Completed</span>';
                } else {
                    badgeHtml = '<span class="badge bg-danger-subtle text-danger border border-danger px-3 rounded-pill">Cancelled</span>';
                }
                document.getElementById('viewStatusBadge').innerHTML = badgeHtml;

                const modal = new bootstrap.Modal(document.getElementById('viewPatientModal'));
                modal.show();
            })
            .catch(err => alert('Error loading patient: ' + err.message));
    }

    function editPatient(id) {
        fetch('patients?action=get&id=' + id)
            .then(res => {
                if (!res.ok) throw new Error('Patient not found');
                return res.json();
            })
            .then(data => {
                document.getElementById('editId').value = data.id;
                document.getElementById('editFullName').value = data.fullName;
                document.getElementById('editPhone').value = data.phone;
                document.getElementById('editEmail').value = data.email || '';
                document.getElementById('editGender').value = data.gender || 'MALE';
                document.getElementById('editDob').value = data.dob || '';
                document.getElementById('editAddress').value = data.address || '';
                document.getElementById('editAssignedDoctorId').value = data.assignedDoctorId || '';
                document.getElementById('editInvestigationType').value = data.investigationType || '';
                document.getElementById('editTestStatus').value = data.testStatus || 'PENDING';

                const modal = new bootstrap.Modal(document.getElementById('editPatientModal'));
                modal.show();
            })
            .catch(err => alert('Error loading patient: ' + err.message));
    }

    function deletePatient(id, name) {
        if (confirm('Are you sure you want to permanently delete patient "' + name + '"?\nThis will also delete all diagnostic tests, chat history, and notification logs for this patient.')) {
            window.location.href = 'patients?action=delete&id=' + id;
        }
    }
</script>
</body>
</html>
