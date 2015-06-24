<?php
$username = "demo";
$password = "password";
$hostname = "dbserver"; 
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
    .connection {
      color: rgb(65, 74, 81);
      display: block;
      font-family: brandon-grotesque, 'Brandon Grotesque', 'Helvetica Neue', Helvetica, Arial, sans-serif;
      font-size: 34px;
      font-weight: bold;
      height: 48px;
      line-height: 48.4000015258789px;
      margin-bottom: 15px;
      width:800px; margin:0 auto;
      text-align: center;
    }
  </style>
</head>
<body>
<div class="connection">
<?php

  $dbhandle = mysql_connect($hostname, $username, $password) 
  or die("Unable to connect to MySQL");
  echo "Connected to MySQL<br>";
?>
</div>
</body>
</html>