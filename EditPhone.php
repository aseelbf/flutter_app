<?php
include 'config.php';

$username= $_POST['username'];
$mobilenumber =$_POST['mobilenumber'];

$db-> query ( "UPDATE users SET mobilenumber ='".$mobilenumber."'  WHERE username = '".$username."'  " );

?>