<?php
// HARUS PALING ATAS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include('koneksi.php');

// Untuk handle PUT request, kita perlu membaca input
$data = json_decode(file_get_contents("php://input"), true);

// Ambil data dari input
if (
    isset($data['id']) &&
    isset($data['nama']) &&
    isset($data['detail']) &&
    isset($data['tanggal']) &&
    isset($data['lokasi'])
) {
    $id = mysqli_real_escape_string($conn, $data['id']);
    $nama = mysqli_real_escape_string($conn, $data['nama']);
    $detail = mysqli_real_escape_string($conn, $data['detail']);
    $tanggal = mysqli_real_escape_string($conn, $data['tanggal']);
    $lokasi = mysqli_real_escape_string($conn, $data['lokasi']);

    $query = "UPDATE agenda SET 
              nama='$nama', 
              detail='$detail', 
              tanggal='$tanggal', 
              lokasi='$lokasi' 
              WHERE id='$id'";
              
    $result = mysqli_query($conn, $query);

    if ($result) {
        echo json_encode([
            'status' => true,
            'message' => 'Agenda berhasil diperbarui'
        ]);
    } else {
        echo json_encode([
            'status' => false,
            'message' => 'Gagal memperbarui agenda: ' . mysqli_error($conn)
        ]);
    }
} else {
    echo json_encode([
        'status' => false,
        'message' => 'Data agenda tidak lengkap'
    ]);
}
?>