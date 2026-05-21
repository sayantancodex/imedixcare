package com.imedixcare.dao;

import com.imedixcare.config.DBConnection;
import com.imedixcare.model.Patient;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {
    public List<Patient> getAllPatients() {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT p.*, u.full_name as doctor_name FROM patients p LEFT JOIN users u ON p.assigned_doctor_id = u.id ORDER BY p.created_at DESC";
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
                p.setDob(rs.getDate("dob"));
                p.setAddress(rs.getString("address"));
                p.setAssignedDoctorId(rs.getInt("assigned_doctor_id"));
                p.setInvestigationType(rs.getString("investigation_type"));
                p.setTestStatus(rs.getString("test_status"));
                p.setAssignedDoctorName(rs.getString("doctor_name"));
                patients.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patients;
    }

    public Patient getPatientById(int id) {
        String sql = "SELECT p.*, u.full_name as doctor_name FROM patients p LEFT JOIN users u ON p.assigned_doctor_id = u.id WHERE p.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Patient p = new Patient();
                    p.setId(rs.getInt("id"));
                    p.setPatientIdStr(rs.getString("patient_id_str"));
                    p.setFullName(rs.getString("full_name"));
                    p.setPhone(rs.getString("phone"));
                    p.setEmail(rs.getString("email"));
                    p.setGender(rs.getString("gender"));
                    p.setDob(rs.getDate("dob"));
                    p.setAddress(rs.getString("address"));
                    p.setAssignedDoctorId(rs.getInt("assigned_doctor_id"));
                    p.setInvestigationType(rs.getString("investigation_type"));
                    p.setTestStatus(rs.getString("test_status"));
                    p.setAssignedDoctorName(rs.getString("doctor_name"));
                    return p;
                }
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

    private String generateNextPatientId(Connection conn) throws SQLException {
        String sql = "SELECT patient_id_str FROM patients ORDER BY id DESC LIMIT 1";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                String lastId = rs.getString("patient_id_str");
                if (lastId != null && lastId.startsWith("P-")) {
                    try {
                        int num = Integer.parseInt(lastId.substring(2));
                        return "P-" + (num + 1);
                    } catch (NumberFormatException e) {
                        // ignore and fall back
                    }
                }
            }
        }
        return "P-1001";
    }

    public boolean addPatient(Patient p) {
        String insertSql = "INSERT INTO patients (patient_id_str, full_name, phone, email, gender, dob, address, assigned_doctor_id, investigation_type, test_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            String nextId = generateNextPatientId(conn);
            p.setPatientIdStr(nextId);
            try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                ps.setString(1, p.getPatientIdStr());
                ps.setString(2, p.getFullName());
                ps.setString(3, p.getPhone());
                ps.setString(4, p.getEmail());
                ps.setString(5, p.getGender());
                ps.setDate(6, p.getDob());
                ps.setString(7, p.getAddress());
                if (p.getAssignedDoctorId() > 0) {
                    ps.setInt(8, p.getAssignedDoctorId());
                } else {
                    ps.setNull(8, Types.INTEGER);
                }
                ps.setString(9, p.getInvestigationType());
                ps.setString(10, p.getTestStatus());
                
                int affected = ps.executeUpdate();
                conn.commit();
                return affected > 0;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePatient(Patient p) {
        String sql = "UPDATE patients SET full_name = ?, phone = ?, email = ?, gender = ?, dob = ?, address = ?, assigned_doctor_id = ?, investigation_type = ?, test_status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getFullName());
            ps.setString(2, p.getPhone());
            ps.setString(3, p.getEmail());
            ps.setString(4, p.getGender());
            ps.setDate(5, p.getDob());
            ps.setString(6, p.getAddress());
            if (p.getAssignedDoctorId() > 0) {
                ps.setInt(7, p.getAssignedDoctorId());
            } else {
                ps.setNull(7, Types.INTEGER);
            }
            ps.setString(8, p.getInvestigationType());
            ps.setString(9, p.getTestStatus());
            ps.setInt(10, p.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deletePatient(int id) {
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                // Delete dependent tests
                try (PreparedStatement ps = conn.prepareStatement("DELETE FROM tests WHERE patient_id = ?")) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }
                // Delete dependent chat messages
                try (PreparedStatement ps = conn.prepareStatement("DELETE FROM chat_messages WHERE patient_id = ?")) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }
                // Delete dependent whatsapp logs
                try (PreparedStatement ps = conn.prepareStatement("DELETE FROM whatsapp_logs WHERE patient_id = ?")) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }
                // Delete patient
                int affected;
                try (PreparedStatement ps = conn.prepareStatement("DELETE FROM patients WHERE id = ?")) {
                    ps.setInt(1, id);
                    affected = ps.executeUpdate();
                }
                conn.commit();
                return affected > 0;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
