<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");
$host = "localhost";
$user = "root";
$password = "";
$dbname = "db_menu";  // Pastikan ini sesuai dengan nama database kamu

$conn = new mysqli($host, $user, $password, $dbname);

if ($conn->connect_error) {
    die(json_encode([
        "status" => false,
        "message" => "Koneksi database gagal: " . $conn->connect_error
    ]));
}
?>
