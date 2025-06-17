<?php
include 'koneksi.php';

$id = $_POST['id_admin'];
$nama = $_POST['nama'];
$email = $_POST['email'];
$password = $_POST['password'];

$sql = "UPDATE profil_admin SET nama='$nama', email='$email', password='$password' WHERE id_admin=$id";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["message" => "Data berhasil diperbarui"]);
} else {
    echo json_encode(["message" => "Error: " . $conn->error]);
}

$conn->close();
?>
