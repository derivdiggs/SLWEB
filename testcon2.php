<?php

$user = $_REQUEST['user'];

$link = mysql_connect("68.178.140.39", "MyDBderivdiggs", "veredAUM@1") or die(mysql_error());
echo "v2 Connected to MySQL<br />";
mysql_select_db("MyDBderivdiggs") or die("Cannot connect to DB!");
echo "Connected to Database<br />";

//echo "$user";

// Get a specific result from the "example" table
$result = mysql_query("SELECT * FROM user_preferences
 WHERE username='$user'") or die(mysql_error());  

// get the first (and hopefully only) entry from the result
$row = mysql_fetch_array( $result );
// Print out the contents of each row into a table 
echo $row['username']." - ".$row['firstname'];
mysql_close($link);
?>
