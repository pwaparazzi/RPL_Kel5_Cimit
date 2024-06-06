<?php
require 'koneksi.php';

session_start();

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

$error_message = "";
$nama_anak = "";
$posyandu = [];
$vaksinasi_data = [];

$user_id = $_SESSION['user_id'];

$query_anak = "SELECT id, nama FROM anaks WHERE id_user = $user_id";
$result_anak = mysqli_query($conn, $query_anak);

if ($result_anak && mysqli_num_rows($result_anak) > 0) {
    $row_anak = mysqli_fetch_assoc($result_anak);
    $id_anak = $row_anak["id"];
    $nama_anak = $row_anak["nama"];

    $query_vaksin = "SELECT jenis, tanggal, status FROM vaksinasi WHERE id_anak = $id_anak";
    $result_vaksin = mysqli_query($conn, $query_vaksin);

    if ($result_vaksin && mysqli_num_rows($result_vaksin) > 0) {
        while ($row_vaksin = mysqli_fetch_assoc($result_vaksin)) {
            $vaksinasi_data[] = $row_vaksin;
        }
    } else {
        $error_message = "Data vaksin tidak ditemukan.";
    }


    $query_posyandu = "SELECT posyandu.nama FROM vaksinasi
                        JOIN posyandu ON vaksinasi.id_posyandu = posyandu.id
                        WHERE vaksinasi.id_anak = $id_anak LIMIT 1";

    $result_posyandu = mysqli_query($conn, $query_posyandu);

    if ($result_posyandu && mysqli_num_rows($result_posyandu) > 0) {
        $row_posyandu = mysqli_fetch_assoc($result_posyandu);
        $posyandu = $row_posyandu;

    } else {
        $error_message = "Data posyandu tidak ditemukan.";
    }
} else {
    $error_message = "Data anak tidak ditemukan.";
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vaksinasi - Home Posyandu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }
        .header {
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            text-align: center;
        }
        .container {
            padding: 20px;
            text-align: left;
            max-width: 600px;
            margin: 0 auto;
        }
        .profile-box, .vaccination-box {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .profile-info, .vaccination-info {
            margin-bottom: 20px;
        }
        .profile-info label, .vaccination-info label {
            font-weight: bold;
        }
        .footer {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 10px;
            position: fixed;
            width: 100%;
            bottom: 0;
        }
        .back-button, .edit-button {
            padding: 10px 20px;
            display: inline-block;
            color: white;
            background-color: #4CAF50;
            text-align: center;
            text-decoration: none;
            margin-top: 20px;
            border-radius: 5px;
        }
        .back-button:hover, .edit-button:hover {
            background-color: #45a049;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Profile</h1>
    </div>
    <div class="container">
        <?php if (!empty($error_message)) : ?>
            <div class="error-message"><?php echo $error_message; ?></div>
        <?php else : ?>
            <div class="profile-box">
                <div class="profile-info">
                    <label>Nama Anak:</label>
                    <p><?php echo $nama_anak; ?></p>
                </div>
            </div>

            <div class="vaccination-box">
                <h2>Vaccination Details</h2>
                <?php if (count($vaksinasi_data) > 0) : ?>
                    <table>
                        <thead>
                            <tr>
                                <th>Jenis Vaksin</th>
                                <th>Tanggal Vaksin</th>
                                <th>Status</th>
                                <th>Posyandu</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($vaksinasi_data as $vaksinasi) : ?>
                                <tr>
                                    <td><?php echo $vaksinasi['jenis']; ?></td>
                                    <td><?php echo $vaksinasi['tanggal']; ?></td>
                                    <td><?php echo $vaksinasi['status']; ?></td>
                                    <td><?php echo $posyandu['nama']; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                <?php else : ?>
                    <p>No vaccination records found.</p>
                <?php endif; ?>
            </div>
        <?php endif; ?>
        <a class="back-button" href="home.php">Back</a>
    </div>
    <div class="footer">
        <p>&copy; ANAK 2024. All rights reserved.</p>
    </div>
</body>
</html>