<?php
$host = "127.0.0.1";
$port = "3307";
$user = "root";
$password = "";
$db = "toko_kain";

$conn = mysqli_connect($host, $user, $password, $db, $port);

if (!$conn) {
    header("Content-Type: application/json");
    echo json_encode(["error" => "Koneksi gagal: " . mysqli_connect_error()]);
    exit;
}
