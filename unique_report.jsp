<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Comprehensive Report</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin: 50px; }
        table { width: 80%; margin: 20px auto; border-collapse: collapse; }
        th, td { border: 1px solid black; padding: 10px; text-align: center; }
        th { background-color: #f2f2f2; }
        .summary { font-size: 20px; font-weight: bold; margin-top: 20px; }
    </style>
</head>
<body>

    <h2>Orphanage Management </h2>

    <%
        String dbUrl = "jdbc:mysql://localhost:3306/Orphanage_Management_Java";
        String dbUser = "root";
        String dbPassword = "";
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        int totalAdoptions = 0, pendingAdoptions = 0, approvedAdoptions = 0, rejectedAdoptions = 0;
        int totalDonors = 0;
        double totalDonations = 0, highestDonation = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            stmt = conn.createStatement();

            // Get Adoption Statistics
            rs = stmt.executeQuery("SELECT COUNT(*) AS total, SUM(status = 'Pending') AS pending, SUM(status = 'Approved') AS approved, SUM(status = 'Rejected') AS rejected FROM adopters");
            if (rs.next()) {
                totalAdoptions = rs.getInt("total");
                pendingAdoptions = rs.getInt("pending");
                approvedAdoptions = rs.getInt("approved");
                rejectedAdoptions = rs.getInt("rejected");
            }
            rs.close();

            // Get Donor Statistics
            rs = stmt.executeQuery("SELECT COUNT(*) AS totalDonors, SUM(donation_amount) AS totalDonations, MAX(donation_amount) AS highestDonation FROM donations");
            if (rs.next()) {
                totalDonors = rs.getInt("totalDonors");
                totalDonations = rs.getDouble("totalDonations");
                highestDonation = rs.getDouble("highestDonation");
            }
            rs.close();

        } catch (Exception e) {
            out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>

    <!-- Adoption Statistics Table -->
    <div class="summary">Adoption Request Summary</div>
    <table>
        <tr>
            <th>Total Requests</th>
            <th>Pending</th>
            <th>Approved</th>
            <th>Rejected</th>
        </tr>
        <tr>
            <td><%= totalAdoptions %></td>
            <td style="color: orange;"><%= pendingAdoptions %></td>
            <td style="color: green;"><%= approvedAdoptions %></td>
            <td style="color: red;"><%= rejectedAdoptions %></td>
        </tr>
    </table>

    <!-- Donor Statistics Table -->
    <div class="summary">Donor Contribution Summary</div>
    <table>
        <tr>
            <th>Total Donors</th>
            <th>Total Donations (₹)</th>
            <th>Highest Donation (₹)</th>
        </tr>
        <tr>
            <td><%= totalDonors %></td>
            <td><%= totalDonations %></td>
            <td style="color: blue;"><%= highestDonation %></td>
        </tr>
    </table>

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
            display: none; /* Hide elements with class 'no-print' */
        }
    }
</style>
        

</body>
</html>
