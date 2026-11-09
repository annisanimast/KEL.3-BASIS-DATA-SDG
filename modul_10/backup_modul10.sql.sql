-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 09, 2026 at 05:07 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `si_bantu`
--

-- --------------------------------------------------------

--
-- Table structure for table `berkas_pendaftaran`
--

CREATE TABLE `berkas_pendaftaran` (
  `id_berkas` varchar(10) NOT NULL,
  `id_pendaftaran` varchar(10) NOT NULL,
  `nama_berkas` varchar(100) NOT NULL,
  `file_berkas` varchar(255) NOT NULL,
  `tanggal_upload` date DEFAULT NULL,
  `status_verifikasi` varchar(30) DEFAULT 'Menunggu'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `berkas_pendaftaran`
--

INSERT INTO `berkas_pendaftaran` (`id_berkas`, `id_pendaftaran`, `nama_berkas`, `file_berkas`, `tanggal_upload`, `status_verifikasi`) VALUES
('B001', 'P001', 'Kartu Tanda Mahasiswa', 'ktm_akbar.pdf', '2026-10-01', 'Terverifikasi'),
('B002', 'P001', 'Kartu Keluarga', 'kk_akbar.pdf', '2026-10-01', 'Terverifikasi'),
('B003', 'P002', 'Kartu Tanda Mahasiswa', 'ktm_annisa.pdf', '2026-10-02', 'Menunggu'),
('B004', 'P002', 'Kartu Keluarga', 'kk_annisa.pdf', '2026-10-02', 'Menunggu'),
('B005', 'P003', 'Kartu Tanda Mahasiswa', 'ktm_nazril.pdf', '2026-10-05', 'Menunggu'),
('B006', 'P003', 'Kartu Keluarga', 'kk_nazril.pdf', '2026-10-05', 'Menunggu'),
('B007', 'P004', 'Kartu Tanda Mahasiswa', 'ktm_baru.pdf', '2026-10-08', 'Menunggu');

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `id_mahasiswa` varchar(10) NOT NULL,
  `nim` varchar(20) NOT NULL,
  `nama_mahasiswa` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`id_mahasiswa`, `nim`, `nama_mahasiswa`) VALUES
('M001', '264311033', 'Akbar Putra Pratama'),
('M002', '264311036', 'Annisa Nimasturna'),
('M003', '264311052', 'Nazril Desta');

-- --------------------------------------------------------

--
-- Table structure for table `pendaftaran`
--

CREATE TABLE `pendaftaran` (
  `id_pendaftaran` varchar(10) NOT NULL,
  `id_mahasiswa` varchar(10) NOT NULL,
  `id_program` varchar(10) NOT NULL,
  `tanggal_daftar` date DEFAULT NULL,
  `status_pengajuan` varchar(50) DEFAULT 'Terkirim'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pendaftaran`
--

INSERT INTO `pendaftaran` (`id_pendaftaran`, `id_mahasiswa`, `id_program`, `tanggal_daftar`, `status_pengajuan`) VALUES
('P001', 'M001', 'PB001', '2026-10-01', 'Diterima'),
('P002', 'M002', 'PB001', '2026-10-02', 'Dalam Verifikasi'),
('P003', 'M003', 'PB002', '2026-10-05', 'Terkirim'),
('P004', 'M002', 'PB001', '2026-10-08', 'Terkirim');

-- --------------------------------------------------------

--
-- Table structure for table `program_bantuan`
--

CREATE TABLE `program_bantuan` (
  `id_program` varchar(10) NOT NULL,
  `nama_program` varchar(150) NOT NULL,
  `kategori` varchar(50) NOT NULL,
  `tenggat_waktu` date NOT NULL,
  `total_pendaftar` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `program_bantuan`
--

INSERT INTO `program_bantuan` (`id_program`, `nama_program`, `kategori`, `tenggat_waktu`, `total_pendaftar`) VALUES
('PB001', 'Beasiswa Prestasi Akademik PNM', 'Beasiswa', '2026-11-30', 2),
('PB002', 'Bantuan Biaya UKT Semester Genap', 'Bantuan', '2026-12-15', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `berkas_pendaftaran`
--
ALTER TABLE `berkas_pendaftaran`
  ADD PRIMARY KEY (`id_berkas`),
  ADD KEY `id_pendaftaran` (`id_pendaftaran`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`id_mahasiswa`),
  ADD UNIQUE KEY `nim` (`nim`);

--
-- Indexes for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  ADD PRIMARY KEY (`id_pendaftaran`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`),
  ADD KEY `id_program` (`id_program`),
  ADD KEY `idx_pendaftaran_tanggal` (`tanggal_daftar`);

--
-- Indexes for table `program_bantuan`
--
ALTER TABLE `program_bantuan`
  ADD PRIMARY KEY (`id_program`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `berkas_pendaftaran`
--
ALTER TABLE `berkas_pendaftaran`
  ADD CONSTRAINT `berkas_pendaftaran_ibfk_1` FOREIGN KEY (`id_pendaftaran`) REFERENCES `pendaftaran` (`id_pendaftaran`);

--
-- Constraints for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  ADD CONSTRAINT `pendaftaran_ibfk_1` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`id_mahasiswa`),
  ADD CONSTRAINT `pendaftaran_ibfk_2` FOREIGN KEY (`id_program`) REFERENCES `program_bantuan` (`id_program`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
