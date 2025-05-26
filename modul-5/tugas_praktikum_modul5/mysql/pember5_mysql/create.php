<?php 
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$conn = new mysqli("localhost","root","","db_agenda");
$nama_agenda = $_POST['nama_agenda'];
$tanggal = $_POST['tanggal'];
$lokasi = $_POST['lokasi'];
$deskripsi = $_POST['deskripsi'];

$data= mysqli_query($conn,"INSERT INTO agenda SET nama_agenda='$nama_agenda', tanggal='$tanggal', lokasi='$lokasi', deskripsi='$deskripsi' ");

if ($data) {
	echo json_encode([
		'pesan' => 'Sukses']);
}else{
	echo json_encode([
		'pesan' => 'Gagal']);
}

 ?>