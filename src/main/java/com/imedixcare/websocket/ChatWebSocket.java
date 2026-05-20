package com.imedixcare.websocket;

import com.imedixcare.dao.ChatDAO;
import com.imedixcare.model.ChatMessage;
import jakarta.websocket.*;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint("/chat/{userId}")
public class ChatWebSocket {
    private static Map<Integer, Session> sessions = new ConcurrentHashMap<>();
    private ChatDAO chatDAO = new ChatDAO();

    @OnOpen
    public void onOpen(Session session, @PathParam("userId") int userId) {
        sessions.put(userId, session);
        System.out.println("User connected: " + userId);
    }

    @OnMessage
    public void onMessage(String message, Session session, @PathParam("userId") int userId) {
        // message format: receiverId|patientId|text
        String[] parts = message.split("\\|", 3);
        if (parts.length < 3) return;

        int receiverId = Integer.parseInt(parts[0]);
        int patientId = Integer.parseInt(parts[1]);
        String text = parts[2];

        // Save to DB
        ChatMessage msg = new ChatMessage();
        msg.setSenderId(userId);
        msg.setReceiverId(receiverId);
        msg.setPatientId(patientId);
        msg.setMessage(text);
        msg.setMessageType("text");
        chatDAO.saveMessage(msg);

        // Forward to receiver if online
        Session receiverSession = sessions.get(receiverId);
        if (receiverSession != null && receiverSession.isOpen()) {
            try {
                receiverSession.getBasicRemote().sendText(userId + "|" + text);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @OnClose
    public void onClose(Session session, @PathParam("userId") int userId) {
        sessions.remove(userId);
        System.out.println("User disconnected: " + userId);
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        throwable.printStackTrace();
    }
}
