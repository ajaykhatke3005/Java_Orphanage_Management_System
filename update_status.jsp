<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
String dbUrl = "jdbc:mysql://localhost:3306/Orphanage_Management_Java";
String dbUser = "root";
String dbPassword = "";
Connection conn = null;
PreparedStatement pstmt = null;
String message = "";

try {
    // Get form data
    int adopterId = Integer.parseInt(request.getParameter("id"));
    String newStatus = request.getParameter("status");

    // Load JDBC Driver
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

    // Update adoption status
    String updateQuery = "UPDATE adopters SET status = ? WHERE id = ?";
    pstmt = conn.prepareStatement(updateQuery);
    pstmt.setString(1, newStatus);
    pstmt.setInt(2, adopterId);
    int rowsAffected = pstmt.executeUpdate();

    if (rowsAffected > 0) {
        message = "✅ Adoption status updated successfully!";
        out.println("<h3 style='color:green;'>" + message + "</h3>");
    } else {
        out.println("<h3 style='color:red;'>❌ Failed to update adoption status.</h3>");
    }
} catch (Exception e) {
    out.println("<h3 style='color:red;'>❌ Error: " + e.getMessage() + "</h3>");
    e.printStackTrace();
} finally {
    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();
}
%>
