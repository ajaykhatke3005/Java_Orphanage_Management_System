<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*" %>

<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String message = "";
boolean success = false;

String dbUrl = "jdbc:mysql://localhost:3306/Orphanage_Management_Java";
String dbUser = "root";
String dbPassword = "";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

    request.setCharacterEncoding("UTF-8");

    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    int age = Integer.parseInt(request.getParameter("age"));
    String gender = request.getParameter("gender");
    String address = request.getParameter("address");
    String occupation = request.getParameter("occupation");
    double income = Double.parseDouble(request.getParameter("income"));
    String maritalstatus = request.getParameter("maritalstatus");
    String reason = request.getParameter("reason");

    // Check if the user already has a request
    String checkQuery = "SELECT id FROM adopters WHERE email = ? OR phone = ?";
    pstmt = conn.prepareStatement(checkQuery);
    pstmt.setString(1, email);
    pstmt.setString(2, phone);
    rs = pstmt.executeQuery();

    if (rs.next()) {
        message = "❌ You have already submitted an adoption request.";
    } else {
        // Insert data
        String sql = "INSERT INTO adopters (fullName, email, phone, age, gender, address, occupation, income, maritalstatus, reason) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, fullName);
        pstmt.setString(2, email);
        pstmt.setString(3, phone);
        pstmt.setInt(4, age);
        pstmt.setString(5, gender);
        pstmt.setString(6, address);
        pstmt.setString(7, occupation);
        pstmt.setDouble(8, income);
        pstmt.setString(9, maritalstatus);
        pstmt.setString(10, reason);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            success = true;
            message = "✅ Adoption application submitted successfully!";
        } else {
            message = "❌ Submission failed.";
        }
    }

} catch (Exception e) {
    message = "❌ Error: " + e.getMessage();
} finally {
    if (rs != null) rs.close();
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
        <% if (success) { %>
            window.location.href = "adopter_form.jsp";
        <% } else { %>
            window.history.back();
        <% } %>
    </script>
</head>
<body>
</body>
</html>
