package com.imedixcare.dao;

import com.imedixcare.config.DBConnection;
import com.imedixcare.model.Patient;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {
    public List<Patient> getAllPatients() {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM patients ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Patient p = new Patient();
                p.setId(rs.getInt("id"));
                p.setPatientIdStr(rs.getString("patient_id_str"));
                p.setFullName(rs.getString("full_name"));
                p.setPhone(rs.getString("phone"));
                p.setEmail(rs.getString("email"));
                p.setGender(rs.getString("gender"));
                p.setInvestigationType(rs.getString("investigation_type"));
                p.setTestStatus(rs.getString("test_status"));
                patients.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patients;
    }

    public Patient getPatientById(int id) {
        String sql = "SELECT * FROM patients WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Patient p = new Patient();
                p.setId(rs.getInt("id"));
                p.setPatientIdStr(rs.getString("patient_id_str"));
                p.setFullName(rs.getString("full_name"));
                p.setPhone(rs.getString("phone"));
                p.setTestStatus(rs.getString("test_status"));
                p.setInvestigationType(rs.getString("investigation_type"));
                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateTestStatus(int patientId, String status) {
        String sql = "UPDATE patients SET test_status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, patientId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
