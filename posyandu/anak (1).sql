-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 06, 2024 at 12:44 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `anak`
--

-- --------------------------------------------------------

--
-- Table structure for table `anaks`
--

CREATE TABLE `anaks` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `nama` varchar(255) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') NOT NULL,
  `berat` int(11) NOT NULL,
  `tinggi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `anaks`
--

INSERT INTO `anaks` (`id`, `id_user`, `nama`, `tanggal_lahir`, `jenis_kelamin`, `berat`, `tinggi`) VALUES
(1, 2, 'Alya', '2020-01-15', 'Perempuan', 15, 95),
(2, 2, 'Bima', '2018-07-25', 'Laki-laki', 18, 105),
(3, 2, 'Citra', '2019-03-12', 'Perempuan', 16, 100),
(4, 3, 'Dimas', '2021-11-20', 'Laki-laki', 12, 85),
(5, 3, 'Eka', '2019-08-05', 'Laki-laki', 17, 102),
(6, 4, 'Fajar', '2022-05-18', 'Laki-laki', 10, 75),
(7, 4, 'Gita', '2020-04-30', 'Perempuan', 14, 90),
(8, 4, 'Hani', '2018-12-10', 'Perempuan', 19, 108),
(9, 5, 'Ira', '2019-11-22', 'Perempuan', 16, 98),
(10, 6, 'Joko', '2021-02-14', 'Laki-laki', 16, 87),
(11, 6, 'Sari', '2022-10-18', 'Perempuan', 30, 81);

--
-- Triggers `anaks`
--
DELIMITER $$
CREATE TRIGGER `after_anak_insert` AFTER INSERT ON `anaks` FOR EACH ROW BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE jenis_id INT;

    -- Cursor untuk iterasi tabel jenis_vaksin
    DECLARE jenis_cursor CURSOR FOR
        SELECT id FROM jenis_vaksin;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN jenis_cursor;

    jenis_loop: LOOP
        FETCH jenis_cursor INTO jenis_id;
        IF done THEN
            LEAVE jenis_loop;
        END IF;

        -- Insert ke tabel vaksin_anak untuk setiap jenis vaksin
        INSERT INTO vaksin_anak (id_anak, id_posyandu, id_jenis, tanggal, status)
        VALUES (NEW.id, NULL, jenis_id, NULL, 'belum');
    END LOOP;

    CLOSE jenis_cursor;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `artikel`
--

CREATE TABLE `artikel` (
  `id` int(11) NOT NULL,
  `judul` varchar(255) DEFAULT NULL,
  `pengarang` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `status` enum('acc','pending') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `artikel`
--

INSERT INTO `artikel` (`id`, `judul`, `pengarang`, `link`, `status`) VALUES
(1, 'Kesehatan Anak', 'dr. Fadhli Rizal Makarim', 'https://www.halodoc.com/kesehatan/kesehatan-anak', 'acc'),
(2, 'Kenali Nutrisi dan Manfaatnya bagi Anak', 'RSU Bunda Jakarta', 'https://bunda.co.id/uncategorized-id/kenali-nutrisi-dan-manfaatnya-bagi-anak/', 'acc'),
(3, '5 Tips Sederhana Menjaga Kesehatan Anak', 'dr. Kornelia Ranti,Sp.A', 'https://www.emc.id/id/care-plus/5-tips-sederhana-menjaga-kesehatan-anak', 'acc'),
(4, '5 Hal yang Perlu Orangtua Lakukan untuk Memastikan Kesehatan Anak di Masa Depan', 'Risky Candra Swar', 'https://hellosehat.com/parenting/kesehatan-anak/gangguan-perkembangan/tips-menjaga-kesehatan-anak/', 'pending'),
(5, 'Yuk, Pelajari Tips Perkembangan Motorik Halus si Kecil!', 'smilestones', 'https://fisher-price.co.id/articles/bayi/yuk-pelajari-tips-perkembangan-motorik-halus-si-kecil', 'acc'),
(6, 'Stres Mengurus Bayi Baru Lahir? Ini Cara Mengatasinya', 'dr. Sienny Agustin', 'https://www.alodokter.com/stres-mengurus-bayi-baru-lahir-ini-cara-mengatasinya', 'pending'),
(7, 'Ini Rekomendasi MPASI Terbaru dari WHO, Anak Wajib Makan Protein Setiap Hari', 'Friska Yolandha', 'https://ameera.republika.co.id/berita/s30jc7370/ini-rekomendasi-mpasi-terbaru-dari-who-anak-wajib-makan-protein-setiap-hari', 'acc'),
(8, 'Kebutuhan Dasar Anak untuk Tumbuh Kembang Yang Optimal', 'kementrian kesehatan', 'https://kesmas.kemkes.go.id/konten/133/0/021113-kebutuhan-dasar-anak-untuk-tumbuh-kembang-yang-optimal', 'pending'),
(9, 'Pertumbuhan Si Kecil Lambat? Simak Tabel Tinggi Badan Anak Berikut, Moms', 'Anggraini Nurul F', 'https://www.mooimom.id/mamapedia/pertumbuhan-si-kecil-lambat-simak-tabel-tinggi-badan-anak-berikut-moms', 'acc'),
(10, 'Tahap-Tahap Perkembangan Balita Usia 1-5 Tahun', 'Hello Sehat', 'https://hellosehat.com/parenting/anak-1-sampai-5-tahun/perkembangan-balita/tahap-perkembangan-balita/', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `jenis_vaksin`
--

CREATE TABLE `jenis_vaksin` (
  `id` int(11) NOT NULL,
  `jenis` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jenis_vaksin`
--

INSERT INTO `jenis_vaksin` (`id`, `jenis`) VALUES
(1, 'Hepatitis B dosis 1'),
(2, 'BCG dosis 1'),
(3, 'Hepatitis B dosis 2'),
(4, 'DTP-HB-Hib dosis 1'),
(5, 'Polio (OPV) dosis 1'),
(6, 'Polio (IPV) dosis 1'),
(7, 'PCV dosis 1'),
(8, 'Rotavirus dosis 1'),
(9, 'DTP-HB-Hib dosis 2'),
(10, 'Polio (OPV) dosis 2'),
(11, 'DTP-HB-Hib dosis 3'),
(12, 'Polio (OPV) dosis 3'),
(13, 'PCV dosis 2'),
(14, 'Rotavirus dosis 2'),
(15, 'Hepatitis B dosis 3'),
(16, 'Polio (OPV) dosis 4'),
(17, 'Polio (IPV) dosis 2'),
(18, 'PCV dosis 3'),
(19, 'Rotavirus dosis 3'),
(20, 'Influenza dosis 1'),
(21, 'MMR dosis 1'),
(22, 'Japanese Encephalitis dosis 1'),
(23, 'MMR dosis 2'),
(24, 'PCV booster'),
(25, 'Hepatitis A dosis 1'),
(26, 'Varicella dosis 1'),
(27, 'Influenza dosis 2'),
(28, 'DTP-HB-Hib booster'),
(29, 'Polio (OPV) booster'),
(30, 'Hepatitis A dosis 2'),
(31, 'Influenza dosis 3'),
(32, 'Japanese Encephalitis booster'),
(33, 'Tifoid dosis 1'),
(34, 'Influenza dosis 4'),
(35, 'Influenza dosis 5'),
(36, 'Influenza dosis 6'),
(37, 'DTP booster'),
(38, 'Influenza dosis 7');

-- --------------------------------------------------------

--
-- Table structure for table `posyandu`
--

