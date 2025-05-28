<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: *");

include "koneksi.php";

$sql = mysqli_query($conn, "SELECT * FROM data_kain");

if (!$sql) {
    echo json_encode([
        "success" => false,
        "message" => "Query failed: " . mysqli_error($conn)
    ]);
    exit;
}

$data = mysqli_fetch_all($sql, MYSQLI_ASSOC);

echo json_encode([
    "success" => true,
    "data" => $data
]);
