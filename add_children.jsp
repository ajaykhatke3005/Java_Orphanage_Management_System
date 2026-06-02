<%@ page import="java.sql.*" %>
<%@ include file="header_admin.jsp" %>
<%@ include file="footer.jsp" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Orphan</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        .form-container {
            max-width: 400px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        label {
            font-weight: bold;
            color: #333;
        }

        input, select {
            padding: 0.8rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
            width: 100%;
        }

        button {
            background-color: rgb(76, 145, 175);
            color: white;
            border: none;
            padding: 0.8rem;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #3e8e41;
        }
    </style>
</head>

<body>
    <div class="form-container">
        <h2>Add Orphan</h2>
        <form action="add_children_process.jsp" method="POST">
            <label for="orphan_name">Orphan Name:</label>
            <input type="text" id="orphan_name" name="orphan_name" placeholder="Enter orphan's name" required>

            <label for="birthdate">Birthdate:</label>
            <input type="date" id="birthdate" name="birthdate" required>

            <label for="birthplace">Birthplace:</label>
            <input type="text" id="birthplace" name="birthplace" placeholder="Enter birthplace">

            <label for="gender">Gender:</label>
            <select id="gender" name="gender" required>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>

            <label for="guardian_name">Guardian Name:</label>
            <input type="text" id="guardian_name" name="guardian_name" placeholder="Enter guardian's name">

            <button type="submit">Add Orphan</button>
        </form>
    </div>
</body>

</html>
