<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

include 'koneksi.php';

$input = json_decode(file_get_contents('php://input'), true);

file_put_contents("debug.txt", json_encode($input)); 

if (!isset($input['id_jadwal'])) {
    echo json_encode(["error" => "id_jadwal tidak ditemukan"]);
    exit();
}

$id_jadwal = $input['id_jadwal'];
$tanggal = $input['tanggal'];
$jumlah_air = $input['jumlah_air_ml'];
$waktu_minum = $input['waktu_minum'];
$catatan = $input['catatan'];

$sql = "UPDATE jadwal_minum_air 
        SET tanggal=?, jumlah_air=?, waktu_minum=?, catatan=? 
        WHERE id_jadwal=?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("sissi", $tanggal, $jumlah_air, $waktu_minum, $catatan, $id_jadwal);

if ($stmt->execute()) {
    echo json_encode(["message" => "Data berhasil diupdate"]);
} else {
    echo json_encode(["error" => $stmt->error]);
}
?>
