<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
include "koneksi.php";
$sql = mysqli_query($conn, "SELECT id_aksesoris,nama_aksesoris,stok,harga FROM aksesoris");
$data=mysqli_fetch_all($sql,MYSQLI_ASSOC);
echo json_encode($data);
?>