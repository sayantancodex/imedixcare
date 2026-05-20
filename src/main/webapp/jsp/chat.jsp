<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chat | iMediXCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .chat-container {
            height: calc(100vh - 160px);
            background: white;
            border-radius: 15px;
            overflow: hidden;
            display: flex;
        }
        .chat-sidebar {
            width: 300px;
            border-right: 1px solid #eee;
            overflow-y: auto;
        }
        .chat-main {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        .message-area {
            flex-grow: 1;
            padding: 20px;
            overflow-y: auto;
            background: #f8f9fa;
        }
        .message {
            margin-bottom: 15px;
            max-width: 70%;
        }
        .message.sent {
            margin-left: auto;
        }
        .message-bubble {
            padding: 10px 15px;
            border-radius: 15px;
            position: relative;
        }
        .sent .message-bubble {
            background: #0d6efd;
            color: white;
            border-bottom-right-radius: 2px;
        }
        .received .message-bubble {
            background: #e9ecef;
            color: #333;
            border-bottom-left-radius: 2px;
        }
        .chat-input {
            padding: 20px;
            border-top: 1px solid #eee;
        }
    </style>
</head>
<body class="bg-light">

<%@ include file="header.jsp" %>

<div class="container-fluid">
    <div class="row">
        <%@ include file="sidebar.jsp" %>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold mb-0">Patient Consultations</h2>
                <div class="text-muted"><i class="bi bi-circle-fill text-success small"></i> Online as <%= user.getFullName() %></div>
            </div>

            <div class="chat-container shadow-sm">
                <!-- Sidebar: Active Chats -->
                <div class="chat-sidebar">
                    <div class="p-3 border-bottom">
                        <input type="text" class="form-control rounded-pill" placeholder="Search chats...">
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action active py-3">
                            <div class="d-flex w-100 align-items-center">
                                <img src="https://ui-avatars.com/api/?name=Robert+Brown&background=random" class="rounded-circle me-2" width="40" height="40">
                                <div class="flex-grow-1">
                                    <div class="d-flex justify-content-between">
                                        <h6 class="mb-0 fw-bold">Robert Brown</h6>
                                        <small>Just now</small>
                                    </div>
                                    <div class="small text-truncate opacity-75">Thank you, doctor.</div>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action py-3 border-bottom">
                            <div class="d-flex w-100 align-items-center">
                                <img src="https://ui-avatars.com/api/?name=Emily+Davis&background=random" class="rounded-circle me-2" width="40" height="40">
                                <div class="flex-grow-1">
                                    <div class="d-flex justify-content-between">
                                        <h6 class="mb-0">Emily Davis</h6>
                                        <small>2h ago</small>
                                    </div>
                                    <div class="small text-truncate text-muted">When will the report be ready?</div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>

                <!-- Main Chat Area -->
                <div class="chat-main">
                    <div class="p-3 border-bottom bg-white d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center">
                            <img src="https://ui-avatars.com/api/?name=Robert+Brown&background=random" class="rounded-circle me-2" width="40" height="40">
                            <div>
                                <h6 class="mb-0 fw-bold">Robert Brown</h6>
                                <small class="text-success">Typing...</small>
                            </div>
                        </div>
                        <div>
                            <button class="btn btn-light rounded-circle me-2"><i class="bi bi-telephone"></i></button>
                            <button class="btn btn-light rounded-circle"><i class="bi bi-camera-video"></i></button>
                        </div>
                    </div>

                    <div class="message-area" id="messageArea">
                        <!-- Messages will appear here -->
                        <div class="message received">
                            <div class="message-bubble shadow-sm">
                                Hello, I wanted to check if my blood test results are in.
                            </div>
                            <small class="text-muted px-2">10:45 AM</small>
                        </div>
                        <div class="message sent">
                            <div class="message-bubble shadow-sm">
                                Not yet, Robert. It should be ready by tomorrow afternoon.
                            </div>
                            <small class="text-muted px-2">10:46 AM</small>
                        </div>
                    </div>

                    <div class="chat-input bg-white">
                        <div class="input-group">
                            <button class="btn btn-light border" type="button"><i class="bi bi-paperclip"></i></button>
                            <input type="text" id="messageInput" class="form-control border" placeholder="Type your message here...">
                            <button class="btn btn-primary px-4" type="button" id="sendBtn">
                                <i class="bi bi-send-fill"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
    const userId = <%= user.getId() %>;
    const receiverId = 2; // Demo: Admin/Doctor ID
    const patientId = 1; // Demo: Robert Brown
    
    // WebSocket Setup
    const socket = new WebSocket(`ws://${window.location.host}/imedixcare/chat/${userId}`);

    socket.onmessage = function(event) {
        const parts = event.data.split('|');
        const sender = parts[0];
        const text = parts[1];
        appendMessage(text, 'received');
    };

    document.getElementById('sendBtn').onclick = sendMessage;
    document.getElementById('messageInput').onkeypress = (e) => {
        if (e.key === 'Enter') sendMessage();
    };

    function sendMessage() {
        const input = document.getElementById('messageInput');
        const text = input.value.trim();
        if (text && socket.readyState === WebSocket.OPEN) {
            socket.send(`${receiverId}|${patientId}|${text}`);
            appendMessage(text, 'sent');
            input.value = '';
        }
    }

    function appendMessage(text, type) {
        const area = document.getElementById('messageArea');
        const div = document.createElement('div');
        div.className = `message ${type}`;
        div.innerHTML = `
            <div class="message-bubble shadow-sm">${text}</div>
            <small class="text-muted px-2">${new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'})}</small>
        `;
        area.appendChild(div);
        area.scrollTop = area.scrollHeight;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
