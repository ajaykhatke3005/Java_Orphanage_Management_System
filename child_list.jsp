<%@ page import="java.sql.*" %>

<%
    // Database connection settings
    String host = "localhost";
    String dbName = "Orphanage_Management_Java";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String searchQuery = "";
    String search = request.getParameter("search");

    if (search != null && !search.trim().isEmpty()) {
        searchQuery = "WHERE orphan_name LIKE ? OR birthplace LIKE ? OR gender LIKE ? OR guardian_name LIKE ?";
    }

    try {
        // Load MySQL Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection("jdbc:mysql://" + host + ":3306/" + dbName, dbUser, dbPassword);

        // Fetch orphans with optional search
        String query = "SELECT * FROM orphans " + searchQuery + " ORDER BY orphan_id ASC";
        stmt = conn.prepareStatement(query);

        if (!searchQuery.isEmpty()) {
            String searchParam = "%" + search + "%";
            for (int i = 1; i <= 4; i++) {
                stmt.setString(i, searchParam);
            }
        }

        rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orphans List</title>
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
        .search-box {
            text-align: center;
            margin-bottom: 1rem;
        }
        .search-box input {
            padding: 0.5rem;
            width: 250px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
        }
        .search-box button {
            padding: 0.5rem;
            border: none;
            background-color: #4c91af;
            color: white;
            cursor: pointer;
            border-radius: 5px;
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
        .actions a {
            margin: 0 5px;
            padding: 5px 10px;
            text-decoration: none;
            color: white;
            border-radius: 5px;
        }
        .edit {
            background-color: #f0ad4e;
        }
        .delete {
            background-color: #d9534f;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Orphans List</h2>

        <div class="search-box">
            <form action="" method="GET">
                <input type="text" name="search" placeholder="Search orphan name, birthplace..." value="<%= search != null ? search : "" %>">
                <button type="submit">Search</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Birthdate</th>
                    <th>Birthplace</th>
                    <th>Gender</th>
                    <th>Guardian Name</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                    <tr>
                        <td><%= rs.getInt("orphan_id") %></td>
                        <td><%= rs.getString("orphan_name") %></td>
                        <td><%= rs.getString("birthdate") %></td>
                        <td><%= rs.getString("birthplace") %></td>
                        <td><%= rs.getString("gender") %></td>
                        <td><%= rs.getString("guardian_name") %></td>
                        <td class="actions">
                            <a href="edit_orphan.jsp?id=<%= rs.getInt("orphan_id") %>" class="edit">Edit</a>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
<div class='button-container no-print' style="text-align: center;">
    <button onclick='goHome()'> HOME</button>
    <button onclick='printPage()'> PRINT</button>
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
<%
    } catch (Exception e) {
        out.println("<p style='color:red;'>Database error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
