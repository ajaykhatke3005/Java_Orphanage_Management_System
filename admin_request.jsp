<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
String dbUrl = "jdbc:mysql://localhost:3306/Orphanage_Management_Java";
String dbUser = "root";
String dbPassword = "";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

    // Fetch all adoption requests
    String query = "SELECT * FROM adopters";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Manage Adoption Requests</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.2);
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .status-dropdown {
            padding: 6px;
            font-size: 1rem;
            border-radius: 5px;
            border: 1px solid #ccc;
            width: 100%;
        }
        .update-btn {
            background-color: #28a745;
            color: white;
            padding: 8px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .update-btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Admin Panel - Manage Adoption Requests</h2>

        <table>
            <tr>
                <th>ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Address</th>
                <th>Occupation</th>
                <th>Income</th>
                <th>Marital Status</th>
                <th>Reason</th>
                <th>Status</th>
                <th>Update</th>
            </tr>

            <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("fullName") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("phone") %></td>
                <td><%= rs.getInt("age") %></td>
                <td><%= rs.getString("gender") %></td>
                <td><%= rs.getString("address") %></td>
                <td><%= rs.getString("occupation") %></td>
                <td><%= rs.getString("income") %></td>
                <td><%= rs.getString("maritalStatus") %></td>
                <td><%= rs.getString("reason") %></td>
                <td>
                    <form action="update_request.jsp" method="POST">
                        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                        <select name="status" class="status-dropdown">
                            <option value="Pending" <%= rs.getString("status").equals("Pending") ? "selected" : "" %>>Pending</option>
                            <option value="Approved" <%= rs.getString("status").equals("Approved") ? "selected" : "" %>>Approved</option>
                            <option value="Rejected" <%= rs.getString("status").equals("Rejected") ? "selected" : "" %>>Rejected</option>
                        </select>
                </td>
                <td>
                        <button type="submit" class="update-btn">Update</button>
                    </form>
                </td>
            </tr>
            <% } %>

        </table>
    </div>

</body>
</html>
<div class='button-container no-print'>
    <button onclick='goHome()'>🏠 HOME</button>
    <button onclick='printPage()'>🖨️ PRINT</button>
</div>
<script>
    function goHome() {
        window.location.href = 'index.jsp'; // Change to your home page
    }

    function printPage() {
        window.print(); // Print the current page
    }
</script>
<style>
@media print {
    .no-print {
        display: none;
    }
}
</style>

<%
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (rs != null) rs.close();
    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();
}
%>