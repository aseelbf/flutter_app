<?php
include 'config.php';

$username= $_POST['username'];
$password= $_POST['password'];

$db-> query ( "UPDATE users SET password ='".$password."'  WHERE username = '".$username."'  " );

?>