<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #131212;
            color: #cc2609;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
            overflow: hidden;
        }

        .confirmation-message {
            background-color: #0f0f0f;
            padding: 50px;
            border-radius: 12px;
            box-shadow: 0 0 25px rgba(204, 38, 9, 0.5);
            font-size: 24px;
            color: #cc2609;
            animation: fadeIn 1.2s ease-in-out;
            max-width: 700px;
        }

        .skull-logo {
            width: 500px;
            margin-bottom: 20px;
            filter: drop-shadow(0 0 20px rgba(204, 38, 9, 0.6));
            animation: pulse 2.5s infinite ease-in-out;
        }

        .home-button {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 25px;
            font-size: 16px;
            background-color: #cc2609;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .home-button:hover {
            background-color: #ff3920;
            transform: scale(1.05);
        }

        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(-20px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.03); }
        }

        h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        p {
            font-size: 20px;
            letter-spacing: 1px;
        }
    </style>
</head>
<body>

<div class="confirmation-message">
    <img src="OIP.jpg" alt="Skull Logo" class="skull-logo">
    <h1>Confirmed.</h1>
    <p>Your hit is on its way.</p>
    <a href="index.html" class="home-button">← Back to Home</a>
</div>

<%
' Grab form values
fullName       = Request.QueryString("full-name")
state          = Request.QueryString("state")
city           = Request.QueryString("city")
jobSite        = Request.QueryString("job-site")
licensePlate   = Request.QueryString("license-plate")
paymentMethod  = Request.QueryString("payment-method")
contractor     = Request.QueryString("contractor")

' Build SQL command
SQL = "INSERT INTO Orders (FullName, State, City, JobSite, LicensePlate, PaymentMethod, Contractor) " & _
      "VALUES ('" & fullName & "', '" & state & "', '" & city & "', '" & jobSite & "', '" & licensePlate & "', '" & paymentMethod & "', '" & contractor & "')"

' Connect to Azure SQL DB
connString = "Driver={ODBC Driver 18 for SQL Server};Server=tcp:bmis-sql.database.windows.net,1433;Database=Contractors;Uid=Riley;Pwd=30Sept2004!;Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;"

Set conn = Server.CreateObject("ADODB.Connection")
On Error Resume Next
conn.Open connString

' Execute the SQL
conn.Execute SQL

' Error handling
If Err.Number <> 0 Then
    Response.Write("<p style='color: red;'>Error submitting form: " & Err.Description & "</p>")
    Err.Clear
End If

conn.Close
%>

</body>
</html>