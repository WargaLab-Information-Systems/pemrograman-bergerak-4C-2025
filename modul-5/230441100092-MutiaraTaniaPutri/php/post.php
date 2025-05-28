<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}
header("Content-Type: application/json");

include 'koneksi.php';

$rawInput = file_get_contents('php://input');
file_put_contents("log_input.txt", "RAW: $rawInput\n", FILE_APPEND); 

$input = json_decode($rawInput, true);

if ($input === null) {
    echo json_encode([
        "error" => "JSON tidak valid",
        "raw" => $rawInput,
        "json_last_error" => json_last_error_msg()
    ]);
    exit;
}

$tanggal = $input['tanggal'];
$jumlah_air = $input['jumlah_air_ml'];
$waktu_minum = $input['waktu_minum'];
$catatan = $input['catatan'];

$sql = "INSERT INTO jadwal_minum_air (tanggal, jumlah_air_ml, waktu_minum, catatan) 
        VALUES ('$tanggal', '$jumlah_air', '$waktu_minum', '$catatan')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["message" => "Data berhasil ditambahkan"]);
} else {
    echo json_encode(["error" => $conn->error]);
}
?>