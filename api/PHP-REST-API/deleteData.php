<?php
    header("content-type:application/json");
	include 'conn.php';
	try {
		$id=$_POST['id'];
		$connect->query("DELETE FROM users WHERE id=".$id);
	
		echo json_encode('Delete Successful');	
	}catch(Exception $e){
		echo json_encode($e->getMessage());	
	}


?>