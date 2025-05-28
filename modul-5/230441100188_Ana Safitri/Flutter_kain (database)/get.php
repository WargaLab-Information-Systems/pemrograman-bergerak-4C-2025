<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: *");

include "koneksi.php";

$sql = mysqli_query($conn, "SELECT * FROM data_kain");
$data = [];

while ($row = mysqli_fetch_assoc($sql)) {
    $data[] = $row;
}

echo json_encode($data);
