<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include('koneksi.php');

// Ambil raw input JSON
$input = json_decode(file_get_contents('php://input'), true);

if (isset($input['nama'], $input['detail'], $input['tanggal'], $input['lokasi'])) {
    $nama = mysqli_real_escape_string($conn, $input['nama']);
    $detail = mysqli_real_escape_string($conn, $input['detail']);
    $tanggal = mysqli_real_escape_string($conn, $input['tanggal']);
    $lokasi = mysqli_real_escape_string($conn, $input['lokasi']);

    $query = "INSERT INTO agenda (nama, detail, tanggal, lokasi) VALUES ('$nama', '$detail', '$tanggal', '$lokasi')";
    $data = mysqli_query($conn, $query);

    if ($data) {
        echo json_encode([
            'status' => true,
            'message' => 'Agenda berhasil ditambahkan'
        ]);
    } else {
        echo json_encode([
            'status' => false,
            'message' => 'Gagal menambahkan agenda: ' . mysqli_error($conn)
        ]);
    }
} else {
    echo json_encode([
        'status' => false,
        'message' => 'Data agenda tidak lengkap'
    ]);
}
?>
