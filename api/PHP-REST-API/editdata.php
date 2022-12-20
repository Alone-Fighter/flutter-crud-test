<?php
    header("content-type:application/json");
	include 'conn.php';

	try {
		$id = $_POST['id'];
		$FName = $_POST['FName'];
		$Lname = $_POST['Lname'];
		$DateOfBirth = $_POST['DateOfBirth'];
		$PhoneNumber= $_POST['PhoneNumber'];
		$Email= $_POST['Email'];
		$BankAccountNumber= $_POST['BankAccountNumber'];
		$Region= $_POST['Region'];

		$connect->query("UPDATE users SET FName='".$FName."', Lname='".$Lname."', DateOfBirth='".$DateOfBirth."', PhoneNumber='".$PhoneNumber."', Email='".$Email."', BankAccountNumber='".$BankAccountNumber."', Region='".$Region."' WHERE id=". $id);
		echo json_encode('Edit Successful');	

	}catch(Exception $e){
		echo json_encode($e->getMessage());		
	}


?>
