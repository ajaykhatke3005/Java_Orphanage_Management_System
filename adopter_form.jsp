<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Adoption Form</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.2);
            width: 400px;
            text-align: center;
        }
        h2 {
            color: #333;
            margin-bottom: 15px;
        }
        input, select, textarea {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            margin-top: 10px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .error {
            color: red;
            font-size: 0.9rem;
            margin-top: -5px;
            margin-bottom: 5px;
        }
    </style>

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
            let agePattern = /^[1-9][0-9]?$/;
            let incomePattern = /^[1-9][0-9]*$/;

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

<div class="container">
    <h2>Adoption Form</h2>
    <form name="adoptionForm" action="process_adoption.jsp" method="POST" onsubmit="return validateForm();">
        <input type="text" name="fullName" placeholder="Full Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="text" name="phone" placeholder="Phone (10 digits)" required>
        <input type="number" name="age" placeholder="Age (18 - 35)" min="18" max="35" required>
        <select name="gender" required>
            <option value="">Select Gender</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
        </select>
        <input type="text" name="address" placeholder="Address" required>
        <input type="text" name="occupation" placeholder="Occupation" required>
        <input type="number" name="income" placeholder="Monthly Income" required>
        <select name="maritalstatus" required>
            <option value="">Select Marital Status</option>
            <option value="Married">Married</option>
            <option value="Divorced">Divorced</option>
            <option value="Widowed">Widowed</option>
        </select>
        <textarea name="reason" placeholder="Why do you want to adopt?" rows="3" required></textarea>
        <button type="submit">Submit</button>
    </form>
</div>

</body>
</html>
