<?php
include 'koneksi.php';

$id = $_POST['id_admin'];

$sql = "DELETE FROM profil_admin WHERE id_admin=$id";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["message" => "Data berhasil dihapus"]);
} else {
    echo json_encode(["message" => "Error: " . $conn->error]);
}

$conn->close();
?>
