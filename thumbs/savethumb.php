<?PHP
if ( isset( $_POST["filename"] ) && isset( $_POST["img"] )  )
{
	$filename = $_POST["filename"]; // get the filename
	$img = base64_decode($_POST["img"]); // get bytearray

	$fp = fopen( $filename, 'w+' ); // create the file for writing

	fwrite( $fp, $img ); // create the image

	fclose( $fp );
	
	echo "Image saved.";
}
else
{
	echo "Error saving image.";
}
?>