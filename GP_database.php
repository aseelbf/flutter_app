<?php
$db = mysqli_connect('localhost','root','','gp_project');
if(!$db)
{
echo "Database connection faild";
}

$username= $_POST['username'];
$password= $_POST['password'];
$mobilenumber= $_POST['mobilenumber']; 
$carnumber= $_POST['carnumber'];
$ID=$_POST['ID'];

$sql = "SELECT * FROM users WHERE username = '".$username."' " ;

$result = mysqli_query($db,$sql);
$count = mysqli_num_rows($result);

if($count == 1 ){
	echo json_encode("Error");
}
else 
{
$insert= "INSERT INTO users(username,password,mobilenumber,carnumber,ID)VALUES('".$username."','".$password."' , '".$mobilenumber."' , '".$carnumber."', '".$ID."')";

	$query= mysqli_query($db,$insert);
	if($query)
	{
		echo json_encode("success");
	}
}


?>