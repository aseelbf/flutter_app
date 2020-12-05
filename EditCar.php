<?php
include 'config.php';

$username= $_POST['username'];
$carnumber =$_POST['carnumber'];

$db-> query ( "UPDATE users SET carnumber ='".$carnumber."'  WHERE username = '".$username."'  " );

?>