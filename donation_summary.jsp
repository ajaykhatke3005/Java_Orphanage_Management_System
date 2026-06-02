<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Monthly Donation Summary</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid black; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

<h2>Monthly Donation Summary</h2>

<table>
    <tr>
        <th>Month</th>
        <th>Total Donations</th>
        <th>Total Amount</th>
    </tr>

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Orphanage_Management_Java", "root", "");
            String query = "SELECT DATE_FORMAT(donation_date, '%Y-%m') AS Month, COUNT(id) AS Total_Donations, SUM(donation_amount) AS Total_Amount FROM donations GROUP BY Month ORDER BY Month DESC";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
    %>
                <tr>
                    <td><%= rs.getString("Month") %></td>
                    <td><%= rs.getInt("Total_Donations") %></td>
                    <td><%= rs.getDouble("Total_Amount") %></td>
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
