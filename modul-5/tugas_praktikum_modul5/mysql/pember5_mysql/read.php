<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
 

$conn = new mysqli("localhost","root","","db_agenda");
$query = mysqli_query($conn,"SELECT * FROM agenda");
$data= mysqli_fetch_all($query,MYSQLI_ASSOC);
echo json_encode($data);




?>