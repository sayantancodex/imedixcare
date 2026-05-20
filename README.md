# iMediXCare Medical ERP - Setup Guide

iMediXCare is a professional healthcare/pathology management system built with Java, JSP, Servlets, and MySQL.

## Prerequisites
- **JDK 17 or higher**
- **Apache Tomcat 10+** (Jakarta EE 9/10 support)
- **MySQL 8.0+**
- **Maven** (optional, but recommended for dependency management)

## Installation Steps

### 1. Database Configuration
1. Open your MySQL client (e.g., MySQL Workbench or Command Line).
2. Execute the [schema.sql](file:///d:/productions/internship/sql/schema.sql) file to create the database and seed initial data.
3. Update the database credentials in [DBConnection.java](file:///d:/productions/internship/src/main/java/com/imedixcare/config/DBConnection.java):
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/imedixcare";
   private static final String USER = "your_username";
   private static final String PASSWORD = "your_password";
   ```

### 2. WhatsApp API Setup
1. Sign up for a [Twilio Account](https://www.twilio.com/) or [Meta WhatsApp Cloud API](https://developers.facebook.com/).
2. Obtain your API credentials (SID, Token, Phone ID).
3. Update [WhatsAppService.java](file:///d:/productions/internship/src/main/java/com/imedixcare/service/WhatsAppService.java) with these details.

### 3. Deploying to Tomcat
1. Compile the Java classes.
2. Package the project as a `.war` file.
3. Drop the `.war` file into the `webapps` folder of your Tomcat installation.
4. Start Tomcat and navigate to `http://localhost:8080/imedixcare/login`.

## Default Login Credentials
- **Username**: `admin` | **Password**: `admin123`
- **Username**: `dr_smith` | **Password**: `doctor123`
- **Username**: `reception` | **Password**: `recep123`

## Features
- **Role-based Authentication**: Admin, Doctor, Receptionist, etc.
- **Real-time Chat**: WebSocket-based communication between staff and patients.
- **WhatsApp Notifications**: Automated status updates for diagnostic tests.
- **Modern Dashboard**: Responsive UI built with Bootstrap 5.
