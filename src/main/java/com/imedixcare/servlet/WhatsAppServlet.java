package com.imedixcare.servlet;

import com.imedixcare.dao.PatientDAO;
import com.imedixcare.dao.WhatsAppDAO;
import com.imedixcare.model.Patient;
import com.imedixcare.service.WhatsAppService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/send-whatsapp")
public class WhatsAppServlet extends HttpServlet {
    private WhatsAppService whatsappService = new WhatsAppService();
    private PatientDAO patientDAO = new PatientDAO();
    private WhatsAppDAO whatsappDAO = new WhatsAppDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        Patient patient = patientDAO.getPatientById(patientId);

        if (patient != null) {
            String status = whatsappService.sendNotification(
                patient.getPhone(), 
                patient.getFullName(), 
                patient.getInvestigationType(), 
                patient.getTestStatus()
            );

            // Log to database
            whatsappDAO.logMessage(patientId, patient.getPhone(), "Appointment Notification", status);

            response.setContentType("application/json");
            response.getWriter().write("{\"status\": \"" + status + "\"}");
        } else {
            response.setStatus(404);
            response.getWriter().write("{\"error\": \"Patient not found\"}");
        }
    }
}
