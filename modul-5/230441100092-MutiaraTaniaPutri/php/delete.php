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
$id_jadwal = $input['id_jadwal'];

$sql = "DELETE FROM jadwal_minum_air WHERE id_jadwal = '$id_jadwal'";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["message" => "Data berhasil dihapus"]);
} else {
    echo json_encode(["error" => $conn->error]);
}
?>
