<?php
require 'koneksi.php';

session_start();

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

$user_id = $_SESSION['user_id'];
$vaksinasi_data = [];

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['anak_id'])) {
    $selected_anak_id = mysqli_real_escape_string($conn, $_POST['anak_id']);

    $query_vaksinasi = "SELECT jenis_vaksin.jenis as jenis_vaksin, vaksin_anak.status, vaksin_anak.tanggal, posyandu.nama as posyandu_nama
                        FROM vaksin_anak 
                        LEFT JOIN jenis_vaksin ON vaksin_anak.id_jenis = jenis_vaksin.id
                        LEFT JOIN posyandu ON vaksin_anak.id_posyandu = posyandu.id
                        WHERE vaksin_anak.id_anak = '$selected_anak_id'";
    $result_vaksinasi = mysqli_query($conn, $query_vaksinasi);

    if ($result_vaksinasi && mysqli_num_rows($result_vaksinasi) > 0) {
        while ($row_vaksinasi = mysqli_fetch_assoc($result_vaksinasi)) {
            $vaksinasi_data[] = $row_vaksinasi;
        }
    }
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Vaksinasi Anak</title>
    <style>
        .header {
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            text-align: center;
        }
        .container {
            padding: 20px;
            text-align: left;
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
        .back-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 10px;
        }
        .back-button:hover {
            background-color: #45a049;
        }
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f0f0f0;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .form-group button {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #45a049;
        }
        .results {
            margin-top: 20px;
        }
        .results table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .results table, .results th, .results td {
            border: 1px solid #ddd;
        }
        .results th, .results td {
            padding: 10px;
            text-align: left;
        }
        .results th {
            background-color: #f2f2f2;
            color: #333;
            font-weight: bold;
        }
        .results tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .results tr:hover {
            background-color: #f1f1f1;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 10px;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Data Vaksinasi Anak</h1>
    </div>
    <div class="container">
        <div class="results">
            <?php if (!empty($vaksinasi_data)): ?>
                <h2>Data Vaksinasi:</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Jenis Vaksin</th>
                            <th>Status</th>
                            <th>Tanggal</th>
                            <th>Posyandu</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($vaksinasi_data as $data): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($data['jenis_vaksin']); ?></td>
                                <td><?php echo htmlspecialchars($data['status']); ?></td>
                                <td><?php echo htmlspecialchars($data['tanggal']); ?></td>
                                <td><?php echo htmlspecialchars($data['posyandu_nama']); ?></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php else: ?>
                <p>Tidak ada data vaksinasi ditemukan untuk anak yang dipilih.</p>
            <?php endif; ?>
        </div>
        <a href="home.php" class="btn">Back</a>
    </div>
    <div class="footer">
        <p>&copy; ANAK 2024. All rights reserved.</p>
    </div>
</body>
</html>
