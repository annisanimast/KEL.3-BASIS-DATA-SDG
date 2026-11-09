Tahap 2 – Implementasi Basis Data

-- pembuatan tabel --
CREATE TABLE berkas_pendaftaran (
    id_berkas VARCHAR(10) PRIMARY KEY,
    id_pendaftaran VARCHAR(10) NOT NULL,
    nama_berkas VARCHAR(100) NOT NULL,
    file_berkas VARCHAR(255) NOT NULL,
    tanggal_upload DATE,
    status_verifikasi VARCHAR(30) DEFAULT 'Menunggu',
    FOREIGN KEY (id_pendaftaran)
        REFERENCES pendaftaran(id_pendaftaran)
);

-- isi tabel --
INSERT INTO berkas_pendaftaran
(id_berkas, id_pendaftaran, nama_berkas, file_berkas, tanggal_upload, status_verifikasi)
VALUES
('B001', 'P001', 'Kartu Tanda Mahasiswa', 'ktm_akbar.pdf', '2026-10-01', 'Terverifikasi'),
('B002', 'P001', 'Kartu Keluarga', 'kk_akbar.pdf', '2026-10-01', 'Terverifikasi'),
('B003', 'P002', 'Kartu Tanda Mahasiswa', 'ktm_annisa.pdf', '2026-10-02', 'Menunggu'),
('B004', 'P002', 'Kartu Keluarga', 'kk_annisa.pdf', '2026-10-02', 'Menunggu'),
('B005', 'P003', 'Kartu Tanda Mahasiswa', 'ktm_nazril.pdf', '2026-10-05', 'Menunggu'),
('B006', 'P003', 'Kartu Keluarga', 'kk_nazril.pdf', '2026-10-05', 'Menunggu');

-- Memeriksa Relasi Tabel --
SHOW TABLES;

SHOW CREATE TABLE mahasiswa;

SHOW CREATE TABLE pendaftaran;

SHOW CREATE TABLE berkas_pendaftaran;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

Tahap 3 – Praktik Operasi Database (CRUD)

-- CREATE --
INSERT INTO mahasiswa
    (id_mahasiswa, nim, nama_mahasiswa)
VALUES
    ('M004', '24611006', 'Andi Pratama');
-- periksa hasil --
SELECT * FROM mahasiswa;

-- READ --
SELECT
    id_mahasiswa,
    nim,
    nama_mahasiswa
FROM mahasiswa;
-- membaca data --
SELECT *
FROM mahasiswa
WHERE nim = '24611006';

-- UPDATE --
UPDATE mahasiswa
SET nama_mahasiswa = 'Andi Saputra'
WHERE id_mahasiswa = 'M004';
-- periksa hasil --
SELECT *
FROM mahasiswa
WHERE id_mahasiswa = 'M004';

-- DELETE --
DELETE FROM mahasiswa
WHERE id_mahasiswa = 'M004';
-- periksa hasil --
SELECT *
FROM mahasiswa;

-- Menguji Integritas Referensial --
INSERT INTO pendaftaran
    (id_pendaftaran, id_mahasiswa, id_program, status_pengajuan)
VALUES
    ('P999', 'M999', 'PB001', 'Terkirim');

-- ON DELETE RESTRICT --
DELETE FROM mahasiswa
WHERE id_mahasiswa = 'M001';

-----------------------------------------------------------------------------------------------------------------------------------------------------------

Tahap 4 – Pengujian Transaksi Database

-- Pengujian COMMIT --
START TRANSACTION;

INSERT INTO pendaftaran
    (id_pendaftaran, id_mahasiswa, id_program, tanggal_daftar, status_pengajuan)
VALUES
    ('P004', 'M002', 'PB001', '2026-10-08', 'Terkirim');

INSERT INTO berkas_pendaftaran
    (id_berkas, id_pendaftaran, nama_berkas, file_berkas, tanggal_upload, status_verifikasi)
VALUES
    ('B007', 'P004', 'Kartu Tanda Mahasiswa', 'ktm_baru.pdf', '2026-10-08', 'Menunggu');

COMMIT;

-- periksa hasil --
SELECT *
FROM pendaftaran
WHERE id_pendaftaran = 'P004';

SELECT *
FROM berkas_pendaftaran
WHERE id_pendaftaran = 'P004';

-- Pengujian ROLLBACK --
START TRANSACTION;

INSERT INTO pendaftaran
    (id_pendaftaran, id_mahasiswa, id_program, tanggal_daftar, status_pengajuan)
VALUES
    ('P005', 'M002', 'PB001', '2026-10-08',  'Terkirim');

INSERT INTO berkas_pendaftaran
    (id_berkas, id_pendaftaran, nama_berkas, file_berkas, tanggal_upload, status_verifikasi)
VALUES
    ('B008', 'P005', 'Kartu Tanda Mahasiswa', 'ktm_baru.pdf', '2026-10-08', 'Menunggu');

ROLLBACK;

-- periksa hasil --
SELECT *
FROM pendaftaran
WHERE id_pendaftaran = 'P005';

SELECT *
FROM berkas_pendaftaran
WHERE id_pendaftaran = 'P005';

-----------------------------------------------------------------------------------------------------------------------------------------------------------

Tahap 5 – Analisis Performa Database

-- Sebelum INDEX --
EXPLAIN
SELECT
    id_pendaftaran,
    id_mahasiswa,
    id_program,
    tanggal_daftar,
    status_pengajuan
FROM pendaftaran
WHERE tanggal_daftar >= '2026-10-01'
  AND tanggal_daftar < '2026-10-06';

-- Membuat INDEX --
CREATE INDEX idx_pendaftaran_tanggal
ON pendaftaran(tanggal_daftar);

-- Periksa INDEX --
SHOW INDEX FROM pendaftaran;

-- Setelah INDEX --
EXPLAIN
SELECT
    id_pendaftaran,
    id_mahasiswa,
    id_program,
    tanggal_daftar,
    status_pengajuan
FROM pendaftaran
WHERE tanggal_daftar >= '2026-10-01'
  AND tanggal_daftar < '2026-10-06';

-----------------------------------------------------------------------------------------------------------------------------------------------------------

Tahap 6 – Pemeliharaan Basis Data (Backup & Restore)

-- Backup Menggunakan Command Line --
mysqldump -u root -p --databases si_bantu > backup_modul10.sql

-- Restore Menggunakan Command Line --
mysql -u root -p < backup_modul10.sql

-- Validasi Hasil Restore --
SHOW TABLES;
SELECT COUNT(*) FROM mahasiswa;
SELECT COUNT(*) FROM pendaftaran;
SELECT COUNT(*) FROM program_bantuan;
SELECT COUNT(*) FROM berkas_pendaftaran;
