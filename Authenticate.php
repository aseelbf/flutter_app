<?php

$db = mysqli_connect('localhost','root','','gp_project');

if(!$db)
{
echo "Database connection failed";
}


$ID= $_POST['ID'];
$carnumber= $_POST['carnumber'];

$sql = "SELECT * FROM traffic WHERE ID = '".$ID."' AND carnumber='".$carnumber."' " ;

$result = mysqli_query($db,$sql);
$count = mysqli_num_rows($result);

if($count == 1 )
{
	echo json_encode("Success");
}

else
{
echo json_encode("Error");
}

?>