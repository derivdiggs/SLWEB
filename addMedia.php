<?PHP


 $name = $_POST['name'];
 
 $type = $_POST['type'];
 
 $author = $_POST['author'];
 
 $authorpath = $_POST['authorpath'];
 
 $albumpath = $_POST['albumpath'];
 
 $fromalbum = $_POST['fromalbum'];
 
 $albumpath = $_POST['albumpath'];
 
 $upath = $_POST['upath'];
 
 $thumb = $_POST['thumb'];
 
 $full = $_POST['full'];
 
 $rotation = $_POST['rotation'];
 
 $tags = $_POST['tags'];
 
 $rating = $_POST['rating'];
 
 $license = $_POST['license'];
 
 $price = $_POST['price'];
 
 $quality = $_POST['quality'];
 
 $size = $_POST['size'];
 
 $date = $_POST['date'];
 

$link = mysql_connect("68.178.140.39", "MyDBderivdiggs","veredAUM@1");
mysql_select_db("MyDBderivdiggs");



//$sql = 'INSERT INTO `all_media` (`id`, `name`, `type`, `author`, `authorpath`, `fromalbum`, `albumpath`, `upath`, `thumb`, `full`, `rotation`, `tags`, `rating`, `license`, `price`, `quality`, `size`) VALUES (\'\',"'.$name.'", "'.$type.'", "'.$author.'", "'.$authorpath.'", "'.$fromalbum.'", "'.$albumpath.'", "'.$upath.'", "'.$thumb.'", "'.$full.'", "'.$rotation.'", "'.$tags.'", "'.$rating.'", "'.$license.'", "'.$price.'", "'.$quality.'", "'.$size.'")';

//$sql = 'INSERT INTO `MyDBderivdiggs`.`all_media` (`id`, `name`, `type`, `author`, `authorpath`, `fromalbum`, `albumpath`, `upath`, `thumb`, `full`, `rotation`, `tags`, `rating`, `license`, `price`, `quality`, `size`) VALUES (\'5\', \'xname\', \'xtype\', \'xauthor\', \'xauthorpath\', \'xfromalbum\', \'xalbumpath\', \'xupath\', \'xthumb\', \'xfull\', \'0\', \'xtags, xtags1, xtags2\', \'1\', \'xlicense\', \'1\', \'10\', \'xsize\');'; 


$sql = 'INSERT INTO `all_media` (`id`, `name`, `type`, `author`, `authorpath`, `fromalbum`, `albumpath`, `upath`, `thumb`, `full`, `rotation`, `tags`, `rating`, `license`, `price`, `quality`, `size`) VALUES (\'\',"'.$name.'", "'.$type.'", "'.$author.'", "'.$authorpath.'", "'.$fromalbum.'", "'.$albumpath.'", "'.$upath.'", "'.$thumb.'", "'.$full.'", "'.$rotation.'", "'.$tags.'", "'.$rating.'", "'.$license.'", "'.$price.'", "'.$quality.'", "'.$size.'");';


mysql_query($sql);

echo "Added";

mysql_close($link);

?>