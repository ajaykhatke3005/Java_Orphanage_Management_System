<%@ page import="java.sql.*" %>
<%
    String host = "localhost";
    String dbname = "Orphanage_Management_Java";
    String user = "root";
    String password = "";

    Connection conn = null;
    PreparedStatement stmt = null;
    PreparedStatement updateStmt = null;
    ResultSet rs = null;

    String orphan_name = "";
    String birthdate = "";
    String birthplace = "";
    String gender = "";
    String guardian_name = "";
    String id = request.getParameter("id");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://" + host + ":3306/" + dbname + "?useSSL=false&allowPublicKeyRetrieval=true", user, password);

        if (id == null || id.trim().isEmpty()) {
            out.println("<script>alert('Invalid orphan ID.'); window.history.back();</script>");
            return;
        }

        // Handle form submission (Update the record)
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            orphan_name = request.getParameter("orphan_name").trim();
            birthdate = request.getParameter("birthdate");
            birthplace = request.getParameter("birthplace").trim();
            gender = request.getParameter("gender");
            guardian_name = request.getParameter("guardian_name").trim();

            String updateSql = "UPDATE orphans SET orphan_name = ?, birthdate = ?, birthplace = ?, gender = ?, guardian_name = ? WHERE orphan_id = ?";
            updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setString(1, orphan_name);
            updateStmt.setString(2, birthdate);
            updateStmt.setString(3, birthplace);
            updateStmt.setString(4, gender);
            updateStmt.setString(5, guardian_name);
            updateStmt.setString(6, id);

            int rowsUpdated = updateStmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("child_list.jsp"); // Redirect to the orphan list page
                return;
            } else {
                out.println("<script>alert('Error: Could not update the orphan record.'); window.history.back();</script>");
            }
        }

        // Fetch existing orphan details
        String sql = "SELECT * FROM orphans WHERE orphan_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, id);
        rs = stmt.executeQuery();

        if (rs.next()) {
            orphan_name = rs.getString("orphan_name");
            birthdate = rs.getString("birthdate");
            birthplace = rs.getString("birthplace");
            gender = rs.getString("gender");
            guardian_name = rs.getString("guardian_name");
        } else {
            out.println("<script>alert('Orphan not found.'); window.history.back();</script>");
            return;
        }

    } catch (Exception e) {
        e.printStackTrace(); // Logs error in the server logs
        String errorMessage = e.getMessage().replace("'", "\\'"); // Escapes single quotes
        out.println("<script>alert('Database connection failed: " + errorMessage + "'); window.history.back();</script>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (stmt != null) stmt.close(); } catch (SQLException ignored) {}
        try { if (updateStmt != null) updateStmt.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Orphan</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
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
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-top: 10px;
            font-weight: bold;
        }
        input, select {
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
        }
        button {
            margin-top: 15px;
            padding: 10px;
            border: none;
            background-color: #4c91af;
            color: white;
            cursor: pointer;
            border-radius: 5px;
            font-size: 1rem;
        }
        button:hover {
            background-color: #3a728f;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Orphan Details</h2>
        <form method="post">
            <label>Name:</label>
            <input type="text" name="orphan_name" value="<%= orphan_name != null ? orphan_name : "" %>" required>

            <label>Birthdate:</label>
            <input type="date" name="birthdate" value="<%= birthdate != null ? birthdate : "" %>" required>

            <label>Birthplace:</label>
            <input type="text" name="birthplace" value="<%= birthplace != null ? birthplace : "" %>">

            <label>Gender:</label>
            <select name="gender" required>
                <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
                <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female</option>
                <option value="Other" <%= "Other".equals(gender) ? "selected" : "" %>>Other</option>
            </select>

            <label>Guardian Name:</label>
            <input type="text" name="guardian_name" value="<%= guardian_name != null ? guardian_name : "" %>">

            <button type="submit">Update</button>
        </form>
    </div>
</body>
</html>
