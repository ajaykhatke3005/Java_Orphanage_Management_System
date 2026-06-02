<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%
    // Get form parameters
    String donor_name = request.getParameter("donor_name");
    String donor_address = request.getParameter("donor_address");
    String donor_city = request.getParameter("donor_city");
    String donor_contact = request.getParameter("donor_contact");
    String donor_email = request.getParameter("donor_email");
    String donation_amount = request.getParameter("donation_amount");
    String donation_date = request.getParameter("donation_date");

    // Validate input
    if (donor_name == null || donor_name.trim().isEmpty() ||
        donor_address == null || donor_address.trim().isEmpty() ||
        donor_city == null || donor_city.trim().isEmpty() ||
        donor_contact == null || !donor_contact.matches("\\d{10}") ||
        donor_email == null || donor_email.trim().isEmpty() ||
        donation_amount == null || donation_amount.trim().isEmpty() ||
        donation_date == null || donation_date.trim().isEmpty()) {
        
        out.println("<script>alert('All fields are required and contact must be 10 digits!'); window.history.back();</script>");
        return;
    }

    // Database details
    String dbURL = "jdbc:mysql://localhost:3306/Orphanage_Management_Java";
    String dbUser = "root";
    String dbPassword = "";

    String query = "INSERT INTO donations (donor_name, donor_address, donor_city, donor_contact, donor_email, donation_amount, donation_date) VALUES (?, ?, ?, ?, ?, ?, ?)";

    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
         PreparedStatement pst = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

        Class.forName("com.mysql.cj.jdbc.Driver");

        pst.setString(1, donor_name);
        pst.setString(2, donor_address);
        pst.setString(3, donor_city);
        pst.setString(4, donor_contact);
        pst.setString(5, donor_email);
        pst.setString(6, donation_amount);
        pst.setString(7, donation_date);

        int result = pst.executeUpdate();
        if (result > 0) {
            ResultSet rs = pst.getGeneratedKeys();
            if (rs.next()) {
                int donationId = rs.getInt(1);
                response.sendRedirect("money_payment.jsp?donationId=" + donationId);
            }
        } else {
            out.println("<script>alert('Error recording donation. Try again.'); window.history.back();</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('Database error: " + e.getMessage() + "'); window.history.back();</script>");
    }
%>
