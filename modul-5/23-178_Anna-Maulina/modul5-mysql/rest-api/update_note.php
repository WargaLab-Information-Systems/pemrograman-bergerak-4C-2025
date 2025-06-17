<?php 
header("Access-Control-Allow-Origin: *"); 
include('connection.php'); 
$id=$_POST['id']; 
$title=$_POST['title']; 
$body=$_POST['body']; 
$createdAt=$_POST['createdAt']; 
$data=mysqli_query($conn, "update notes set title='$title', body='$body', createdAt='$createdAt' where id='$id' "); 
if ($data) {
    echo json_encode(['pesan' => 'Sukses update']); 
} else{ 
    echo json_encode(['pesan'=>'Gagal']); 
} 
?>