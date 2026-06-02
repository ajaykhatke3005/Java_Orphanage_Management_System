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
    Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL driver
    String url = "jdbc:mysql://" + host + ":3306/" + dbname;
    conn = DriverManager.getConnection(url, user, password);

    String startDate = request.getParameter("start_date");
    String endDate = request.getParameter("end_date");

    if (startDate != null && endDate != null) {
        out.println("<h3>Donations from " + startDate + " to " + endDate + "</h3>");
        out.println("<table><tr><th>Donor Name</th><th>Donation Type</th><th>Donation Date</th></tr>");
        
        stmt = conn.prepareStatement("SELECT d.donor_name, dn.donation_type, dn.created_at FROM donors d JOIN donations dn ON d.donor_id = dn.donor_id WHERE dn.created_at BETWEEN ? AND ?");
        stmt.setString(1, startDate);
        stmt.setString(2, endDate);
        rs = stmt.executeQuery();

        while (rs.next()) {
            out.println("<tr><td>" + rs.getString("donor_name") + "</td><td>" + rs.getString("donation_type") + "</td><td>" + rs.getDate("created_at") + "</td></tr>");
        }
        out.println("</table>");
    }
} catch (SQLException e) {
    out.println("<p style='color: red;'>Database error: " + e.getMessage() + "</p>");
} finally {
    if (rs != null) try { rs.close(); } catch (Exception ignored) {}
    if (stmt != null) try { stmt.close(); } catch (Exception ignored) {}
    if (conn != null) try { conn.close(); } catch (Exception ignored) {}
}
%>
