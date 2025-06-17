<?php 
header("Access-Control-Allow-Origin: *"); 
include('connection.php'); 
$title=$_POST['title']; 
$body=$_POST['body']; 
$data=mysqli_query($conn, "INSERT INTO notes (title, body) VALUES ('$title', '$body')");

if ($data) {
    echo json_encode(['pesan' => 'Sukses']); 
} else{ 
    echo json_encode(['pesan'=>'Gagal']); 
} 
?>