<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

include 'koneksi.php';

// Baca input JSON
$input = json_decode(file_get_contents('php://input'), true);

$id = $input['id_produk'] ?? null;
$nama = $input['nama'] ?? null;
$kategori = $input['kategori'] ?? null;
$harga = $input['harga'] ?? null;

if (!$id || !$nama || !$kategori || !$harga) {
    echo json_encode([
        "status" => false,
        "message" => "Data tidak lengkap"
    ]);
    exit;
}

$query = "UPDATE menu SET nama_produk = ?, kategori = ?, harga = ? WHERE id_produk = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("ssii", $nama, $kategori, $harga, $id);

if ($stmt->execute()) {
    echo json_encode([
        "status" => true,
        "message" => "Produk berhasil diperbarui"
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "Gagal memperbarui produk"
    ]);
}
