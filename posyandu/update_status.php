<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_jenis = $_POST['id_jenis'];
    $status = $_POST['status'];
    $id_posyandu = $_POST['id_posyandu']; // Ambil id_posyandu dari permintaan POST

    // Log received data
    echo "Received data: id_jenis=$id_jenis, status=$status, id_posyandu=$id_posyandu\n";

    // Update the status in the vaksinasi table for the specified posyandu and jenis vaksin
    $updateQuery = "UPDATE vaksinasi SET status = '$status' WHERE id_jenis = '$id_jenis' AND id_posyandu = '$id_posyandu'";
    if (mysqli_query($conn, $updateQuery)) {
        echo "Status updated successfully";
    } else {
        echo "Error: " . mysqli_error($conn);
    }
}
?>
