<?php
// Menangani masalah CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");

// Menyertakan file koneksi ke database
include("koneksi.php");

// Memeriksa apakah metode request adalah DELETE
if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Mengambil data dari body request
    parse_str(file_get_contents("php://input"), $data);
    $id_aksesoris = $data['id_aksesoris'];

    // Query untuk menghapus data aksesoris berdasarkan ID
    $query = "DELETE FROM aksesoris WHERE id_aksesoris='$id_aksesoris'";
    $result = mysqli_query($conn, $query);

    // Mengecek apakah query berhasil
    if ($result) {
        echo json_encode(['pesan' => 'sukses']);
    } else {
        echo json_encode(['pesan' => 'gagal']);
    }
} else {
    echo json_encode(['pesan' => 'Method not allowed']);
}
?>
