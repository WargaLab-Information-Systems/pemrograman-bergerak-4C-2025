<?php 
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$conn = new mysqli("localhost","root","","db_agenda");
$id_agenda = $_POST['id_agenda'];


$data= mysqli_query($conn,"DELETE FROM agenda WHERE id_agenda='$id_agenda'");

if ($data) {
	echo json_encode([
		'pesan' => 'Sukses']);
}else{
	echo json_encode([
		'pesan' => 'Gagal']);
}

 ?>