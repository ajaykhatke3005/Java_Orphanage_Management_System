<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Donors Report</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid black; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

<h2>Donors Report</h2>

<table>
    <tr>
        <th>Donor ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Contact</th>
        <th>City</th>
        <th>Amount Donated</th>
        <th>Date</th>
    </tr>

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Orphanage_Management_Java", "root", "");
            String query = "SELECT * FROM donations ORDER BY donation_date DESC";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
    %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("donor_name") %></td>
                    <td><%= rs.getString("donor_email") %></td>
                    <td><%= rs.getString("donor_contact") %></td>
                    <td><%= rs.getString("donor_city") %></td>
                    <td><%= rs.getDouble("donation_amount") %></td>
                    <td><%= rs.getDate("donation_date") %></td>
                </tr>
    <%
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</table>
<div class='button-container no-print' style="text-align: center;">
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
        display: none; /* Hide elements with class 'no-print' */
    }
}
</style>

</body>
</html>
