<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donor Information</title>
    <style>
        .form-container {
            width: 50%;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.2);
            background-color: #f9f9f9;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
        }
        button {
            margin-top: 15px;
            padding: 10px 15px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
        }
        button:hover {
            background-color: #218838;
        }
        .error {
            color: red;
            font-size: 0.9rem;
            display: none;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Donor Information</h2>
        <form name="donorForm" action="money_donor_process.jsp" method="POST" onsubmit="return validateForm()">
            <label>Full Name:</label>
            <input type="text" name="donor_name" id="donor_name" required>
            <p class="error" id="nameError">Please enter a valid name (letters only, min 3 characters).</p>

            <label>Address:</label>
            <input type="text" name="donor_address" id="donor_address" required>
            <p class="error" id="addressError">Address must be at least 3 characters long.</p>

            <label>City:</label>
            <input type="text" name="donor_city" id="donor_city" required>
            <p class="error" id="cityError">City name must be at least 3 characters long.</p>

            <label>Contact (10 digits):</label>
            <input type="text" name="donor_contact" id="donor_contact" pattern="\d{10}" required>
            <p class="error" id="contactError">Contact number must be exactly 10 digits.</p>

            <label>Email:</label>
            <input type="email" name="donor_email" id="donor_email" required>
            <p class="error" id="emailError">Please enter a valid email address.</p>

            <h2>Donation Details</h2>

            <label>Donation Amount (₹):</label>
            <input type="number" name="donation_amount" id="donation_amount" min="10" required>
            <p class="error" id="amountError">Minimum donation amount is ₹10.</p>

            <label>Donation Date:</label>
            <input type="date" name="donation_date" id="donation_date" required>
            <p class="error" id="dateError">Donation date cannot be in the future.</p>

            <button type="submit">Proceed to Payment</button>
        </form>
    </div>

    <script>
        function validateForm() {
            let valid = true;

            // Name validation (only letters and at least 3 characters)
            let name = document.getElementById("donor_name").value.trim();
            let nameRegex = /^[A-Za-z\s]{3,}$/;
            if (!nameRegex.test(name)) {
                document.getElementById("nameError").style.display = "block";
                valid = false;
            } else {
                document.getElementById("nameError").style.display = "none";
            }

            // Address validation (at least 3 characters)
            let address = document.getElementById("donor_address").value.trim();
            if (address.length < 3) {
                document.getElementById("addressError").style.display = "block";
                valid = false;
            } else {
                document.getElementById("addressError").style.display = "none";
            }

            // City validation (at least 3 characters)
            let city = document.getElementById("donor_city").value.trim();
            if (city.length < 3) {
                document.getElementById("cityError").style.display = "block";
                valid = false;
            } else {
                document.getElementById("cityError").style.display = "none";
            }

            // Contact validation (exactly 10 digits)
            let contact = document.getElementById("donor_contact").value.trim();
            let contactRegex = /^\d{10}$/;
            if (!contactRegex.test(contact)) {
                document.getElementById("contactError").style.display = "block";
                valid = false;
            } else {
                document.getElementById("contactError").style.display = "none";
            }

            // Email validation (valid format)
            let email = document.getElementById("donor_email").value.trim();
            let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                document.getElementById("emailError").style.display = "block";
                valid = false;
            } else {
                document.getElementById("emailError").style.display = "none";
            }

            // Donation Amount validation (minimum ₹10)
            let amount = document.getElementById("donation_amount").value;
            if (amount < 10) {
                document.getElementById("amountError").style.display = "block";
                valid = false;
            } else {
                document.getElementById("amountError").style.display = "none";
            }

            // Donation Date validation (should not be in the future)
            let donationDate = document.getElementById("donation_date").value;
            let today = new Date().toISOString().split("T")[0];
            if (donationDate > today) {
                document.getElementById("dateError").style.display = "block";
                valid = false;
            } else {
                document.getElementById("dateError").style.display = "none";
            }

            return valid;
        }
    </script>
</body>
</html>
