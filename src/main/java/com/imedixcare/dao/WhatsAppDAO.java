package com.imedixcare.dao;

import com.imedixcare.config.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class WhatsAppDAO {
    public void logMessage(int patientId, String phone, String message, String status) {
        String sql = "INSERT INTO whatsapp_logs (patient_id, phone, message, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            ps.setString(2, phone);
            ps.setString(3, message);
            ps.setString(4, status);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
