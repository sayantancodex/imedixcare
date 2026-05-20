-- iMediXCare Database Schema

CREATE DATABASE IF NOT EXISTS imedixcare;
USE imedixcare;

-- Users table for authentication and roles
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('ADMIN', 'PSYCHOLOGIST', 'DOCTOR', 'LAB_STAFF', 'RECEPTIONIST') NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Patients table
CREATE TABLE IF NOT EXISTS patients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id_str VARCHAR(20) UNIQUE NOT NULL, -- e.g., P-1001
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    gender ENUM('MALE', 'FEMALE', 'OTHER'),
    dob DATE,
    address TEXT,
    assigned_doctor_id INT,
    investigation_type VARCHAR(100),
    test_status ENUM('PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assigned_doctor_id) REFERENCES users(id)
);

-- Diagnostic Tests
CREATE TABLE IF NOT EXISTS tests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    test_name VARCHAR(255) NOT NULL,
    description TEXT,
    result_data TEXT,
    status ENUM('PENDING', 'COMPLETED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

-- Chat Messages
CREATE TABLE IF NOT EXISTS chat_messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    patient_id INT, -- context of chat
    message TEXT NOT NULL,
    message_type VARCHAR(50) DEFAULT 'text',
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'SENT',
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (receiver_id) REFERENCES users(id),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

-- WhatsApp Logs
CREATE TABLE IF NOT EXISTS whatsapp_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    phone VARCHAR(20),
    message TEXT,
    status VARCHAR(50),
    api_response TEXT,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

-- Notifications
CREATE TABLE IF NOT EXISTS notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    title VARCHAR(255),
    message TEXT,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Seed Data
INSERT INTO users (username, password, full_name, role, email) VALUES 
('admin', 'admin123', 'System Administrator', 'ADMIN', 'admin@imedixcare.com'),
('dr_smith', 'doctor123', 'Dr. John Smith', 'DOCTOR', 'smith@imedixcare.com'),
('reception', 'recep123', 'Alice Johnson', 'RECEPTIONIST', 'reception@imedixcare.com');

INSERT INTO patients (patient_id_str, full_name, phone, gender, investigation_type, test_status) VALUES
('P-1001', 'Robert Brown', '+919876543210', 'MALE', 'Pathology - Blood Test', 'PENDING'),
('P-1002', 'Emily Davis', '+919876543211', 'FEMALE', 'Psychology - Assessment', 'IN_PROGRESS');
