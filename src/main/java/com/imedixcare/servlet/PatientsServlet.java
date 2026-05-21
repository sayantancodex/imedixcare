package com.imedixcare.servlet;

import com.imedixcare.dao.PatientDAO;
import com.imedixcare.dao.UserDAO;
import com.imedixcare.model.Patient;
import com.imedixcare.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/patients")
public class PatientsServlet extends HttpServlet {
    private PatientDAO patientDAO = new PatientDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        if ("get".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    Patient p = patientDAO.getPatientById(id);
                    if (p != null) {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        String json = String.format(
                            "{\"id\":%d,\"patientIdStr\":\"%s\",\"fullName\":\"%s\",\"phone\":\"%s\",\"email\":\"%s\",\"gender\":\"%s\",\"dob\":\"%s\",\"address\":\"%s\",\"assignedDoctorId\":%d,\"assignedDoctorName\":\"%s\",\"investigationType\":\"%s\",\"testStatus\":\"%s\"}",
                            p.getId(),
                            escapeJson(p.getPatientIdStr()),
                            escapeJson(p.getFullName()),
                            escapeJson(p.getPhone()),
                            escapeJson(p.getEmail()),
                            escapeJson(p.getGender()),
                            p.getDob() != null ? p.getDob().toString() : "",
                            escapeJson(p.getAddress()),
                            p.getAssignedDoctorId(),
                            escapeJson(p.getAssignedDoctorName()),
                            escapeJson(p.getInvestigationType()),
                            escapeJson(p.getTestStatus())
                        );
                        response.getWriter().write(json);
                        return;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"error\":\"Patient not found\"}");
            return;
        } else if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    patientDAO.deletePatient(id);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            response.sendRedirect("patients");
            return;
        }

        List<Patient> patients = patientDAO.getAllPatients();
        List<User> doctors = userDAO.getDoctors();
        request.setAttribute("patients", patients);
        request.setAttribute("doctors", doctors);
        request.getRequestDispatcher("/jsp/patient-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            Patient p = populatePatientFromRequest(request);
            patientDAO.addPatient(p);
        } else if ("update".equals(action)) {
            Patient p = populatePatientFromRequest(request);
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    p.setId(Integer.parseInt(idStr));
                    patientDAO.updatePatient(p);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        } else if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    patientDAO.deletePatient(Integer.parseInt(idStr));
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        }
        response.sendRedirect("patients");
    }

    private Patient populatePatientFromRequest(HttpServletRequest request) {
        Patient p = new Patient();
        p.setFullName(request.getParameter("fullName"));
        p.setPhone(request.getParameter("phone"));
        p.setEmail(request.getParameter("email"));
        p.setGender(request.getParameter("gender"));
        p.setInvestigationType(request.getParameter("investigationType"));
        p.setTestStatus(request.getParameter("testStatus"));
        p.setAddress(request.getParameter("address"));

        String dobStr = request.getParameter("dob");
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try {
                p.setDob(java.sql.Date.valueOf(dobStr));
            } catch (IllegalArgumentException e) {
                // ignore
            }
        }

        String doctorIdStr = request.getParameter("assignedDoctorId");
        if (doctorIdStr != null && !doctorIdStr.trim().isEmpty()) {
            try {
                p.setAssignedDoctorId(Integer.parseInt(doctorIdStr));
            } catch (NumberFormatException e) {
                // ignore
            }
        }
        return p;
    }

    private String escapeJson(String val) {
        if (val == null) return "";
        return val.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
