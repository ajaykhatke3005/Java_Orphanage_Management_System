<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String dbUrl = "jdbc:mysql://localhost:3306/Orphanage_Management_Java";
    String dbUser = "root";
    String dbPassword = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        stmt = conn.createStatement();
        String sql = "SELECT fullName, email, status FROM adopters";
        rs = stmt.executeQuery(sql);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Adoption Request Status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f9;
            text-align: center;
        }
        .container {
            max-width: 700px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
        }
        .search-box {
            margin-bottom: 15px;
        }
        input[type="text"] {
            width: 80%;
            padding: 8px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        .status-pending {
            color: orange;
            font-weight: bold;
        }
        .status-approved {
            color: green;
            font-weight: bold;
        }
        .status-rejected {
            color: red;
            font-weight: bold;
        }
        .view-children {
            background-color: #28a745;
            color: white;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
        }
        .view-children:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Adoption Request Status</h2>

        <!-- Search Box -->
        <div class="search-box">
            <input type="text" id="searchEmail" placeholder="Search by email..." onkeyup="filterTable()">
        </div>

        <table id="statusTable">
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Status</th>
                <th>See Children</th>
            </tr>
            <% while (rs.next()) { 
                String adopterStatus = rs.getString("status");
            %>
                <tr>
                    <td><%= rs.getString("fullName") %></td>
                    <td class="email"><%= rs.getString("email") %></td>
                    <td class="status-<%= adopterStatus.toLowerCase() %>"><%= adopterStatus %></td>
                    <td>
                        <% if ("Approved".equals(adopterStatus)) { %>
                            <a href="verify_adopter.jsp" class="view-children">View Children</a>
                        <% } else { %>
                            <span style="color: gray;">N/A</span>
                        <% } %>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>

    <script>
        function filterTable() {
            let input = document.getElementById("searchEmail").value.toLowerCase();
            let rows = document.querySelectorAll("#statusTable tr:not(:first-child)");

            rows.forEach(row => {
                let email = row.querySelector(".email").textContent.toLowerCase();
                row.style.display = email.includes(input) ? "" : "none";
            });
        }
    </script>

<%
if (rs != null) rs.close();
if (stmt != null) stmt.close();
if (conn != null) conn.close();
%>

</body>
</html>
