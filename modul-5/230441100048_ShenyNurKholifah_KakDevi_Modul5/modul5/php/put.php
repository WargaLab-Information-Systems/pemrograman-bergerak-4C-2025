<?php
include 'koneksi.php';
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");


$id = $_POST['id_aksesoris'];
$nama = $_POST['nama_aksesoris'];
$harga = $_POST['harga'];
$stok = $_POST['stok'];

$query = "UPDATE aksesoris SET nama_aksesoris='$nama', harga='$harga', stok='$stok' WHERE id_aksesoris='$id'";
$result = mysqli_query($conn, $query);

if ($result) {
    echo json_encode(["message" => "Data berhasil diupdate"]);
} else {
    echo json_encode(["message" => "Gagal update data"]);
}
?>
