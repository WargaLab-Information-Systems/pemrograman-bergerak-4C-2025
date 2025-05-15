<?php 
$host = "localhost"; 
$user = "root"; 
$password = ""; 
$db = "db_notes"; 
$conn = new mysqli($host, $user, $password, $db); 

if ($conn->connect_error) { 
    die(json_encode([
        "success" => false, 
        "message" => "Koneksi gagal: " . $conn->connect_error 
    ])); 
} 
?>
