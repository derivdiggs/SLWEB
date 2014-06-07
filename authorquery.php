<?PHP
$author = $_REQUEST['author'] ;
//$author = "derev_diggs";

$link = mysql_connect("68.178.140.39", "MyDBderivdiggs","veredAUM@1");
mysql_select_db("MyDBderivdiggs");

//$query = 'SELECT * FROM `all_media` WHERE 1 LIMIT 0, 200';


//$query = 'SELECT * FROM all_media WHERE author= "'.$author.'"';

//$sql = 'SELECT * FROM `user_preferences` WHERE `username` = "'.$user.'" LIMIT 0, 30 '; 
$query = 'SELECT * FROM `all_media` WHERE `author`= "'.$author.'" LIMIT 0, 200';

//$query = 'SELECT * FROM `all_media` WHERE author= "derev_diggs"';


$results = mysql_query($query);

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
echo "<program>\n";
echo "<album>\n";

while($line = mysql_fetch_assoc($results))
{
	echo"<media id= '" . $line["id"] . "' name='" . $line["name"] . "' type='" . $line["type"] . "' >\n";
	echo"<author>" . $line["author"] . "</author>\n";
	echo"<authorpath>" . $line["authorpath"] . "</authorpath>\n";
	echo"<fromalbum>" . $line["fromalbum"] . "</fromalbum>\n";
	echo"<albumpath>" . $line["albumpath"] . "</albumpath>\n";
	echo"<upath>" . $line["upath"] . "</upath>\n";
	echo"<thumb>" . $line["thumb"] . "</thumb>\n";
	echo"<full>" . $line["full"] . "</full>\n";
	echo"<rotation>" . $line["rotation"] . "</rotation>\n";
	echo"<tags>" . $line["tags"] . "</tags>\n";
	echo"<rating>" . $line["rating"] . "</rating>\n";
	echo"<license>" . $line["license"] . "</license>\n";
	echo"<price>" . $line["price"] . "</price>\n";
	echo"<quality>" . $line["quality"] . "</quality>\n";
	echo"<size>" . $line["size"] . "</size>\n";
	echo"<date>" . $line["date"] . "</date>\n";
	
	echo"</media>\n";
	
}

echo "</album>\n";
echo "</program>";

mysql_close($link);

?>