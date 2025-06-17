<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");
include 'koneksi.php';

error_reporting(0);
ini_set('display_errors', 0);

$data = json_decode(file_get_contents("php://input"), true);

$id = intval($data['id_produk'] ?? 0);

if ($id <= 0) {
    echo json_encode(["status" => false, "message" => "ID produk tidak valid"]);
    exit;
}

$query = "DELETE FROM menu WHERE id_produk = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    if ($stmt->affected_rows > 0) {
        echo json_encode(["status" => true, "message" => "Produk berhasil dihapus"]);
    } else {
        echo json_encode(["status" => false, "message" => "Produk tidak ditemukan"]);
    }
} else {
    echo json_encode(["status" => false, "message" => "Gagal menghapus produk: " . $conn->error]);
}
?>
