<%@ page import="java.sql.*" %>
<!-- <%@ include file="database.jsp" %> -->

<%
Connection conn = null;
PreparedStatement stmt = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://" + host + "/" + dbname, user, password);
} catch (Exception e) {
    out.println("Database connection failed: " + e.getMessage());
    return;
}

if (request.getMethod().equals("POST")) {
    String orphan_name = request.getParameter("orphan_name").trim();
    String birthdate = request.getParameter("birthdate");
    String birthplace = request.getParameter("birthplace").trim();
    String gender = request.getParameter("gender");
    String guardian_name = request.getParameter("guardian_name").trim();

    try {
        String sql = "INSERT INTO orphans (orphan_name, birthdate, birthplace, gender, guardian_name) VALUES (?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, orphan_name);
        stmt.setString(2, birthdate);
        stmt.setString(3, birthplace);
        stmt.setString(4, gender);
        stmt.setString(5, guardian_name);
        stmt.executeUpdate();
        out.println("<script>alert('Orphan added successfully!'); window.history.back();</script><br>");
    } catch (SQLException e) {
        out.println("Error adding orphan: " + e.getMessage());
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
}
%>
