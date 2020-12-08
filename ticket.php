<?php

$db = mysqli_connect('localhost','root','','gp_project');

if(!$db)
{
echo "Database connection failed";
}


$ID= $_POST['ID'];


$sql = "SELECT * FROM traffic WHERE ID = '".$ID."' AND ticketId IS NOT NULL" ;

$result = mysqli_query($db,$sql);
$count = mysqli_num_rows($result);

if($count == 1 )
{
	echo json_encode("ThereIsTicket");
}

else
{
echo json_encode("NoTicket");
}

?>