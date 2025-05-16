<?php
// HARUS PALING ATAS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include('koneksi.php');

// Untuk handle DELETE request, kita perlu membaca input
$data = json_decode(file_get_contents("php://input"), true);

// Ambil ID dari input
if (isset($data['id'])) {
    $id = mysqli_real_escape_string($conn, $data['id']);

    $query = "DELETE FROM agenda WHERE id='$id'";
    $result = mysqli_query($conn, $query);

    if ($result) {
        echo json_encode([
            'status' => true,
            'message' => 'Agenda berhasil dihapus'
        ]);
    } else {
        echo json_encode([
            'status' => false,
            'message' => 'Gagal menghapus agenda: ' . mysqli_error($conn)
        ]);
    }
} else {
    echo json_encode([
        'status' => false,
        'message' => 'ID agenda tidak ditemukan'
    ]);
}
?>