CREATE TABLE `posyandu` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `kecamatan` varchar(255) NOT NULL,
  `kelurahan` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posyandu`
--

INSERT INTO `posyandu` (`id`, `nama`, `kecamatan`, `kelurahan`, `alamat`, `link`, `count`) VALUES
(17, 'Kenanga I', 'Sukasari', 'Sukarasa', 'Jl. Sukahaji Baru N0.19 RT 06 RW 01', 'https://maps.app.goo.gl/ijffyfDfEDUGYosP9', 0),
(18, 'Teratai', 'Sukasari', 'Sukarasa', 'Jl. Cilandak RT 01 RW 05', 'https://maps.app.goo.gl/w17JL5Lpc5jT39o96', 31),
(19, 'Nusa Indah', 'Sukasari', 'Sukarasa', 'Jl. Cilandak RT 02 RW 06', 'https://maps.app.goo.gl/w17JL5Lpc5jT39o96', 0),
(20, 'Sakura I', 'Sukasari', 'Sukarasa', 'Jl. Sukahaji No. 106 RT 03 RW 07', 'https://maps.app.goo.gl/Mt4gfRMnr2orvwBb6', 0),
(21, 'Miana I Pos I', 'Sukasari', 'Gegerkalong', 'Jl. Gegerkalong Tengah RT 04 RW 03', 'https://maps.app.goo.gl/LJA1GugseJdcaBgq6', 0),
(22, 'Miana II Pos I', 'Sukasari', 'Gegerkalong', 'Jl. Gegerkalong Hilir RT 05 RW 04', 'https://maps.app.goo.gl/aiiD2e7p3K1fFo8j6', 0),
(23, 'Miana III Pos I', 'Sukasari', 'Gegerkalong', 'Jl. Gegerkalong Hilir RT 01 RW 07', 'https://maps.app.goo.gl/UktMAn8q1hyZnE9V8', 0),
(24, 'Miana IV', 'Sukasari', 'Gegerkalong', 'Jl. Sindang Sirna Ii RT 08 RW 06', 'https://maps.app.goo.gl/hNJMsP95oZzM64Js9', 0),
(25, 'Anggrek', 'Sukasari', 'Isola', 'Cirateun RT 01 RW 01', 'https://maps.app.goo.gl/Rd8yUGwRz8Vx8jrs5', 0),
(26, 'Nusa Indah', 'Sukasari', 'Isola', 'Cirateun RT 02 RW 02', 'https://maps.app.goo.gl/reS3KBvGvxwc4j3U7', 0),
(27, 'Budiasih', 'Sukasari', 'Isola', 'Cirateun RT 01 RW 03', 'https://maps.app.goo.gl/jVUH8rUqgq9z57i5A', 0),
(28, 'Ananda 1', 'Sukasari', 'Isola', 'Jl. Sersan Bajuri RT 01 RW 04', 'https://maps.app.goo.gl/ahix7jwkEtti14Tk6', 0),
(29, 'Cempaka 1', 'Sukasari', 'Isola', 'Jl. Gegerkalong Girang RT 03 RW 06', 'https://maps.app.goo.gl/qMqNnPUFxxGMU15d9', 0),
(30, 'Teratai', 'Sukasari', 'Sarijadi', 'GSG RW 07 RT 04 Blok 15', 'https://maps.app.goo.gl/f8wkCumHmHvrtcJD8', 0),
(31, 'Matahari', 'Sukasari', 'Sarijadi', 'GSG RW 09 RT 02', 'https://maps.app.goo.gl/LARfocG1tecCJcXE8', 0),
(32, 'Anggrek', 'Sukasari', 'Sarijadi', 'GSG RW 11 RT 03 Jalan Sariwangi', 'https://maps.app.goo.gl/bZePq1VPTNAUyeAZ8', 0),
(33, 'Kasih', 'Sukasari', 'Isola', 'Jl. Setia Budi No.10', '-', 0);

--
-- Triggers `posyandu`
--
DELIMITER $$
CREATE TRIGGER `after_posyandu_insert` AFTER INSERT ON `posyandu` FOR EACH ROW BEGIN
    DECLARE random_password VARCHAR(20);
    SET random_password = CONCAT(
        CHAR(FLOOR(65 + RAND() * 26)), CHAR(FLOOR(65 + RAND() * 26)),
        CHAR(FLOOR(65 + RAND() * 26)), CHAR(FLOOR(65 + RAND() * 26)),
        CHAR(FLOOR(65 + RAND() * 26)), CHAR(FLOOR(65 + RAND() * 26)),
        CHAR(FLOOR(65 + RAND() * 26)), CHAR(FLOOR(65 + RAND() * 26)),
        CHAR(FLOOR(65 + RAND() * 26)), CHAR(FLOOR(65 + RAND() * 26))
    );

    INSERT INTO user_account (username, password)
    VALUES (NEW.nama, random_password);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_posyandu_insert_vaksin` AFTER INSERT ON `posyandu` FOR EACH ROW BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE vak_id INT;

    -- Cursor to select all id from jenis_vaksin
    DECLARE vak_cursor CURSOR FOR
        SELECT id FROM jenis_vaksin;
    
    -- Handler for the end of cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN vak_cursor;
    
    -- Loop through all rows in jenis_vaksin
    read_loop: LOOP
        FETCH vak_cursor INTO vak_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Insert into vaksinasi
        INSERT INTO vaksinasi (id_posyandu, id_jenis)
        VALUES (NEW.id, vak_id);
    END LOOP;

    CLOSE vak_cursor;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_account`
--

CREATE TABLE `user_account` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `jenis_kelamin` enum('Pria','Wanita') NOT NULL,
  `NIK` varchar(255) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_account`
--

