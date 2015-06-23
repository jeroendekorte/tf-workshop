<?php
$username = "demo";
$password = "password";
$hostname = ""; 

//connection to the database
$dbhandle = mysql_connect($hostname, $username, $password) 
  or die("Unable to connect to MySQL");
echo "Connected to MySQL<br>";
?>

<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width">

  <title>DevOpsDays Amsterdam - Terraform Workshop</title>
  <style type="text/css">
    html { 
       width:100%; 
       height:100%; 
       background:url(dod-amsterdam.png) center center no-repeat;
    }
  </style>
</head>
<body>
</body>
</html>