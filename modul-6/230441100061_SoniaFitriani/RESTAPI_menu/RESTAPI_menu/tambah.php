<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

include 'koneksi.php';

// Baca input JSON
$input = json_decode(file_get_contents('php://input'), true);

$nama = $input['nama'] ?? null;
$kategori = $input['kategori'] ?? null;
$harga = $input['harga'] ?? null;

if (!$nama || !$kategori || !$harga) {
    echo json_encode([
        "status" => false,
        "message" => "Data tidak lengkap"
    ]);
    exit;
}

$query = "INSERT INTO menu (nama_produk, kategori, harga) VALUES (?, ?, ?)";
$stmt = $conn->prepare($query);
$stmt->bind_param("ssi", $nama, $kategori, $harga);

if ($stmt->execute()) {
    echo json_encode([
        "status" => true,
        "message" => "Produk berhasil ditambahkan"
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "Gagal menambahkan produk"
    ]);
}
?>
