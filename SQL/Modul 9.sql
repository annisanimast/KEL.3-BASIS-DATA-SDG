--1. Menghitung jumlah pendaftar yang diterima per program bantuan --

SELECT
    pb.id_program,
    pb.nama_program,
    COUNT(p.id_pendaftaran) AS total_pendaftar
FROM program_bantuan pb
JOIN pendaftaran p
    ON pb.id_program = p.id_program
WHERE p.status_pengajuan = 'Diterima'
GROUP BY
    pb.id_program,
    pb.nama_program;


--2. A. Menambahkan artibut rendundan (turunan) pada tabel master (program_bantuan) --

ALTER TABLE program_bantuan
ADD COLUMN total_pendaftar INT DEFAULT 0;

  --B. Mengisi kolom turunan total_pendaftar dengan data hasil agregasi dari tabel pendaftaran --

UPDATE program_bantuan
SET total_pendaftar = (
    SELECT COUNT(*)
    FROM pendaftaran
    WHERE pendaftaran.id_program = program_bantuan.id_program
);


--3.  Query baca yang sangat cepat untuk fitur dasbor --

SELECT
    id_program,
    nama_program,
    total_pendaftar
FROM program_bantuan;
