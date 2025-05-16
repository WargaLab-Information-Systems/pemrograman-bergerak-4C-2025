<?php
// HARUS PALING ATAS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'koneksi.php';

$getAll_method = mysqli_query($conn, 'SELECT * FROM agenda');
$data=mysqli_fetch_all($getAll_method, MYSQLI_ASSOC);

echo json_encode([
    'status' => true,
    'message' => 'Berhasil mendapatkan data',
    'data' => $data
]);
?>