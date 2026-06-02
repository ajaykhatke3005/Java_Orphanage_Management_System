<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box; 
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            background-image: url('image4.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: rgb(76, 145, 175);
            color: white;
            padding: 1rem;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar .brand {
            flex: 1;
            font-size: 1.5rem;
            font-weight: bold;
            text-align: left;
        }

        .navbar ul {
            list-style: none;
            display: flex;
            gap: 1rem;
            flex: 1;
            justify-content: center;
        }

        .navbar ul li {
            position: relative;
        }

        .navbar ul li a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .navbar ul li a:hover {
            background-color: rgb(93, 96, 93);
        }

        .dropdown {
            position: absolute;
            top: 100%;
            left: 0;
            background-color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: none;
            flex-direction: column;
            min-width: 150px;
            border-radius: 5px;
            overflow: hidden;
            z-index: 1000;
        }

        .dropdown a {
            color: black;
            padding: 0.5rem 1rem;
            text-decoration: none;
            font-size: 0.95rem;
            background-color: rgb(86, 133, 129);
        }

        .dropdown a:hover {
            background-color: rgb(76, 145, 175);
        }

        .navbar ul li:hover .dropdown {
            display: flex;
        }

        .content {
            padding: 2rem;
        }

        .form-container {
            margin-bottom: 2rem;
            padding: 2rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .form-container h2 {
            margin-bottom: 1rem;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        input,
        select {
            padding: 0.8rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 0.8rem;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
        }

        button:hover {
            background-color: #3e8e41;
        }
    </style>
</head>

<body>
    <header>
        <nav class="navbar">
            <div class="brand">Client Dashboard</div>
            <ul>
                <!-- <li><a href="c_view_child.jsp">Children Information</a></li> -->
                <li><a href="adopter_form.jsp">Adopter Form</a></li>
                <li><a href="client_status.jsp">Request Status</a></li>
            </ul>
        </nav>
    </header>
</body>

<jsp:include page="footer.jsp" />
</html>
