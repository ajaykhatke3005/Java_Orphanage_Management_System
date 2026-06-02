<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<% 
    // Database connection details
    String jdbcURL = "jdbc:mysql:///Orphanage_Management_Java";
    String dbUser = "root";
    String dbPassword = "";
    
    // Getting user input
    String username = request.getParameter("username").trim();
    String password = request.getParameter("password").trim();
    String confirmPassword = request.getParameter("confirm_password").trim();
    String type = request.getParameter("type").trim();

    // Validate if fields are empty
    if (username.isEmpty() || password.isEmpty() || confirmPassword.isEmpty() || type.isEmpty()) {
        out.println("<script>alert('Error: All fields are required.'); window.history.back();</script>");
        return;
    }

    // Password length validation
    if (password.length() < 4 || password.length() > 8) {
        out.println("<script>alert('Error: Password must be between 4 and 8 characters.'); window.history.back();</script>");
        return;
    }

    // Password confirmation check
    if (!password.equals(confirmPassword)) {
        out.println("<script>alert('Error: Passwords do not match.'); window.history.back();</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Check if username already exists
        String checkUserSQL = "SELECT COUNT(*) FROM users WHERE username = ?";
        stmt = conn.prepareStatement(checkUserSQL);
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();
        rs.next();
        if (rs.getInt(1) > 0) {
            out.println("<script>alert('Error: Username already exists.'); window.history.back();</script>");
            return;
        }

        // Insert user into database (WITHOUT HASHING)
        String sql = "INSERT INTO users (username, password, type) VALUES (?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, password); // **Plain text password (Not Recommended)**
        stmt.setString(3, type);
        stmt.executeUpdate();

        out.println("<script>alert('Registration successful!'); window.location.href = 'login.jsp';</script>");
    } catch (SQLException | ClassNotFoundException e) {
        out.println("<script>alert('Error: Database error occurred.'); window.history.back();</script>");
        e.printStackTrace();
    } finally {
        if (stmt != null) try { stmt.close(); } catch (Exception ignored) {}
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>
