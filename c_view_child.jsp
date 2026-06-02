<%@ page import="java.sql.*" %>

<%
    String host = "localhost";
    String dbname = "Orphanage_Management_Java";
    String user = "root";
    String password = "";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://" + host + ":3306/" + dbname + "?useSSL=false&allowPublicKeyRetrieval=true", user, password);

        String sql = "SELECT o.orphan_id, o.orphan_name, o.birthdate, o.birthplace, o.gender, o.guardian_name " +
                     "FROM orphans o " +
                     "LEFT JOIN adopters a ON o.orphan_id = a.orphan_id " +
                     "WHERE a.orphan_id IS NULL";
        
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unadopted Children</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 2rem auto;
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }
        th {
            background-color: #4c91af;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Children Available for Adoption</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Birthdate</th>
                <th>Birthplace</th>
                <th>Gender</th>
                <th>Guardian</th>
            </tr>
            <%
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
            %>
            <tr>
                <td><%= rs.getInt("orphan_id") %></td>
                <td><%= rs.getString("orphan_name") %></td>
                <td><%= rs.getDate("birthdate") %></td>
                <td><%= rs.getString("birthplace") %></td>
                <td><%= rs.getString("gender") %></td>
                <td><%= rs.getString("guardian_name") %></td>
            </tr>
            <%
            }
            if (!hasData) {
            %>
            <tr>
                <td colspan="6" style="color:red; text-align:center;">No unadopted children found.</td>
            </tr>
            <%
            }
            %>
        </table>
    </div>
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace(); 
        out.println("<p style='color:red; text-align:center;'>Error fetching data: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (stmt != null) stmt.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }
%>