INSERT INTO `user_account` (`id`, `username`, `password`, `nama`, `email`, `jenis_kelamin`, `NIK`, `tanggal_lahir`) VALUES
(1, 'admin', 'admin', 'Admin', 'admin@gmail.com', '', '-', '0000-00-00'),
(2, 'gita', 'gita123', 'Arianti Apriani Sagita', NULL, '', NULL, NULL),
(3, 'dlar', 'dlar123', 'Della Rachmatika Noer Intanty', NULL, '', NULL, NULL),
(4, 'llot', 'llot123', 'Della Putri Wahyuni', NULL, '', NULL, NULL),
(5, 'swaa', 'swaa123', 'Niswa Alfiiya', NULL, '', NULL, NULL),
(6, 'cece', 'cece123', 'Wicheriani Galuh Desduipa', 'wiche3012@gmail.com', 'Wanita', '312200419783012', '2024-01-30'),
(8, 'Kenanga I', 'NWTCHBNIFZ', '', NULL, 'Pria', NULL, NULL),
(9, 'Teratai', 'FFLMEKLCCG', '', NULL, 'Pria', NULL, NULL),
(10, 'Nusa Indah', 'YXTBAYOANK', '', NULL, 'Pria', NULL, NULL),
(11, 'Sakura I', 'MFQNUGXWPH', '', NULL, 'Pria', NULL, NULL),
(12, 'Miana I Pos I', 'TUTKUQVGVI', '', NULL, 'Pria', NULL, NULL),
(13, 'Miana II Pos I', 'CPQLJJVAOV', '', NULL, 'Pria', NULL, NULL),
(14, 'Miana III Pos I', 'MVUKQZZYVH', '', NULL, 'Pria', NULL, NULL),
(15, 'Miana IV', 'XRQGHSSLAW', '', NULL, 'Pria', NULL, NULL),
(16, 'Anggrek', 'EHXSWEIDPQ', '', NULL, 'Pria', NULL, NULL),
(17, 'Nusa Indah', 'JVEJHHROQO', '', NULL, 'Pria', NULL, NULL),
(18, 'Budiasih', 'WSYNSDNFLN', '', NULL, 'Pria', NULL, NULL),
(19, 'Ananda 1', 'HZADOJHGIY', '', NULL, 'Pria', NULL, NULL),
(20, 'Cempaka 1', 'TWEGQMNEIB', '', NULL, 'Pria', NULL, NULL),
(21, 'Teratai', 'JQBLCAWIAD', '', NULL, 'Pria', NULL, NULL),
(22, 'Matahari', 'PQKZVDFSWG', '', NULL, 'Pria', NULL, NULL),
(23, 'Anggrek', 'PFGRPZDTHG', '', NULL, 'Pria', NULL, NULL),
(24, 'Kasih', 'CONUNFNYEZ', '', NULL, 'Pria', NULL, NULL),
(25, 'della', 'cece123', '', 'dellaputrw18@gmail.com', 'Pria', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vaksinasi`
--

CREATE TABLE `vaksinasi` (
  `id` int(11) NOT NULL,
  `id_posyandu` int(11) NOT NULL,
  `id_jenis` int(11) NOT NULL,
  `status` enum('unavailable','available') DEFAULT 'unavailable'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vaksinasi`
--

INSERT INTO `vaksinasi` (`id`, `id_posyandu`, `id_jenis`, `status`) VALUES
(1, 17, 1, 'available'),
(2, 17, 2, 'available'),
(3, 17, 3, 'available'),
(4, 17, 4, 'available'),
(5, 17, 5, 'available'),
(6, 17, 6, 'available'),
(7, 17, 7, 'available'),
(8, 17, 8, 'available'),
(9, 17, 9, 'available'),
(10, 17, 10, 'available'),
(11, 17, 11, 'available'),
(12, 17, 12, 'available'),
(13, 17, 13, 'available'),
(14, 17, 14, 'available'),
(15, 17, 15, 'available'),
(16, 17, 16, 'available'),
(17, 17, 17, 'available'),
(18, 17, 18, 'available'),
(19, 17, 19, 'available'),
(20, 17, 20, 'available'),
(21, 17, 21, 'available'),
(22, 17, 22, 'available'),
(23, 17, 23, 'available'),
(24, 17, 24, 'available'),
(25, 17, 25, 'available'),
(26, 17, 26, 'available'),
(27, 17, 27, 'available'),
(28, 17, 28, 'available'),
(29, 17, 29, 'available'),
(30, 17, 30, 'available'),
(31, 17, 31, 'available'),
(32, 17, 32, 'available'),
(33, 17, 33, 'available'),
(34, 17, 34, 'available'),
(35, 17, 35, 'available'),
(36, 17, 36, 'available'),
(37, 17, 37, 'available'),
(38, 17, 38, 'available'),
(39, 18, 1, 'available'),
(40, 18, 2, 'available'),
(41, 18, 3, 'available'),
(42, 18, 4, 'available'),
(43, 18, 5, 'available'),
(44, 18, 6, 'available'),
(45, 18, 7, 'available'),
(46, 18, 8, 'available'),
(47, 18, 9, 'available'),
(48, 18, 10, 'available'),
(49, 18, 11, 'available'),
(50, 18, 12, 'available'),
(51, 18, 13, 'available'),
(52, 18, 14, 'available'),
(53, 18, 15, 'available'),
(54, 18, 16, 'available'),
(55, 18, 17, 'available'),
(56, 18, 18, 'available'),
(57, 18, 19, 'available'),
(58, 18, 20, 'available'),
(59, 18, 21, 'available'),
(60, 18, 22, 'available'),
(61, 18, 23, 'available'),
(62, 18, 24, 'available'),
(63, 18, 25, 'available'),
(64, 18, 26, 'available'),
(65, 18, 27, 'available'),
(66, 18, 28, 'available'),
(67, 18, 29, 'available'),
(68, 18, 30, 'available'),
(69, 18, 31, 'available'),
(70, 18, 32, 'available'),
(71, 18, 33, 'available'),
(72, 18, 34, 'available'),
(73, 18, 35, 'available'),
(74, 18, 36, 'available'),
(75, 18, 37, 'available'),
(76, 18, 38, 'available'),
(77, 19, 1, 'available'),
(78, 19, 2, 'available'),
(79, 19, 3, 'available'),
(80, 19, 4, 'available'),
(81, 19, 5, 'available'),
(82, 19, 6, 'available'),
(83, 19, 7, 'available'),
(84, 19, 8, 'available'),
(85, 19, 9, 'available'),
(86, 19, 10, 'available'),
(87, 19, 11, 'available'),
(88, 19, 12, 'available'),
(89, 19, 13, 'available'),
(90, 19, 14, 'available'),
(91, 19, 15, 'available'),
(92, 19, 16, 'available'),
(93, 19, 17, 'available'),
(94, 19, 18, 'available'),
(95, 19, 19, 'available'),
(96, 19, 20, 'available'),
(97, 19, 21, 'available'),
(98, 19, 22, 'available'),
(99, 19, 23, 'available'),
(100, 19, 24, 'available'),
(101, 19, 25, 'available'),
(102, 19, 26, 'available'),
(103, 19, 27, 'available'),
(104, 19, 28, 'available'),
(105, 19, 29, 'available'),
(106, 19, 30, 'available'),
(107, 19, 31, 'available'),
(108, 19, 32, 'available'),
(109, 19, 33, 'available'),
(110, 19, 34, 'available'),
(111, 19, 35, 'available'),
(112, 19, 36, 'available'),
(113, 19, 37, 'available'),
(114, 19, 38, 'available'),
(115, 20, 1, 'available'),
(116, 20, 2, 'available'),
(117, 20, 3, 'available'),
(118, 20, 4, 'available'),
(119, 20, 5, 'available'),
(120, 20, 6, 'available'),
(121, 20, 7, 'available'),
(122, 20, 8, 'available'),
(123, 20, 9, 'available'),
(124, 20, 10, 'available'),
(125, 20, 11, 'available'),
(126, 20, 12, 'available'),
(127, 20, 13, 'available'),
(128, 20, 14, 'available'),
(129, 20, 15, 'available'),
(130, 20, 16, 'available'),
(131, 20, 17, 'available'),
(132, 20, 18, 'available'),
(133, 20, 19, 'available'),
(134, 20, 20, 'available'),
(135, 20, 21, 'available'),
(136, 20, 22, 'available'),
(137, 20, 23, 'available'),
(138, 20, 24, 'available'),
(139, 20, 25, 'available'),
(140, 20, 26, 'available'),
(141, 20, 27, 'available'),
(142, 20, 28, 'available'),
(143, 20, 29, 'available'),
(144, 20, 30, 'available'),
(145, 20, 31, 'available'),
(146, 20, 32, 'available'),
(147, 20, 33, 'available'),
(148, 20, 34, 'available'),
(149, 20, 35, 'available'),
(150, 20, 36, 'available'),
(151, 20, 37, 'available'),
(152, 20, 38, 'available'),
(153, 21, 1, 'available'),
(154, 21, 2, 'available'),
(155, 21, 3, 'available'),
(156, 21, 4, 'available'),
(157, 21, 5, 'available'),
(158, 21, 6, 'available'),
(159, 21, 7, 'available'),
(160, 21, 8, 'available'),
(161, 21, 9, 'available'),
(162, 21, 10, 'available'),
(163, 21, 11, 'available'),
(164, 21, 12, 'available'),
(165, 21, 13, 'available'),
(166, 21, 14, 'available'),
(167, 21, 15, 'available'),
(168, 21, 16, 'available'),
(169, 21, 17, 'available'),
(170, 21, 18, 'available'),
(171, 21, 19, 'available'),
(172, 21, 20, 'available'),
(173, 21, 21, 'available'),
(174, 21, 22, 'available'),
(175, 21, 23, 'available'),
(176, 21, 24, 'available'),
(177, 21, 25, 'available'),
(178, 21, 26, 'available'),
(179, 21, 27, 'available'),
(180, 21, 28, 'available'),
(181, 21, 29, 'available'),
(182, 21, 30, 'available'),
(183, 21, 31, 'available'),
(184, 21, 32, 'available'),
(185, 21, 33, 'available'),
(186, 21, 34, 'available'),
(187, 21, 35, 'available'),
(188, 21, 36, 'available'),
(189, 21, 37, 'available'),
(190, 21, 38, 'available'),
(191, 22, 1, 'available'),
(192, 22, 2, 'available'),
(193, 22, 3, 'available'),
(194, 22, 4, 'available'),
(195, 22, 5, 'available'),
(196, 22, 6, 'available'),
(197, 22, 7, 'available'),
(198, 22, 8, 'available'),
(199, 22, 9, 'available'),
(200, 22, 10, 'available'),
(201, 22, 11, 'available'),
(202, 22, 12, 'available'),
(203, 22, 13, 'available'),
(204, 22, 14, 'available'),
(205, 22, 15, 'available'),
(206, 22, 16, 'available'),
(207, 22, 17, 'available'),
(208, 22, 18, 'available'),
(209, 22, 19, 'available'),
(210, 22, 20, 'available'),
(211, 22, 21, 'available'),
(212, 22, 22, 'available'),
(213, 22, 23, 'available'),
(214, 22, 24, 'available'),
(215, 22, 25, 'available'),
(216, 22, 26, 'available'),
(217, 22, 27, 'available'),
(218, 22, 28, 'available'),
(219, 22, 29, 'available'),
(220, 22, 30, 'available'),
(221, 22, 31, 'available'),
(222, 22, 32, 'available'),
(223, 22, 33, 'available'),
(224, 22, 34, 'available'),
(225, 22, 35, 'available'),
(226, 22, 36, 'available'),
(227, 22, 37, 'available'),
(228, 22, 38, 'available'),
(229, 23, 1, 'available'),
(230, 23, 2, 'available'),
(231, 23, 3, 'available'),
(232, 23, 4, 'available'),
(233, 23, 5, 'available'),
(234, 23, 6, 'available'),
(235, 23, 7, 'available'),
(236, 23, 8, 'available'),
(237, 23, 9, 'available'),
(238, 23, 10, 'available'),
(239, 23, 11, 'available'),
(240, 23, 12, 'available'),
(241, 23, 13, 'available'),
(242, 23, 14, 'available'),
(243, 23, 15, 'available'),
(244, 23, 16, 'available'),
(245, 23, 17, 'available'),
(246, 23, 18, 'available'),
(247, 23, 19, 'available'),
(248, 23, 20, 'available'),
(249, 23, 21, 'available'),
(250, 23, 22, 'available'),
(251, 23, 23, 'available'),
(252, 23, 24, 'available'),
(253, 23, 25, 'available'),
(254, 23, 26, 'available'),
(255, 23, 27, 'available'),
(256, 23, 28, 'available'),
(257, 23, 29, 'available'),
(258, 23, 30, 'available'),
(259, 23, 31, 'available'),
(260, 23, 32, 'available'),
(261, 23, 33, 'available'),
(262, 23, 34, 'available'),
(263, 23, 35, 'available'),
(264, 23, 36, 'available'),
(265, 23, 37, 'available'),
(266, 23, 38, 'available'),
(267, 24, 1, 'available'),
(268, 24, 2, 'available'),
(269, 24, 3, 'available'),
(270, 24, 4, 'available'),
(271, 24, 5, 'available'),
(272, 24, 6, 'available'),
(273, 24, 7, 'available'),
(274, 24, 8, 'available'),
(275, 24, 9, 'available'),
(276, 24, 10, 'available'),
(277, 24, 11, 'available'),
(278, 24, 12, 'available'),
(279, 24, 13, 'available'),
(280, 24, 14, 'available'),
(281, 24, 15, 'available'),
(282, 24, 16, 'available'),
(283, 24, 17, 'available'),
(284, 24, 18, 'available'),
(285, 24, 19, 'available'),
(286, 24, 20, 'available'),
(287, 24, 21, 'available'),
(288, 24, 22, 'available'),
(289, 24, 23, 'available'),
(290, 24, 24, 'available'),
(291, 24, 25, 'available'),
(292, 24, 26, 'available'),
(293, 24, 27, 'available'),
(294, 24, 28, 'available'),
(295, 24, 29, 'available'),
(296, 24, 30, 'available'),
(297, 24, 31, 'available'),
(298, 24, 32, 'available'),
(299, 24, 33, 'available'),
(300, 24, 34, 'available'),
(301, 24, 35, 'available'),
(302, 24, 36, 'available'),
(303, 24, 37, 'available'),
(304, 24, 38, 'available'),
(305, 25, 1, 'available'),
(306, 25, 2, 'available'),
(307, 25, 3, 'available'),
(308, 25, 4, 'available'),
(309, 25, 5, 'available'),
(310, 25, 6, 'available'),
(311, 25, 7, 'available'),
(312, 25, 8, 'available'),
(313, 25, 9, 'available'),
(314, 25, 10, 'available'),
(315, 25, 11, 'available'),
(316, 25, 12, 'available'),
(317, 25, 13, 'available'),
(318, 25, 14, 'available'),
(319, 25, 15, 'available'),
(320, 25, 16, 'available'),
(321, 25, 17, 'available'),
(322, 25, 18, 'available'),
(323, 25, 19, 'available'),
(324, 25, 20, 'available'),
(325, 25, 21, 'available'),
(326, 25, 22, 'available'),
(327, 25, 23, 'available'),
(328, 25, 24, 'available'),
(329, 25, 25, 'available'),
(330, 25, 26, 'available'),
(331, 25, 27, 'available'),
(332, 25, 28, 'available'),
(333, 25, 29, 'available'),
(334, 25, 30, 'available'),
(335, 25, 31, 'available'),
(336, 25, 32, 'available'),
(337, 25, 33, 'available'),
(338, 25, 34, 'available'),
(339, 25, 35, 'available'),
(340, 25, 36, 'available'),
(341, 25, 37, 'available'),
(342, 25, 38, 'available'),
(343, 26, 1, 'available'),
(344, 26, 2, 'available'),
(345, 26, 3, 'available'),
(346, 26, 4, 'available'),
(347, 26, 5, 'available'),
(348, 26, 6, 'available'),
(349, 26, 7, 'available'),
(350, 26, 8, 'available'),
(351, 26, 9, 'available'),
(352, 26, 10, 'available'),
(353, 26, 11, 'available'),
(354, 26, 12, 'available'),
(355, 26, 13, 'available'),
(356, 26, 14, 'available'),
(357, 26, 15, 'available'),
(358, 26, 16, 'available'),
(359, 26, 17, 'available'),
(360, 26, 18, 'available'),
(361, 26, 19, 'available'),
(362, 26, 20, 'available'),
(363, 26, 21, 'available'),
(364, 26, 22, 'available'),
(365, 26, 23, 'available'),
(366, 26, 24, 'available'),
(367, 26, 25, 'available'),
(368, 26, 26, 'available'),
(369, 26, 27, 'available'),
(370, 26, 28, 'available'),
(371, 26, 29, 'available'),
(372, 26, 30, 'available'),
(373, 26, 31, 'available'),
(374, 26, 32, 'available'),
(375, 26, 33, 'available'),
(376, 26, 34, 'available'),
(377, 26, 35, 'available'),
(378, 26, 36, 'available'),
(379, 26, 37, 'available'),
(380, 26, 38, 'available'),
(381, 27, 1, 'available'),
(382, 27, 2, 'available'),
(383, 27, 3, 'available'),
(384, 27, 4, 'available'),
(385, 27, 5, 'available'),
(386, 27, 6, 'available'),
(387, 27, 7, 'available'),
(388, 27, 8, 'available'),
(389, 27, 9, 'available'),
(390, 27, 10, 'available'),
(391, 27, 11, 'available'),
(392, 27, 12, 'available'),
(393, 27, 13, 'available'),
(394, 27, 14, 'available'),
(395, 27, 15, 'available'),
(396, 27, 16, 'available'),
(397, 27, 17, 'available'),
(398, 27, 18, 'available'),
(399, 27, 19, 'available'),
(400, 27, 20, 'available'),
(401, 27, 21, 'available'),
(402, 27, 22, 'available'),
(403, 27, 23, 'available'),
(404, 27, 24, 'available'),
(405, 27, 25, 'available'),
(406, 27, 26, 'available'),
(407, 27, 27, 'available'),
(408, 27, 28, 'available'),
(409, 27, 29, 'available'),
(410, 27, 30, 'available'),
(411, 27, 31, 'available'),
(412, 27, 32, 'available'),
(413, 27, 33, 'available'),
(414, 27, 34, 'available'),
(415, 27, 35, 'available'),
(416, 27, 36, 'available'),
(417, 27, 37, 'available'),
(418, 27, 38, 'available'),
(419, 28, 1, 'available'),
(420, 28, 2, 'available'),
(421, 28, 3, 'available'),
(422, 28, 4, 'available'),
(423, 28, 5, 'available'),
(424, 28, 6, 'available'),
(425, 28, 7, 'available'),
(426, 28, 8, 'available'),
(427, 28, 9, 'available'),
(428, 28, 10, 'available'),
(429, 28, 11, 'available'),
(430, 28, 12, 'available'),
(431, 28, 13, 'available'),
(432, 28, 14, 'available'),
(433, 28, 15, 'available'),
(434, 28, 16, 'available'),
(435, 28, 17, 'available'),
(436, 28, 18, 'available'),
(437, 28, 19, 'available'),
(438, 28, 20, 'available'),
(439, 28, 21, 'available'),
(440, 28, 22, 'available'),
(441, 28, 23, 'available'),
(442, 28, 24, 'available'),
(443, 28, 25, 'available'),
(444, 28, 26, 'available'),
(445, 28, 27, 'available'),
(446, 28, 28, 'available'),
(447, 28, 29, 'available'),
(448, 28, 30, 'available'),
(449, 28, 31, 'available'),
(450, 28, 32, 'available'),
(451, 28, 33, 'available'),
(452, 28, 34, 'available'),
(453, 28, 35, 'available'),
(454, 28, 36, 'available'),
(455, 28, 37, 'available'),
(456, 28, 38, 'available'),
(457, 29, 1, 'available'),
(458, 29, 2, 'available'),
(459, 29, 3, 'available'),
(460, 29, 4, 'available'),
(461, 29, 5, 'available'),
(462, 29, 6, 'available'),
(463, 29, 7, 'available'),
(464, 29, 8, 'available'),
(465, 29, 9, 'available'),
(466, 29, 10, 'available'),
(467, 29, 11, 'available'),
(468, 29, 12, 'available'),
(469, 29, 13, 'available'),
(470, 29, 14, 'available'),
(471, 29, 15, 'available'),
(472, 29, 16, 'available'),
(473, 29, 17, 'available'),
(474, 29, 18, 'available'),
(475, 29, 19, 'available'),
(476, 29, 20, 'available'),
(477, 29, 21, 'available'),
(478, 29, 22, 'available'),
(479, 29, 23, 'available'),
(480, 29, 24, 'available'),
(481, 29, 25, 'available'),
(482, 29, 26, 'available'),
(483, 29, 27, 'available'),
(484, 29, 28, 'available'),
(485, 29, 29, 'available'),
(486, 29, 30, 'available'),
(487, 29, 31, 'available'),
(488, 29, 32, 'available'),
(489, 29, 33, 'available'),
(490, 29, 34, 'available'),
(491, 29, 35, 'available'),
(492, 29, 36, 'available'),
(493, 29, 37, 'available'),
(494, 29, 38, 'available'),
(495, 30, 1, 'available'),
(496, 30, 2, 'available'),
(497, 30, 3, 'available'),
(498, 30, 4, 'available'),
(499, 30, 5, 'available'),
(500, 30, 6, 'available'),
(501, 30, 7, 'available'),
(502, 30, 8, 'available'),
(503, 30, 9, 'available'),
(504, 30, 10, 'available'),
(505, 30, 11, 'available'),
(506, 30, 12, 'available'),
(507, 30, 13, 'available'),
(508, 30, 14, 'available'),
(509, 30, 15, 'available'),
(510, 30, 16, 'available'),
(511, 30, 17, 'available'),
(512, 30, 18, 'available'),
(513, 30, 19, 'available'),
(514, 30, 20, 'available'),
(515, 30, 21, 'available'),
(516, 30, 22, 'available'),
(517, 30, 23, 'available'),
(518, 30, 24, 'available'),
(519, 30, 25, 'available'),
(520, 30, 26, 'available'),
(521, 30, 27, 'available'),
(522, 30, 28, 'available'),
(523, 30, 29, 'available'),
(524, 30, 30, 'available'),
(525, 30, 31, 'available'),
(526, 30, 32, 'available'),
(527, 30, 33, 'available'),
(528, 30, 34, 'available'),
(529, 30, 35, 'available'),
(530, 30, 36, 'available'),
(531, 30, 37, 'available'),
(532, 30, 38, 'available'),
(533, 31, 1, 'available'),
(534, 31, 2, 'available'),
(535, 31, 3, 'available'),
(536, 31, 4, 'available'),
(537, 31, 5, 'available'),
(538, 31, 6, 'available'),
(539, 31, 7, 'available'),
(540, 31, 8, 'available'),
(541, 31, 9, 'available'),
(542, 31, 10, 'available'),
(543, 31, 11, 'available'),
(544, 31, 12, 'available'),
(545, 31, 13, 'available'),
(546, 31, 14, 'available'),
(547, 31, 15, 'available'),
(548, 31, 16, 'available'),
(549, 31, 17, 'available'),
(550, 31, 18, 'available'),
(551, 31, 19, 'available'),
(552, 31, 20, 'available'),
(553, 31, 21, 'available'),
(554, 31, 22, 'available'),
(555, 31, 23, 'available'),
(556, 31, 24, 'available'),
(557, 31, 25, 'available'),
(558, 31, 26, 'available'),
(559, 31, 27, 'available'),
(560, 31, 28, 'available'),
(561, 31, 29, 'available'),
(562, 31, 30, 'available'),
(563, 31, 31, 'available'),
(564, 31, 32, 'available'),
(565, 31, 33, 'available'),
(566, 31, 34, 'available'),
(567, 31, 35, 'available'),
(568, 31, 36, 'available'),
(569, 31, 37, 'available'),
(570, 31, 38, 'available'),
(571, 32, 1, 'available'),
(572, 32, 2, 'available'),
(573, 32, 3, 'available'),
(574, 32, 4, 'available'),
(575, 32, 5, 'available'),
(576, 32, 6, 'available'),
(577, 32, 7, 'available'),
(578, 32, 8, 'available'),
(579, 32, 9, 'available'),
(580, 32, 10, 'available'),
(581, 32, 11, 'available'),
(582, 32, 12, 'available'),
(583, 32, 13, 'available'),
(584, 32, 14, 'available'),
(585, 32, 15, 'available'),
(586, 32, 16, 'available'),
(587, 32, 17, 'available'),
(588, 32, 18, 'available'),
(589, 32, 19, 'available'),
(590, 32, 20, 'available'),
(591, 32, 21, 'available'),
(592, 32, 22, 'available'),
(593, 32, 23, 'available'),
(594, 32, 24, 'available'),
(595, 32, 25, 'available'),
(596, 32, 26, 'available'),
(597, 32, 27, 'available'),
(598, 32, 28, 'available'),
(599, 32, 29, 'available'),
(600, 32, 30, 'available'),
(601, 32, 31, 'available'),
(602, 32, 32, 'available'),
(603, 32, 33, 'available'),
(604, 32, 34, 'available'),
(605, 32, 35, 'available'),
(606, 32, 36, 'available'),
(607, 32, 37, 'available'),
(608, 32, 38, 'available'),
(609, 33, 1, 'unavailable'),
(610, 33, 2, 'unavailable'),
(611, 33, 3, 'unavailable'),
(612, 33, 4, 'unavailable'),
(613, 33, 5, 'unavailable'),
(614, 33, 6, 'unavailable'),
(615, 33, 7, 'unavailable'),
(616, 33, 8, 'unavailable'),
(617, 33, 9, 'unavailable'),
(618, 33, 10, 'unavailable'),
(619, 33, 11, 'unavailable'),
(620, 33, 12, 'unavailable'),
(621, 33, 13, 'unavailable'),
(622, 33, 14, 'unavailable'),
(623, 33, 15, 'unavailable'),
(624, 33, 16, 'unavailable'),
(625, 33, 17, 'unavailable'),
(626, 33, 18, 'unavailable'),
(627, 33, 19, 'unavailable'),
(628, 33, 20, 'unavailable'),
(629, 33, 21, 'unavailable'),
(630, 33, 22, 'unavailable'),
(631, 33, 23, 'unavailable'),
(632, 33, 24, 'unavailable'),
(633, 33, 25, 'unavailable'),
(634, 33, 26, 'unavailable'),
(635, 33, 27, 'unavailable'),
(636, 33, 28, 'unavailable'),
(637, 33, 29, 'unavailable'),
(638, 33, 30, 'unavailable'),
(639, 33, 31, 'unavailable'),
(640, 33, 32, 'unavailable'),
(641, 33, 33, 'unavailable'),
(642, 33, 34, 'unavailable'),
(643, 33, 35, 'unavailable'),
(644, 33, 36, 'unavailable'),
(645, 33, 37, 'unavailable'),
(646, 33, 38, 'unavailable');

-- --------------------------------------------------------

--
-- Table structure for table `vaksin_anak`
--

CREATE TABLE `vaksin_anak` (
  `id` int(11) NOT NULL,
  `id_anak` int(11) DEFAULT NULL,
  `id_posyandu` int(11) DEFAULT NULL,
  `id_jenis` int(11) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `status` enum('sudah','belum') DEFAULT 'belum'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vaksin_anak`
--

INSERT INTO `vaksin_anak` (`id`, `id_anak`, `id_posyandu`, `id_jenis`, `tanggal`, `status`) VALUES
(1, 1, 18, 1, '2024-06-29', 'sudah'),
(2, 1, NULL, 2, NULL, 'belum'),
(3, 1, NULL, 3, NULL, 'belum'),
(4, 1, NULL, 4, NULL, 'belum'),
(5, 1, NULL, 5, NULL, 'belum'),
(6, 1, NULL, 6, NULL, 'belum'),
(7, 1, NULL, 7, NULL, 'belum'),
(8, 1, NULL, 8, NULL, 'belum'),
(9, 1, NULL, 9, NULL, 'belum'),
(10, 1, NULL, 10, NULL, 'belum'),
(11, 1, 18, 11, '2024-06-19', 'sudah'),
(12, 1, NULL, 12, NULL, 'belum'),
(13, 1, NULL, 13, NULL, 'belum'),
(14, 1, NULL, 14, NULL, 'belum'),
(15, 1, NULL, 15, NULL, 'belum'),
(16, 1, 18, 16, '2024-06-24', 'sudah'),
(17, 1, NULL, 17, NULL, 'belum'),
(18, 1, NULL, 18, NULL, 'belum'),
(19, 1, NULL, 19, NULL, 'belum'),
(20, 1, NULL, 20, NULL, 'belum'),
(21, 1, NULL, 21, NULL, 'belum'),
(22, 1, NULL, 22, NULL, 'belum'),
(23, 1, NULL, 23, NULL, 'belum'),
(24, 1, NULL, 24, NULL, 'belum'),
(25, 1, NULL, 25, NULL, 'belum'),
(26, 1, NULL, 26, NULL, 'belum'),
(27, 1, NULL, 27, NULL, 'belum'),
(28, 1, NULL, 28, NULL, 'belum'),
(29, 1, NULL, 29, NULL, 'belum'),
(30, 1, NULL, 30, NULL, 'belum'),
(31, 1, NULL, 31, NULL, 'belum'),
(32, 1, NULL, 32, NULL, 'belum'),
(33, 1, NULL, 33, NULL, 'belum'),
(34, 1, NULL, 34, NULL, 'belum'),
(35, 1, NULL, 35, NULL, 'belum'),
(36, 1, NULL, 36, NULL, 'belum'),
(37, 1, NULL, 37, NULL, 'belum'),
(38, 1, NULL, 38, NULL, 'belum'),
(39, 2, NULL, 1, NULL, 'belum'),
(40, 2, NULL, 2, NULL, 'belum'),
(41, 2, 18, 3, '2024-06-15', 'sudah'),
(42, 2, NULL, 4, NULL, 'belum'),
(43, 2, NULL, 5, NULL, 'belum'),
(44, 2, NULL, 6, NULL, 'belum'),
(45, 2, NULL, 7, NULL, 'belum'),
(46, 2, NULL, 8, NULL, 'belum'),
(47, 2, NULL, 9, NULL, 'belum'),
(48, 2, NULL, 10, NULL, 'belum'),
(49, 2, 18, 11, '2024-06-24', 'sudah'),
(50, 2, NULL, 12, NULL, 'belum'),
(51, 2, NULL, 13, NULL, 'belum'),
(52, 2, NULL, 14, NULL, 'belum'),
(53, 2, NULL, 15, NULL, 'belum'),
(54, 2, 18, 16, '2024-06-29', 'sudah'),
(55, 2, NULL, 17, NULL, 'belum'),
(56, 2, NULL, 18, NULL, 'belum'),
(57, 2, NULL, 19, NULL, 'belum'),
(58, 2, NULL, 20, NULL, 'belum'),
(59, 2, NULL, 21, NULL, 'belum'),
(60, 2, NULL, 22, NULL, 'belum'),
(61, 2, NULL, 23, NULL, 'belum'),
(62, 2, NULL, 24, NULL, 'belum'),
(63, 2, NULL, 25, NULL, 'belum'),
(64, 2, NULL, 26, NULL, 'belum'),
(65, 2, NULL, 27, NULL, 'belum'),
(66, 2, NULL, 28, NULL, 'belum'),
(67, 2, NULL, 29, NULL, 'belum'),
(68, 2, NULL, 30, NULL, 'belum'),
(69, 2, NULL, 31, NULL, 'belum'),
(70, 2, NULL, 32, NULL, 'belum'),
(71, 2, NULL, 33, NULL, 'belum'),
(72, 2, NULL, 34, NULL, 'belum'),
(73, 2, NULL, 35, NULL, 'belum'),
(74, 2, NULL, 36, NULL, 'belum'),
(75, 2, NULL, 37, NULL, 'belum'),
(76, 2, NULL, 38, NULL, 'belum'),
(77, 3, NULL, 1, NULL, 'belum'),
(78, 3, NULL, 2, NULL, 'belum'),
(79, 3, NULL, 3, NULL, 'belum'),
(80, 3, NULL, 4, NULL, 'belum'),
(81, 3, NULL, 5, NULL, 'belum'),
(82, 3, NULL, 6, NULL, 'belum'),
(83, 3, NULL, 7, NULL, 'belum'),
(84, 3, NULL, 8, NULL, 'belum'),
(85, 3, 18, 9, '2024-07-06', 'sudah'),
(86, 3, NULL, 10, NULL, 'belum'),
(87, 3, NULL, 11, NULL, 'belum'),
(88, 3, NULL, 12, NULL, 'belum'),
(89, 3, NULL, 13, NULL, 'belum'),
(90, 3, 18, 14, '2024-06-27', 'sudah'),
(91, 3, NULL, 15, NULL, 'belum'),
(92, 3, NULL, 16, NULL, 'belum'),
(93, 3, NULL, 17, NULL, 'belum'),
(94, 3, NULL, 18, NULL, 'belum'),
(95, 3, NULL, 19, NULL, 'belum'),
(96, 3, NULL, 20, NULL, 'belum'),
(97, 3, NULL, 21, NULL, 'belum'),
(98, 3, NULL, 22, NULL, 'belum'),
(99, 3, NULL, 23, NULL, 'belum'),
(100, 3, NULL, 24, NULL, 'belum'),
(101, 3, NULL, 25, NULL, 'belum'),
(102, 3, NULL, 26, NULL, 'belum'),
(103, 3, NULL, 27, NULL, 'belum'),
(104, 3, NULL, 28, NULL, 'belum'),
(105, 3, NULL, 29, NULL, 'belum'),
(106, 3, NULL, 30, NULL, 'belum'),
(107, 3, NULL, 31, NULL, 'belum'),
(108, 3, NULL, 32, NULL, 'belum'),
(109, 3, NULL, 33, NULL, 'belum'),
(110, 3, NULL, 34, NULL, 'belum'),
(111, 3, NULL, 35, NULL, 'belum'),
(112, 3, NULL, 36, NULL, 'belum'),
(113, 3, NULL, 37, NULL, 'belum'),
(114, 3, NULL, 38, NULL, 'belum'),
(115, 4, NULL, 1, NULL, 'belum'),
(116, 4, NULL, 2, NULL, 'belum'),
(117, 4, NULL, 3, NULL, 'belum'),
(118, 4, NULL, 4, NULL, 'belum'),
(119, 4, NULL, 5, NULL, 'belum'),
(120, 4, NULL, 6, NULL, 'belum'),
(121, 4, NULL, 7, NULL, 'belum'),
(122, 4, NULL, 8, NULL, 'belum'),
(123, 4, NULL, 9, NULL, 'belum'),
(124, 4, NULL, 10, NULL, 'belum'),
(125, 4, 18, 11, '2024-07-02', 'sudah'),
(126, 4, NULL, 12, NULL, 'belum'),
(127, 4, NULL, 13, NULL, 'belum'),
(128, 4, NULL, 14, NULL, 'belum'),
(129, 4, NULL, 15, NULL, 'belum'),
(130, 4, 18, 16, '2024-06-29', 'sudah'),
(131, 4, NULL, 17, NULL, 'belum'),
(132, 4, NULL, 18, NULL, 'belum'),
(133, 4, NULL, 19, NULL, 'belum'),
(134, 4, NULL, 20, NULL, 'belum'),
(135, 4, NULL, 21, NULL, 'belum'),
(136, 4, NULL, 22, NULL, 'belum'),
(137, 4, NULL, 23, NULL, 'belum'),
(138, 4, NULL, 24, NULL, 'belum'),
(139, 4, NULL, 25, NULL, 'belum'),
(140, 4, NULL, 26, NULL, 'belum'),
(141, 4, NULL, 27, NULL, 'belum'),
(142, 4, NULL, 28, NULL, 'belum'),
(143, 4, NULL, 29, NULL, 'belum'),
(144, 4, NULL, 30, NULL, 'belum'),
(145, 4, NULL, 31, NULL, 'belum'),
(146, 4, NULL, 32, NULL, 'belum'),
(147, 4, NULL, 33, NULL, 'belum'),
(148, 4, NULL, 34, NULL, 'belum'),
(149, 4, NULL, 35, NULL, 'belum'),
(150, 4, NULL, 36, NULL, 'belum'),
(151, 4, NULL, 37, NULL, 'belum'),
(152, 4, NULL, 38, NULL, 'belum'),
(153, 5, NULL, 1, NULL, 'belum'),
(154, 5, NULL, 2, NULL, 'belum'),
(155, 5, NULL, 3, NULL, 'belum'),
(156, 5, NULL, 4, NULL, 'belum'),
(157, 5, NULL, 5, NULL, 'belum'),
(158, 5, NULL, 6, NULL, 'belum'),
(159, 5, NULL, 7, NULL, 'belum'),
(160, 5, NULL, 8, NULL, 'belum'),
(161, 5, NULL, 9, NULL, 'belum'),
(162, 5, NULL, 10, NULL, 'belum'),
(163, 5, NULL, 11, NULL, 'belum'),
(164, 5, 18, 12, '2024-06-23', 'sudah'),
(165, 5, NULL, 13, NULL, 'belum'),
(166, 5, NULL, 14, NULL, 'belum'),
(167, 5, NULL, 15, NULL, 'belum'),
(168, 5, NULL, 16, NULL, 'belum'),
(169, 5, NULL, 17, NULL, 'belum'),
(170, 5, NULL, 18, NULL, 'belum'),
(171, 5, NULL, 19, NULL, 'belum'),
(172, 5, NULL, 20, NULL, 'belum'),
(173, 5, NULL, 21, NULL, 'belum'),
(174, 5, NULL, 22, NULL, 'belum'),
(175, 5, NULL, 23, NULL, 'belum'),
(176, 5, NULL, 24, NULL, 'belum'),
(177, 5, NULL, 25, NULL, 'belum'),
(178, 5, NULL, 26, NULL, 'belum'),
(179, 5, NULL, 27, NULL, 'belum'),
(180, 5, NULL, 28, NULL, 'belum'),
(181, 5, NULL, 29, NULL, 'belum'),
(182, 5, NULL, 30, NULL, 'belum'),
(183, 5, NULL, 31, NULL, 'belum'),
(184, 5, NULL, 32, NULL, 'belum'),
(185, 5, NULL, 33, NULL, 'belum'),
(186, 5, NULL, 34, NULL, 'belum'),
(187, 5, NULL, 35, NULL, 'belum'),
(188, 5, NULL, 36, NULL, 'belum'),
(189, 5, NULL, 37, NULL, 'belum'),
(190, 5, NULL, 38, NULL, 'belum'),
(191, 6, NULL, 1, NULL, 'belum'),
(192, 6, NULL, 2, NULL, 'belum'),
(193, 6, NULL, 3, NULL, 'belum'),
(194, 6, NULL, 4, NULL, 'belum'),
(195, 6, NULL, 5, NULL, 'belum'),
(196, 6, NULL, 6, NULL, 'belum'),
(197, 6, NULL, 7, NULL, 'belum'),
(198, 6, NULL, 8, NULL, 'belum'),
(199, 6, NULL, 9, NULL, 'belum'),
(200, 6, NULL, 10, NULL, 'belum'),
(201, 6, NULL, 11, NULL, 'belum'),
(202, 6, NULL, 12, NULL, 'belum'),
(203, 6, 18, 13, '2024-06-23', 'sudah'),
(204, 6, 18, 14, '2024-07-02', 'sudah'),
(205, 6, NULL, 15, NULL, 'belum'),
(206, 6, NULL, 16, NULL, 'belum'),
(207, 6, NULL, 17, NULL, 'belum'),
(208, 6, NULL, 18, NULL, 'belum'),
(209, 6, NULL, 19, NULL, 'belum'),
(210, 6, NULL, 20, NULL, 'belum'),
(211, 6, NULL, 21, NULL, 'belum'),
(212, 6, NULL, 22, NULL, 'belum'),
(213, 6, NULL, 23, NULL, 'belum'),
(214, 6, NULL, 24, NULL, 'belum'),
(215, 6, NULL, 25, NULL, 'belum'),
(216, 6, NULL, 26, NULL, 'belum'),
(217, 6, NULL, 27, NULL, 'belum'),
(218, 6, NULL, 28, NULL, 'belum'),
(219, 6, NULL, 29, NULL, 'belum'),
(220, 6, NULL, 30, NULL, 'belum'),
(221, 6, NULL, 31, NULL, 'belum'),
(222, 6, NULL, 32, NULL, 'belum'),
(223, 6, NULL, 33, NULL, 'belum'),
(224, 6, NULL, 34, NULL, 'belum'),
(225, 6, NULL, 35, NULL, 'belum'),
(226, 6, NULL, 36, NULL, 'belum'),
(227, 6, NULL, 37, NULL, 'belum'),
(228, 6, NULL, 38, NULL, 'belum'),
(229, 7, NULL, 1, NULL, 'belum'),
(230, 7, NULL, 2, NULL, 'belum'),
(231, 7, NULL, 3, NULL, 'belum'),
(232, 7, NULL, 4, NULL, 'belum'),
(233, 7, NULL, 5, NULL, 'belum'),
(234, 7, NULL, 6, NULL, 'belum'),
(235, 7, NULL, 7, NULL, 'belum'),
(236, 7, 18, 8, '2024-06-24', 'sudah'),
(237, 7, 18, 9, '2024-06-29', 'sudah'),
(238, 7, NULL, 10, NULL, 'belum'),
(239, 7, NULL, 11, NULL, 'belum'),
(240, 7, NULL, 12, NULL, 'belum'),
(241, 7, NULL, 13, NULL, 'belum'),
(242, 7, NULL, 14, NULL, 'belum'),
(243, 7, NULL, 15, NULL, 'belum'),
(244, 7, 18, 16, '2024-06-17', 'sudah'),
(245, 7, NULL, 17, NULL, 'belum'),
(246, 7, NULL, 18, NULL, 'belum'),
(247, 7, NULL, 19, NULL, 'belum'),
(248, 7, NULL, 20, NULL, 'belum'),
(249, 7, NULL, 21, NULL, 'belum'),
(250, 7, NULL, 22, NULL, 'belum'),
(251, 7, NULL, 23, NULL, 'belum'),
(252, 7, NULL, 24, NULL, 'belum'),
(253, 7, NULL, 25, NULL, 'belum'),
(254, 7, NULL, 26, NULL, 'belum'),
(255, 7, NULL, 27, NULL, 'belum'),
(256, 7, NULL, 28, NULL, 'belum'),
(257, 7, NULL, 29, NULL, 'belum'),
(258, 7, NULL, 30, NULL, 'belum'),
(259, 7, NULL, 31, NULL, 'belum'),
(260, 7, NULL, 32, NULL, 'belum'),
(261, 7, NULL, 33, NULL, 'belum'),
(262, 7, NULL, 34, NULL, 'belum'),
(263, 7, NULL, 35, NULL, 'belum'),
(264, 7, NULL, 36, NULL, 'belum'),
(265, 7, NULL, 37, NULL, 'belum'),
(266, 7, NULL, 38, NULL, 'belum'),
(267, 8, NULL, 1, NULL, 'belum'),
(268, 8, NULL, 2, NULL, 'belum'),
(269, 8, NULL, 3, NULL, 'belum'),
(270, 8, NULL, 4, NULL, 'belum'),
(271, 8, NULL, 5, NULL, 'belum'),
(272, 8, NULL, 6, NULL, 'belum'),
(273, 8, NULL, 7, NULL, 'belum'),
(274, 8, NULL, 8, NULL, 'belum'),
(275, 8, NULL, 9, NULL, 'belum'),
(276, 8, NULL, 10, NULL, 'belum'),
(277, 8, NULL, 11, NULL, 'belum'),
(278, 8, NULL, 12, NULL, 'belum'),
(279, 8, NULL, 13, NULL, 'belum'),
(280, 8, NULL, 14, NULL, 'belum'),
(281, 8, NULL, 15, NULL, 'belum'),
(282, 8, NULL, 16, NULL, 'belum'),
(283, 8, NULL, 17, NULL, 'belum'),
(284, 8, NULL, 18, NULL, 'belum'),
(285, 8, NULL, 19, NULL, 'belum'),
(286, 8, NULL, 20, NULL, 'belum'),
(287, 8, NULL, 21, NULL, 'belum'),
(288, 8, NULL, 22, NULL, 'belum'),
(289, 8, NULL, 23, NULL, 'belum'),
(290, 8, NULL, 24, NULL, 'belum'),
(291, 8, NULL, 25, NULL, 'belum'),
(292, 8, NULL, 26, NULL, 'belum'),
(293, 8, NULL, 27, NULL, 'belum'),
(294, 8, NULL, 28, NULL, 'belum'),
(295, 8, NULL, 29, NULL, 'belum'),
(296, 8, NULL, 30, NULL, 'belum'),
(297, 8, NULL, 31, NULL, 'belum'),
(298, 8, NULL, 32, NULL, 'belum'),
(299, 8, NULL, 33, NULL, 'belum'),
(300, 8, NULL, 34, NULL, 'belum'),
(301, 8, NULL, 35, NULL, 'belum'),
(302, 8, NULL, 36, NULL, 'belum'),
(303, 8, NULL, 37, NULL, 'belum'),
(304, 8, NULL, 38, NULL, 'belum'),
(305, 9, NULL, 1, NULL, 'belum'),
(306, 9, NULL, 2, NULL, 'belum'),
(307, 9, NULL, 3, NULL, 'belum'),
(308, 9, NULL, 4, NULL, 'belum'),
(309, 9, NULL, 5, NULL, 'belum'),
(310, 9, NULL, 6, NULL, 'belum'),
(311, 9, NULL, 7, NULL, 'belum'),
(312, 9, NULL, 8, NULL, 'belum'),
(313, 9, NULL, 9, NULL, 'belum'),
(314, 9, NULL, 10, NULL, 'belum'),
(315, 9, 18, 11, '2024-07-04', 'sudah'),
(316, 9, NULL, 12, NULL, 'belum'),
(317, 9, NULL, 13, NULL, 'belum'),
(318, 9, NULL, 14, NULL, 'belum'),
(319, 9, NULL, 15, NULL, 'belum'),
(320, 9, 18, 16, '2024-06-27', 'sudah'),
(321, 9, NULL, 17, NULL, 'belum'),
(322, 9, 18, 18, '2024-07-03', 'sudah'),
(323, 9, 18, 19, '2024-06-08', 'sudah'),
(324, 9, NULL, 20, NULL, 'belum'),
(325, 9, NULL, 21, NULL, 'belum'),
(326, 9, NULL, 22, NULL, 'belum'),
(327, 9, NULL, 23, NULL, 'belum'),
(328, 9, NULL, 24, NULL, 'belum'),
(329, 9, NULL, 25, NULL, 'belum'),
(330, 9, NULL, 26, NULL, 'belum'),
(331, 9, NULL, 27, NULL, 'belum'),
(332, 9, NULL, 28, NULL, 'belum'),
(333, 9, NULL, 29, NULL, 'belum'),
(334, 9, NULL, 30, NULL, 'belum'),
(335, 9, NULL, 31, NULL, 'belum'),
(336, 9, NULL, 32, NULL, 'belum'),
(337, 9, NULL, 33, NULL, 'belum'),
(338, 9, NULL, 34, NULL, 'belum'),
(339, 9, NULL, 35, NULL, 'belum'),
(340, 9, NULL, 36, NULL, 'belum'),
(341, 9, NULL, 37, NULL, 'belum'),
(342, 9, NULL, 38, NULL, 'belum'),
(343, 10, 18, 1, '2024-07-04', 'sudah'),
(344, 10, NULL, 2, NULL, 'belum'),
(345, 10, NULL, 3, NULL, 'belum'),
(346, 10, NULL, 4, NULL, 'belum'),
(347, 10, NULL, 5, NULL, 'belum'),
(348, 10, NULL, 6, NULL, 'belum'),
(349, 10, NULL, 7, NULL, 'belum'),
(350, 10, NULL, 8, NULL, 'belum'),
(351, 10, NULL, 9, NULL, 'belum'),
(352, 10, NULL, 10, NULL, 'belum'),
(353, 10, NULL, 11, NULL, 'belum'),
(354, 10, 18, 12, '2024-06-26', 'sudah'),
(355, 10, NULL, 13, NULL, 'belum'),
(356, 10, 18, 14, '2024-07-01', 'sudah'),
(357, 10, NULL, 15, NULL, 'belum'),
(358, 10, 18, 16, '2024-07-05', 'sudah'),
(359, 10, NULL, 17, NULL, 'belum'),
(360, 10, NULL, 18, NULL, 'belum'),
(361, 10, NULL, 19, NULL, 'belum'),
(362, 10, NULL, 20, NULL, 'belum'),
(363, 10, NULL, 21, NULL, 'belum'),
(364, 10, NULL, 22, NULL, 'belum'),
(365, 10, NULL, 23, NULL, 'belum'),
(366, 10, NULL, 24, NULL, 'belum'),
(367, 10, NULL, 25, NULL, 'belum'),
(368, 10, NULL, 26, NULL, 'belum'),
(369, 10, NULL, 27, NULL, 'belum'),
(370, 10, NULL, 28, NULL, 'belum'),
(371, 10, NULL, 29, NULL, 'belum'),
(372, 10, NULL, 30, NULL, 'belum'),
(373, 10, NULL, 31, NULL, 'belum'),
(374, 10, NULL, 32, NULL, 'belum'),
(375, 10, NULL, 33, NULL, 'belum'),
(376, 10, NULL, 34, NULL, 'belum'),
(377, 10, NULL, 35, NULL, 'belum'),
(378, 10, NULL, 36, NULL, 'belum'),
(379, 10, NULL, 37, NULL, 'belum'),
(380, 10, 18, 38, '2024-06-30', 'sudah'),
(381, 11, NULL, 1, NULL, 'belum'),
(382, 11, NULL, 2, NULL, 'belum'),
(383, 11, NULL, 3, NULL, 'belum'),
(384, 11, NULL, 4, NULL, 'belum'),
(385, 11, NULL, 5, NULL, 'belum'),
(386, 11, NULL, 6, NULL, 'belum'),
(387, 11, NULL, 7, NULL, 'belum'),
(388, 11, NULL, 8, NULL, 'belum'),
(389, 11, NULL, 9, NULL, 'belum'),
(390, 11, NULL, 10, NULL, 'belum'),
(391, 11, NULL, 11, NULL, 'belum'),
(392, 11, NULL, 12, NULL, 'belum'),
(393, 11, NULL, 13, NULL, 'belum'),
(394, 11, NULL, 14, NULL, 'belum'),
(395, 11, NULL, 15, NULL, 'belum'),
(396, 11, NULL, 16, NULL, 'belum'),
(397, 11, NULL, 17, NULL, 'belum'),
(398, 11, NULL, 18, NULL, 'belum'),
(399, 11, NULL, 19, NULL, 'belum'),
(400, 11, NULL, 20, NULL, 'belum'),
(401, 11, NULL, 21, NULL, 'belum'),
(402, 11, NULL, 22, NULL, 'belum'),
(403, 11, NULL, 23, NULL, 'belum'),
(404, 11, NULL, 24, NULL, 'belum'),
(405, 11, NULL, 25, NULL, 'belum'),
(406, 11, NULL, 26, NULL, 'belum'),
(407, 11, NULL, 27, NULL, 'belum'),
(408, 11, NULL, 28, NULL, 'belum'),
(409, 11, NULL, 29, NULL, 'belum'),
(410, 11, NULL, 30, NULL, 'belum'),
(411, 11, NULL, 31, NULL, 'belum'),
(412, 11, NULL, 32, NULL, 'belum'),
(413, 11, NULL, 33, NULL, 'belum'),
(414, 11, NULL, 34, NULL, 'belum'),
(415, 11, NULL, 35, NULL, 'belum'),
(416, 11, NULL, 36, NULL, 'belum'),
(417, 11, NULL, 37, NULL, 'belum'),
(418, 11, NULL, 38, NULL, 'belum');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `anaks`
--
ALTER TABLE `anaks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `artikel`
--
ALTER TABLE `artikel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jenis_vaksin`
--
ALTER TABLE `jenis_vaksin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posyandu`
--
ALTER TABLE `posyandu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_account`
--
ALTER TABLE `user_account`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vaksinasi`
--
ALTER TABLE `vaksinasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_posyandu` (`id_posyandu`),
  ADD KEY `id_jenis` (`id_jenis`);

--
-- Indexes for table `vaksin_anak`
--
ALTER TABLE `vaksin_anak`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_anak` (`id_anak`),
  ADD KEY `id_posyandu` (`id_posyandu`),
  ADD KEY `id_jenis` (`id_jenis`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `anaks`
--
ALTER TABLE `anaks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `artikel`
--
ALTER TABLE `artikel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `jenis_vaksin`
--
ALTER TABLE `jenis_vaksin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `posyandu`
--
ALTER TABLE `posyandu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `user_account`
--
ALTER TABLE `user_account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `vaksinasi`
--
ALTER TABLE `vaksinasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=647;

--
-- AUTO_INCREMENT for table `vaksin_anak`
--
ALTER TABLE `vaksin_anak`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=419;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `anaks`
--
ALTER TABLE `anaks`
  ADD CONSTRAINT `anaks_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user_account` (`id`);

--
-- Constraints for table `vaksinasi`
--
ALTER TABLE `vaksinasi`
  ADD CONSTRAINT `vaksinasi_ibfk_1` FOREIGN KEY (`id_posyandu`) REFERENCES `posyandu` (`id`),
  ADD CONSTRAINT `vaksinasi_ibfk_2` FOREIGN KEY (`id_jenis`) REFERENCES `jenis_vaksin` (`id`);

--
-- Constraints for table `vaksin_anak`
--
ALTER TABLE `vaksin_anak`
  ADD CONSTRAINT `vaksin_anak_ibfk_1` FOREIGN KEY (`id_anak`) REFERENCES `anaks` (`id`),
  ADD CONSTRAINT `vaksin_anak_ibfk_2` FOREIGN KEY (`id_posyandu`) REFERENCES `posyandu` (`id`),
  ADD CONSTRAINT `vaksin_anak_ibfk_3` FOREIGN KEY (`id_jenis`) REFERENCES `jenis_vaksin` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
