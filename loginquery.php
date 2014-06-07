<?PHP
$p = $_REQUEST['pass'];
$l = $_REQUEST['user'];

$link = mysql_connect("68.178.140.39", "MyDBderivdiggs","veredAUM@1");
mysql_select_db("MyDBderivdiggs");

$query = 'SELECT username FROM `user_log` WHERE username= "'.$l.'" and password= "'.$p.'"';

$r = mysql_query($query);


if(!$r) 
{
	$err=mysql_error();
	print $err;
	exit();
}

if(mysql_affected_rows()==0)
{
	echo "fail";
	exit();
}
else
{
	echo "pass";
	exit();
}

mysql_close($link);

?>