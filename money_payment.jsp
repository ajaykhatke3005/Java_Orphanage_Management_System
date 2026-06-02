<%@ page import="java.sql.*" %>

<%
String donationId = request.getParameter("donationId");
if (donationId == null) {
    out.println("<script>alert('Error: Invalid donation ID.'); window.location.href='index.jsp';</script>");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Payment</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; margin: 0; padding: 0; text-align: center; }
        .container { max-width: 500px; margin: 2rem auto; padding: 2rem; background: white; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); }
        h2 { color: #333; }
        p { font-size: 1.1rem; }
        img { width: 250px; margin: 10px 0; }
        button { background-color: rgb(76, 145, 175); color: white; border: none; padding: 0.8rem; border-radius: 5px; cursor: pointer; }
        button:hover { background-color: #3e8e41; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Online Payment Details</h2>
        <p><strong>Account Name:</strong> Orphanage Management Trust</p>
        <p><strong>Account Number:</strong> 60209085482</p>
        <p><strong>IFSC Code:</strong> MAHB0001830</p>
        <p><strong>Branch:</strong> Main Branch, Kurkumbh</p>

        <h3>Scan to Pay</h3>
        <img src="QR_SCAN.jpg" alt="QR Code for Payment">

        <form action="index.jsp" method="POST">
            <input type="hidden" name="donationId" value="<%= donationId %>">
            <button type="submit">I Have Completed the Payment</button>
        </form>
    </div>
</body>
</html>
