<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header_index.jsp" %>
<%@ include file="footer.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Payment Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .info-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .info-container h2 {
            color: #0e0d0d;
        }
        .info-container p {
            font-size: 1rem;
            color: #080808;
            line-height: 1.6;
        }
        .qr-code {
            margin-top: 1.5rem;
            display: flex;
            justify-content: center;
        }
        .qr-code img {
            max-width: 100%;
            height: 400px;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <div class="info-container">
        <h2>Online Payment Information</h2>
        <p>You can make your donation securely through our online payment system. We accept various payment methods, including credit/debit cards, net banking, and digital wallets.</p>
        <p>To proceed with the online payment, please use the following bank details:</p>
        <p><strong>Bank Name:</strong> ABC Bank</p>
        <p><strong>Account Name:</strong> Orphanage Management Trust</p>
        <p><strong>Account Number:</strong> 1234567890</p>
        <p><strong>IFSC Code:</strong> ABCD0123456</p>
        <p><strong>Branch:</strong> Main Branch, City</p>
        <p>If you have any queries regarding online payments, feel free to contact our support team.</p>
        
        <div class="qr-code">
        <h3 style="text-align: center;">Scan to Pay</h3>
        <img src="QR_SCAN.jpg" alt="QR Code for Payment">
        </div>
    </div>
</body>
</html>

<%@ include file="footer.jsp" %>
