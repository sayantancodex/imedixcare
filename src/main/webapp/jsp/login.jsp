<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | iMediXCare ERP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
            max-width: 450px;
            width: 100%;
        }
        .card-header {
            background: #0d6efd;
            color: white;
            padding: 2rem;
            text-align: center;
            border: none;
        }
        .card-header i {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .card-body {
            padding: 2.5rem;
            background: white;
        }
        .form-control {
            border-radius: 10px;
            padding: 0.8rem 1.2rem;
            border: 1px solid #e0e0e0;
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.1);
        }
        .btn-login {
            border-radius: 10px;
            padding: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(13, 110, 253, 0.3);
        }
        .error-message {
            color: #dc3545;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="login-card card">
    <div class="card-header">
        <i class="bi bi-hospital"></i>
        <h2 class="fw-bold mb-0">iMediXCare</h2>
        <p class="mb-0 opacity-75">Medical ERP Portal</p>
    </div>
    <div class="card-body">
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <i class="bi bi-exclamation-circle me-1"></i> <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <form action="login" method="post">
            <div class="mb-3">
                <label for="username" class="form-label text-secondary small fw-bold">USERNAME</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-person text-primary"></i></span>
                    <input type="text" class="form-control bg-light border-start-0" id="username" name="username" placeholder="Enter username" required>
                </div>
            </div>
            <div class="mb-4">
                <label for="password" class="form-label text-secondary small fw-bold">PASSWORD</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock text-primary"></i></span>
                    <input type="password" class="form-control bg-light border-start-0" id="password" name="password" placeholder="Enter password" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary btn-login w-100 mb-3">Sign In</button>
            <div class="text-center">
                <a href="#" class="text-decoration-none small text-muted">Forgot password?</a>
            </div>
        </form>
    </div>
    <div class="card-footer bg-white border-0 text-center pb-4">
        <p class="small text-muted mb-0">&copy; 2026 iMediXCare ERP. All rights reserved.</p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
