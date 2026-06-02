<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
String dbUrl = "jdbc:mysql://localhost:3306/Orphanage_Management_Java";
String dbUser = "root";
String dbPassword = "";

Connection conn = null;
PreparedStatement pstmt = null;
String message = "";

int adopterId = Integer.parseInt(request.getParameter("id"));
String newStatus = request.getParameter("status");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

    String updateQuery = "UPDATE adopters SET status = ? WHERE id = ?";
    pstmt = conn.prepareStatement(updateQuery);
    pstmt.setString(1, newStatus);
    pstmt.setInt(2, adopterId);
    
    int rowsAffected = pstmt.executeUpdate();

    if (rowsAffected > 0) {
        message = "✅ Request status updated successfully!";
    } else {
        message = "❌ Error updating request.";
    }

} catch (Exception e) {
    message = "❌ Error: " + e.getMessage();
} finally {
    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Processing...</title>
    <script>
        alert("<%= message %>");
        window.location.href = "admin_request.jsp";
    </script>
</head>
<body>
</body>
</html>
