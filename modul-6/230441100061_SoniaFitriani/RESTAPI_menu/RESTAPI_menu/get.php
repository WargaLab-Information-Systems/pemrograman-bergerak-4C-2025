<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$sql = "SELECT * FROM menu";
$result = $conn->query($sql);

$menu = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $menu[] = [
            'id_produk' => $row['id_produk'],
            'nama' => $row['nama_produk'],
            'kategori' => $row['kategori'],
            'harga' => $row['harga']
        ];
    }

    echo json_encode($menu);
} else {
    echo json_encode([]);
}
?>
