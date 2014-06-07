<?PHP

$user = $_REQUEST['user'];

$link = mysql_connect("68.178.140.39", "MyDBderivdiggs","veredAUM@1") or die("Cannot connect to DB!");
mysql_select_db("MyDBderivdiggs") or die("Cannot connect to DB!");

$sql = 'SELECT * FROM `user_preferences` WHERE `username` = "'.$user.'" LIMIT 0, 30 '; 
$results = mysql_query($sql);

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
echo "<program>\n";
echo "<users>\n";
echo "<user>\n";

while($line = mysql_fetch_assoc($results))
{
	echo"<username>" . $line["username"] . "</username>\n";
	echo"<firstname>" . $line["firstname"] . "</firstname>\n";
	echo"<lastname>" . $line["lastname"] . "</lastname>\n";
	echo"<upath>" . $line["upath"] . "</upath>\n";
	echo"<shortupath>" . $line["shortupath"] . "</shortupath>\n";
	echo"<gridsize>" . $line["gridsize"] . "</gridsize>\n";
	echo"<profilepic>" . $line["profilepic"] . "</profilepic>\n";
	echo"<lasttab>" . $line["lasttab"] . "</lasttab>\n";
	echo"<uploads>" . $line["uploads"] . "</uploads>\n";
	echo"<downloads>" . $line["downloads"] . "</downloads>\n";
	echo"<following>" . $line["following"] . "</following>\n";
}

echo "</user>\n";
echo "</users>\n";
echo "</program>";

mysql_close($link);

?>