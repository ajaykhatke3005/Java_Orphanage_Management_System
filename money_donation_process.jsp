<%@ page import="java.sql.*" %>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*" %>

<%
if (request.getMethod().equalsIgnoreCase("POST")) {
    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Orphanage_Management_Java", "root", "")) {
        
        String donorId = request.getParameter("donorId");
        String donationAmount = request.getParameter("donation_amount");
        String donationDate = request.getParameter("donation_date");

        if (donorId == null || donorId.isEmpty()) {
            out.println("<script>alert('Error: Donor ID is missing! Returning to donor form.'); window.location.href='money_donor_form.jsp';</script>");
            return;
        }
        if (donationAmount == null || donationAmount.isEmpty() || donationDate == null || donationDate.isEmpty()) {
            out.println("<script>alert('Error: All fields are required.'); window.history.back();</script>");
            return;
        }
        <%


        // Insert donation details into database
        String sql = "INSERT INTO donations (donor_id, donation_type, donation_date, amount, status) VALUES (?, 'money', ?, ?, 'Pending')";
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        stmt.setInt(1, Integer.parseInt(donorId));
        stmt.setString(2, donationDate);
        stmt.setDouble(3, Double.parseDouble(donationAmount));

        int rowsInserted = stmt.executeUpdate();
        ResultSet generatedKeys = stmt.getGeneratedKeys();
        int donationId = 0;
        if (generatedKeys.next()) {
            donationId = generatedKeys.getInt(1);
        }

        if (rowsInserted > 0) {
            // ✅ Redirect to money_payment.jsp with donationId
            response.sendRedirect("money_payment.jsp?donationId=" + donationId);
            return;
        } else {
            out.println("<script>alert('Error: Could not record donation.'); window.history.back();</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('Database Error: " + e.getMessage() + "'); window.history.back();</script>");
    }
}
%>
