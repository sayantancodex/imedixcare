package com.imedixcare.service;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class WhatsAppService {
    // These should be configured in a properties file or environment variables
    private static final String ACCOUNT_SID = "YOUR_TWILIO_SID";
    private static final String AUTH_TOKEN = "YOUR_TWILIO_TOKEN";
    private static final String FROM_NUMBER = "whatsapp:+14155238886"; // Twilio Sandbox Number

    public String sendNotification(String toPhone, String patientName, String testName, String status) {
        // Example using Twilio API via HttpURLConnection (to avoid dependency issues in this demo)
        // For production, use Twilio Java SDK
        try {
            String message = "Hello " + patientName + ",\n\n" +
                             "Your diagnostic test \"" + testName + "\" has been scheduled successfully.\n\n" +
                             "Status: " + status + "\n\n" +
                             "Please visit the hospital/lab on time.\n\n" +
                             "Regards,\niMediXCare";

            // Note: This is a placeholder for the actual API call.
            // In a real scenario, you would use Twilio SDK or Meta Graph API.
            System.out.println("DEBUG: Sending WhatsApp to " + toPhone + " with message: " + message);
            
            // Return success/failure based on actual API response
            return "SUCCESS"; 
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }
}
