package com.imedixcare.model;

import java.sql.Date;

public class Patient {
    private int id;
    private String patientIdStr;
    private String fullName;
    private String phone;
    private String email;
    private String gender;
    private Date dob;
    private String address;
    private int assignedDoctorId;
    private String investigationType;
    private String testStatus;
    private String assignedDoctorName;

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getPatientIdStr() { return patientIdStr; }
    public void setPatientIdStr(String patientIdStr) { this.patientIdStr = patientIdStr; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public Date getDob() { return dob; }
    public void setDob(Date dob) { this.dob = dob; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public int getAssignedDoctorId() { return assignedDoctorId; }
    public void setAssignedDoctorId(int assignedDoctorId) { this.assignedDoctorId = assignedDoctorId; }
    public String getInvestigationType() { return investigationType; }
    public void setInvestigationType(String investigationType) { this.investigationType = investigationType; }
    public String getTestStatus() { return testStatus; }
    public void setTestStatus(String testStatus) { this.testStatus = testStatus; }
    public String getAssignedDoctorName() { return assignedDoctorName; }
    public void setAssignedDoctorName(String assignedDoctorName) { this.assignedDoctorName = assignedDoctorName; }
}
