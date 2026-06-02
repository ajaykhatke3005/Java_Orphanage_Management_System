<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String type = request.getParameter("type");

        if (username == null || password == null || type == null || username.isEmpty() || password.isEmpty() || type.isEmpty()) {
            response.sendRedirect("login.jsp?error=missing_fields");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Database connection setup
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Orphanage_Management_Java", "root", "");

            // Query to check user credentials
            String query = "SELECT user_id, username, password, type FROM users WHERE username = ? AND password = ? AND type = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, password);  // Plain text password (Not recommended)
            stmt.setString(3, type);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // **Invalidate old session and create a new one**
                session.invalidate();  // Destroy existing session
                session = request.getSession(true);  // Create a new session

                // Set user session attributes
                session.setAttribute("user_id", rs.getInt("user_id"));
                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("type", rs.getString("type"));

                // Redirect based on user type
                if ("admin".equals(type)) {
                    response.sendRedirect("admin_dashboard.jsp");
                } else {
                    response.sendRedirect("client_dashboard.jsp");
                }
                return;
            } else {
                response.sendRedirect("login.jsp?error=invalid_credentials");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=server_error");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (stmt != null) try { stmt.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    }
%>
