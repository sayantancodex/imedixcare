package com.imedixcare.config;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
    private static String URL = "jdbc:mysql://localhost:3306/imedixcare?useSSL=false&allowPublicKeyRetrieval=true";
    private static String USER = "root";
    private static String PASSWORD = ""; 

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
                if (input != null) {
                    Properties prop = new Properties();
                    prop.load(input);
                    URL = prop.getProperty("db.url", URL);
                    USER = prop.getProperty("db.user", USER);
                    PASSWORD = prop.getProperty("db.password", PASSWORD);
                }
            } catch (Exception ex) {
                // Property file not found or error loading, using defaults
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
