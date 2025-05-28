<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");


$host = "localhost";
$user = "root";
$pass = ""; 
$db   = "modul5"; 

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}
?>
