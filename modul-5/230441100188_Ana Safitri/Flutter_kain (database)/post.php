<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: *");

include('koneksi.php');

$nama = $_POST['nama'];
$warna = $_POST['warna'];
$ukuran = $_POST['panjang'];

$post_method = mysqli_query($conn, "INSERT INTO data_kain (nama, warna, ukuran) VALUES ('$nama', '$warna', '$panjang')");

if ($post_method) {
    echo json_encode([
        "success" => true,
        "message" => 'Data berhasil ditambahkan'
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => 'Gagal tambah data: ' . mysqli_error($conn)
    ]);
}
