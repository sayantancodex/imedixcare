package com.imedixcare.servlet;

import com.imedixcare.dao.PatientDAO;
import com.imedixcare.model.Patient;
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        List<Patient> patients = patientDAO.getAllPatients();
        request.setAttribute("patients", patients);
        request.getRequestDispatcher("/jsp/patient-list.jsp").forward(request, response);
    }
}
