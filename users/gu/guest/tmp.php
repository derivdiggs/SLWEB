<?php 
 // The file you are resizing 
 $file = 'your.jpg'; 
 
 //This will set our output to 45% of the original size 
 $size = 0.45; 
 
 // This sets it to a .jpg, but you can change this to png or gif 
 header('Content-type: image/jpeg'); 
 
 // Setting the resize parameters
 list($width, $height) = getimagesize($file); 
 $modwidth = $width * $size; 
 $modheight = $height * $size; 
 
 // Creating the Canvas 
 $tn= imagecreatetruecolor($modwidth, $modheight); 
 $source = imagecreatefromjpeg($file); 
 
 // Resizing our image to fit the canvas 
 imagecopyresized($tn, $source, 0, 0, 0, 0, $modwidth, $modheight, $width, $height); 
 
 // Outputs a jpg image, you could change this to gif or png if needed 
 imagejpeg($tn); 
 ?>