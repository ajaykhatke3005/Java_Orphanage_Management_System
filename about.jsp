<%@ include file="header_index.jsp" %>
<%@ include file="footer.jsp" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Orphanage Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1e1ebf;
            margin: 0;
            padding: 0;
        }
 
        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background: rgba(255, 255, 255, 0);
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            color: #333;
        }

        p {
            font-size: 1.1rem;
            color: #090909;
            line-height: 1.6;
        }

        .welcome {
            margin-bottom: 1rem;
            font-weight: bold;
            color: #007BFF;
        }
    </style>
</head>
<body>
    <div class="container">
        <%
            String user = (String) session.getAttribute("user");
            if(user != null){
        %>
            <p class="welcome">Welcome, <%= user %> 👋</p>
        <%
            }
        %>

        <h1>About Our Orphanage Management System</h1>
        <p>Our Orphanage Management System is designed to streamline the process of managing orphanages, tracking children, managing adoptions, and facilitating donations efficiently. The system aims to bring transparency and ease of use for administrators, donors, and adopters.</p>
        
        <h2>Our Mission</h2>
        <p>We strive to provide a better future for orphans by ensuring they receive proper care, education, and opportunities. Our platform connects kind-hearted individuals with children in need, making the adoption and donation processes simple and effective.</p>
    </div>
</body>
</html>
