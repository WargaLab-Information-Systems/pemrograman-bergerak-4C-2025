<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: *");

include 'koneksi.php';

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
  case 'GET':
    $query = mysqli_query($conn, "SELECT * FROM data_kain");
    $data = [];
    while ($row = mysqli_fetch_assoc($query)) {
      $data[] = $row;
    }
    echo json_encode(['success' => true, 'data' => $data]);
    break;

  case 'POST':
    $input = json_decode(file_get_contents("php://input"), true);
    $nama = $input['nama'];
    $warna = $input['warna'];
    $ukuran = $input['ukuran'];

    $result = mysqli_query($conn, "INSERT INTO data_kain (nama, warna, ukuran) VALUES ('$nama', '$warna', $ukuran)");
    if ($result) {
      $id = mysqli_insert_id($conn);
      echo json_encode(['success' => true, 'message' => 'Berhasil menambahkan data', 'data' => ['id' => $id]]);
    } else {
      echo json_encode(['success' => false, 'message' => 'Gagal menambahkan data']);
    }
    break;

  case 'PUT':
    $input = json_decode(file_get_contents("php://input"), true);
    $id = $input['id'];
    $nama = $input['nama'];
    $warna = $input['warna'];
    $ukuran = $input['ukuran'];

    $result = mysqli_query($conn, "UPDATE data_kain SET nama='$nama', warna='$warna', ukuran=$ukuran WHERE id=$id");
    if ($result) {
      echo json_encode(['success' => true, 'message' => 'Data berhasil diperbarui']);
    } else {
      echo json_encode(['success' => false, 'message' => 'Gagal memperbarui data']);
    }
    break;

  case 'DELETE':
    parse_str($_SERVER['QUERY_STRING'], $query);
    $id = $query['id'];

    $result = mysqli_query($conn, "DELETE FROM data_kain WHERE id=$id");
    if ($result) {
      echo json_encode(['success' => true, 'message' => 'Data berhasil dihapus']);
    } else {
      echo json_encode(['success' => false, 'message' => 'Gagal menghapus data']);
    }
    break;

  default:
    echo json_encode(['success' => false, 'message' => 'Method tidak diizinkan']);
    break;
}
