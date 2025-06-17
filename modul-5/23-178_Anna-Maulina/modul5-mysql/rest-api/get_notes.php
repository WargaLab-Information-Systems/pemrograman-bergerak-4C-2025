<?php 
header("Access-Control-Allow-Origin: *"); 
include "connection.php"; 
$sql = mysqli_query($conn, "SELECT id, title, body, createdAt FROM notes"); 
$data=mysqli_fetch_all($sql, MYSQLI_ASSOC); 
echo json_encode($data); 
?>