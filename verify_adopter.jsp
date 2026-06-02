<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String userEmail = request.getParameter("email");
        String userPhone = request.getParameter("phone");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String dbUrl = "jdbc:mysql://localhost:3306/Orphanage_Management_Java";
        String dbUser = "root";
        String dbPassword = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            String sql = "SELECT status FROM adopters WHERE email = ? AND phone = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userEmail);
            pstmt.setString(2, userPhone);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String status = rs.getString("status");

                if ("Approved".equalsIgnoreCase(status)) {
                    session.setAttribute("verifiedUser", userEmail); // Store verified session
                    response.sendRedirect("view_children.jsp"); // Redirect to children list
                    return;
                } else {
                    message = "Your adoption request is not approved yet.";
                }
            } else {
                message = "Invalid email or phone number. Please try again.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "An error occurred. Please try again later.";
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Verify Adopter</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f9;
            padding: 50px;
        }
        .container {
            width: 400px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin: auto;
        }
        input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            font-size: 1rem;
        }
        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Verify Your Identity</h2>
        <p>Please enter your registered email and phone number to proceed.</p>
        
        <% if (!message.isEmpty()) { %>
            <p class="error"><%= message %></p>
        <% } %>

        <form method="post">
            <input type="text" name="email" placeholder="Enter your email" required>
            <input type="text" name="phone" placeholder="Enter your phone number" required>
            <input type="submit" value="Verify">
        </form>
    </div>

</body>
</html>
