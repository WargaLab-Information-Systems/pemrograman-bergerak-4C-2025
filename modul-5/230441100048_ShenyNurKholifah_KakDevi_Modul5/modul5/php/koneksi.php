<?php
$host = "localhost";
$user = "root";
$password = "";
$db = "aksesoris5";
$conn = new mysqli($host, $user, $password, $db);

if ($conn->connect_error){
    die(json_encode([
        "success" => false,
        "massage" => "koneksi gagal: " . $conn->connect_error
    ]));
}
?>