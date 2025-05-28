<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

include 'koneksi.php';

$sql = "SELECT * FROM jadwal_minum_air";
$result = $conn->query($sql);

$data = [];
while ($row = $result->fetch_assoc()) {
    $row['jumlah_air_ml'] = (int)$row['jumlah_air_ml'];
    $data[] = $row;
}

echo json_encode($data);
?>
