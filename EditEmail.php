<?php
include 'config.php';

$username= $_POST['username'];
$ID =$_POST['ID'];

$db-> query ( "UPDATE users SET username = '".$username."'  WHERE ID = '".$ID."'  " );

?>