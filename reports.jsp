<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reports Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 50px;
        }
        .dropdown {
            margin: 20px;
        }
        select {
            padding: 10px;
            font-size: 16px;
        }
        button {
            padding: 10px 15px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
    </style>
    <script>
        function openReport() {
            var selectedReport = document.getElementById("reportSelect").value;
            if (selectedReport) {
                window.location.href = selectedReport;
            }
        }
    </script>
</head>
<body>

    <h2>Orphanage Management Reports</h2>
    <div class="dropdown">
        <label for="reportSelect">Select a Report:</label>
        <select id="reportSelect">
            <option value="">-- Choose Report --</option>
            <option value="donors_report.jsp">Donors Report</option>
            <option value="donation_summary.jsp">Monthly Donation Summary</option>
            <option value="unique_report.jsp">summary report</option>
        </select>
    </div>
    
    <button onclick="openReport()">View Report</button>

</body>
</html>
