<?php
include_once 'config.php';
$result= $db -> query("SELECT * FROM `tickets` ORDER BY `tickets`.`ID` ASC");
$list=array();
if($result)
{
	while($row = mysqli_fetch_assoc($result))
	{
		$list[]=$row;

	}
	echo json_encode($list);
}

?>


