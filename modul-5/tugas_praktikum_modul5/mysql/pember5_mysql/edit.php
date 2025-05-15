<?php 
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$conn = new mysqli("localhost","root","","db_agenda");
$id_agenda = $_POST['id_agenda'];
$nama_agenda = $_POST['nama_agenda'];
$tanggal = $_POST['tanggal'];
$lokasi = $_POST['lokasi'];
$deskripsi = $_POST['deskripsi'];

$data= mysqli_query($conn,"UPDATE agenda SET nama_agenda='$nama_agenda', tanggal='$tanggal', lokasi='$lokasi', deskripsi='$deskripsi' WHERE id_agenda='$id_agenda'");

if ($data) {
	echo json_encode([
		'pesan' => 'Sukses']);
}else{
	echo json_encode([
		'pesan' => 'Gagal']);
}

 ?>