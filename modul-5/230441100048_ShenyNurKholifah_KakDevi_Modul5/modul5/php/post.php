<?php
// CORS Headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");

include("koneksi.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Ambil data dari POST
    $id_aksesoris = $_POST['id_aksesoris'];
    $nama_aksesoris = $_POST['nama_aksesoris'];
    $stok = $_POST['stok'];
    $harga = $_POST['harga'];

    // Eksekusi query insert
    $query = "INSERT INTO aksesoris (id_aksesoris, nama_aksesoris, stok, harga) 
              VALUES ('$id_aksesoris', '$nama_aksesoris', '$stok', '$harga')";
    $data = mysqli_query($conn, $query);

    // Respon hasil
    if ($data) {
        echo json_encode(['pesan' => 'sukses']);
    } else {
        echo json_encode(['pesan' => 'gagal', 'error' => mysqli_error($conn)]);
    }
} else {
    echo json_encode(['pesan' => 'Metode tidak diizinkan']);
}
?>
