<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: *");

include('koneksi.php');

$id = $_POST['id'];
$nama = $_POST['nama'];
$warna = $_POST['warna'];
$ukuran = $_POST['ukuran'];

$put_method = mysqli_query($conn, "UPDATE data_kain SET nama='$nama', warna='$warna', ukuran='$panjang' WHERE id='$id'");

if ($put_method) {
    echo json_encode([
        "success" => true,
        "message" => 'Data berhasil diupdate'
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => 'Gagal update data: ' . mysqli_error($conn)
    ]);
}
