<%@ page import="java.sql.*" %>
<%@ include file="header_index.jsp" %>
<%@ include file="footer.jsp" %>

<%
    // Database credentials
    String host = "localhost";
    String dbname = "Orphanage_Management_Java";
    String user = "root";
    String password = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // Get selected age range from request
    String selectedRange = request.getParameter("ageRange");
    int minAge = 0, maxAge = 100;

    if (selectedRange != null) {
        switch (selectedRange) {
            case "0-5": minAge = 0; maxAge = 5; break;
            case "6-10": minAge = 6; maxAge = 10; break;
            case "11-15": minAge = 11; maxAge = 15; break;
            case "16-18": minAge = 16; maxAge = 18; break;
            case "19+": minAge = 19; maxAge = 100; break;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Orphans</title>
    <style>
        /* General Styling */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            max-width: 1000px;
            margin: 2rem auto;
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
        }

        /* Form Styling */
        .filter-form {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        select {
            padding: 10px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            background: white;
            cursor: pointer;
        }
        button {
            padding: 10px 15px;
            background-color: #4c91af;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        button:hover {
            background-color: #35718a;
        }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #4c91af;
            color: white;
            font-size: 1rem;
        }
        td {
            background-color: #f9f9f9;
        }
        tr:nth-child(even) {
            background-color: #eef6fa;
        }
        tr:hover {
            background-color: #dceef5;
            transition: background 0.3s ease;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .filter-form {
                flex-direction: column;
                align-items: center;
            }
            select, button {
                width: 100%;
                max-width: 300px;
            }
            th, td {
                padding: 10px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Orphan Information</h2>

        <!-- Age Filter Form -->
        <form method="GET" action="view_children.jsp" class="filter-form">
            <select name="ageRange">
                <option value="" <%= (selectedRange == null) ? "selected" : "" %>>All Ages</option>
                <option value="0-5" <%= "0-5".equals(selectedRange) ? "selected" : "" %>>0-5 Years</option>
                <option value="6-10" <%= "6-10".equals(selectedRange) ? "selected" : "" %>>6-10 Years</option>
                <option value="11-15" <%= "11-15".equals(selectedRange) ? "selected" : "" %>>11-15 Years</option>
                <option value="16-18" <%= "16-18".equals(selectedRange) ? "selected" : "" %>>16-18 Years</option>
                <option value="19+" <%= "19+".equals(selectedRange) ? "selected" : "" %>>19+ Years</option>
            </select>
            <button type="submit">Filter</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Birthdate</th>
                    <th>Age</th>
                    <th>Birthplace</th>
                    <th>Gender</th>
                    <th>Guardian Name</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://" + host + ":3306/" + dbname + "?useSSL=false&allowPublicKeyRetrieval=true", user, password);

                        // SQL query to filter by selected age range
                        String query = "SELECT orphan_id, orphan_name, birthdate, birthplace, gender, guardian_name, " +
                                       "TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) AS age " +
                                       "FROM orphans WHERE TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) BETWEEN ? AND ? " +
                                       "ORDER BY orphan_id ASC";

                        pstmt = conn.prepareStatement(query);
                        pstmt.setInt(1, minAge);
                        pstmt.setInt(2, maxAge);
                        rs = pstmt.executeQuery();

                        if (!rs.isBeforeFirst()) { // No records found
                %>
                    <tr>
                        <td colspan="7" style="color: red; text-align: center;">No orphan records found.</td>
                    </tr>
                <%
                        } else {
                            while (rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getInt("orphan_id") %></td>
                        <td><%= rs.getString("orphan_name") %></td>
                        <td><%= rs.getDate("birthdate") %></td>
                        <td><%= rs.getInt("age") %> years</td>
                        <td><%= rs.getString("birthplace") %></td>
                        <td><%= rs.getString("gender") %></td>
                        <td><%= rs.getString("guardian_name") %></td>
                    </tr>
                <%
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
                        try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
                        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
