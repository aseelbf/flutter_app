<?php

$db = mysqli_connect('localhost','root','','gp_project');

if(!$db)
{
echo "Database connection failed";
}


$ID= $_POST['ID'];


$sql = " select * FROM traffic,tickets where
 tickets.ID = traffic.ticketId
and traffic.id = '".$ID."' "

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