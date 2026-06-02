<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Processing Adoption Form</title>
    <script>
        function validateForm() {
            let fullName = document.forms["adoptionForm"]["fullName"].value.trim();
            let email = document.forms["adoptionForm"]["email"].value.trim();
            let phone = document.forms["adoptionForm"]["phone"].value.trim();
            let age = document.forms["adoptionForm"]["age"].value.trim();
            let income = document.forms["adoptionForm"]["income"].value.trim();
            let reason = document.forms["adoptionForm"]["reason"].value.trim();

            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            let phonePattern = /^[0-9]{10}$/;
            let agePattern = /^[1-9][0-9]?$/;  // Age must be between 1 and 99
            let incomePattern = /^[1-9][0-9]*$/;  // Income must be a positive number

            if (fullName === "" || email === "" || phone === "" || age === "" || income === "" || reason === "") {
                alert("All fields are required!");
                return false;
            }
            if (!email.match(emailPattern)) {
                alert("Invalid email format!");
                return false;
            }
            if (!phone.match(phonePattern)) {
                alert("Phone number must be 10 digits!");
                return false;
            }
            if (!age.match(agePattern) || parseInt(age) < 18 || parseInt(age) > 35) {
                alert("Age must be between 18 and 35!");
                return false;
            }
            if (!income.match(incomePattern)) {
                alert("Income must be a valid positive number!");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <form name="adoptionForm" action="process_adoption.jsp" method="POST" onsubmit="return validateForm();">
        <input type="text" name="fullName" placeholder="Full Name" required><br>
        <input type="email" name="email" placeholder="Email" required><br>
        <input type="text" name="phone" placeholder="Phone (10 digits)" required><br>
        <input type="number" name="age" placeholder="Age (18 - 35)" min="18" max="35" required><br>
        <input type="text" name="gender" placeholder="Gender" required><br>
        <input type="text" name="address" placeholder="Address" required><br>
        <input type="text" name="occupation" placeholder="Occupation" required><br>
        <input type="number" name="income" placeholder="Monthly Income" required><br>
        <input type="text" name="maritalstatus" placeholder="Marital Status" required><br>
        <textarea name="reason" placeholder="Why do you want to adopt?" required></textarea><br>
        <button type="submit">Submit</button>
    </form>

    <%
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String age = request.getParameter("age");
    String gender = request.getParameter("gender");
    String address = request.getParameter("address");
    String occupation = request.getParameter("occupation");
    String income = request.getParameter("income");
    String maritalstatus = request.getParameter("maritalstatus");
    String reason = request.getParameter("reason");

    if (fullName != null && email != null && phone != null) {
        fullName = fullName.trim();
        email = email.trim();
        phone = phone.trim();
        age = age.trim();
        gender = gender.trim();
        address = address.trim();
        occupation = occupation.trim();
        income = income.trim();
        maritalstatus = maritalstatus.trim();
        reason = reason.trim();

        if (fullName.isEmpty() || email.isEmpty() || phone.isEmpty() || age.isEmpty() || income.isEmpty() || reason.isEmpty()) {
            out.println("<h3 style='color:red;'>All fields are required!</h3>");
        } else if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            out.println("<h3 style='color:red;'>Invalid email format!</h3>");
        } else if (!phone.matches("^[0-9]{10}$")) {
            out.println("<h3 style='color:red;'>Phone number must be 10 digits!</h3>");
        } else if (!age.matches("^[1-9][0-9]?$") || Integer.parseInt(age) < 18 || Integer.parseInt(age) > 35) {
            out.println("<h3 style='color:red;'>Age must be between 18 and 35!</h3>");
        } else if (!income.matches("^[1-9][0-9]*$")) {
            out.println("<h3 style='color:red;'>Income must be a valid positive number!</h3>");
        } else {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Orphanage_Management_Java", "root", "");

                String sql = "INSERT INTO adopters (fullName, email, phone, age, gender, address, occupation, income, maritalstatus, reason) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstmt.setString(1, fullName);
                pstmt.setString(2, email);
                pstmt.setString(3, phone);
                pstmt.setString(4, age);
                pstmt.setString(5, gender);
                pstmt.setString(6, address);
                pstmt.setString(7, occupation);
                pstmt.setString(8, income);
                pstmt.setString(9, maritalstatus);
                pstmt.setString(10, reason);

                int rowsInserted = pstmt.executeUpdate();
                
                if (rowsInserted > 0) {
                    rs = pstmt.getGeneratedKeys();
                    if (rs.next()) {
                        int adopterId = rs.getInt(1);
                        response.sendRedirect("adopter_documents.jsp?adopterId=" + adopterId);
                    }
                } else {
                    out.println("<h3 style='color:red;'>Failed to submit application. Please try again.</h3>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        }
    }
    %>
</body>
</html>
