<?php 
header("Access-Control-Allow-Origin: *"); 
include('connection.php'); 
$id=$_POST['id'];  
$data=mysqli_query($conn, "delete from notes where id='$id'"); 
if ($data) {
    echo json_encode(['pesan' => 'Sukses']); 
} else{ 
    echo json_encode(['pesan'=>'Gagal']); 
} 
?>