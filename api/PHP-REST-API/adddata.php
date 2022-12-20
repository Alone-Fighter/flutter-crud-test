<?php
    header("content-type:application/json");
	include 'conn.php';

		try{
		$FName = $_POST['FName'];
		$Lname = $_POST['Lname'];
		$DateOfBirth = $_POST['DateOfBirth'];
		$PhoneNumber= $_POST['PhoneNumber'];
		$Email= $_POST['Email'];
		$BankAccountNumber= $_POST['BankAccountNumber'];
		$Region= $_POST['Region'];

	
		
		
		$connect->query("INSERT INTO users (FName,Lname,DateOfBirth,PhoneNumber,Email,BankAccountNumber,Region) VALUES ('".$FName."','".$Lname."','".$DateOfBirth."','".$PhoneNumber."','".$Email."','".$BankAccountNumber."','".$Region."')");
		echo json_encode('Submit Successful');	
		}catch(Exception $e){
			echo json_encode($e->getMessage());		
		}
	


?>