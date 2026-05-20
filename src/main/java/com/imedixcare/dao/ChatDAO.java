package com.imedixcare.dao;

import com.imedixcare.config.DBConnection;
import com.imedixcare.model.ChatMessage;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ChatDAO {
    public void saveMessage(ChatMessage msg) {
        String sql = "INSERT INTO chat_messages (sender_id, receiver_id, patient_id, message, message_type) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, msg.getSenderId());
            ps.setInt(2, msg.getReceiverId());
            ps.setInt(3, msg.getPatientId());
            ps.setString(4, msg.getMessage());
            ps.setString(5, msg.getMessageType());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<ChatMessage> getChatHistory(int user1, int user2, int patientId) {
        List<ChatMessage> history = new ArrayList<>();
        String sql = "SELECT * FROM chat_messages WHERE ((sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)) AND patient_id = ? ORDER BY sent_at ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user1);
            ps.setInt(2, user2);
            ps.setInt(3, user2);
            ps.setInt(4, user1);
            ps.setInt(5, patientId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ChatMessage msg = new ChatMessage();
                msg.setId(rs.getInt("id"));
                msg.setSenderId(rs.getInt("sender_id"));
                msg.setMessage(rs.getString("message"));
                msg.setSentAt(rs.getTimestamp("sent_at"));
                history.add(msg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return history;
    }
}
