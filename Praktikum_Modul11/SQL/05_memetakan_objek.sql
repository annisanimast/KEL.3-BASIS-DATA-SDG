-- Memetakan Objek ke Struktur Relasional --
CREATE TABLE bantuan_objek (
    id_bantuan VARCHAR(10) PRIMARY KEY,
    nama_bantuan VARCHAR(150) NOT NULL,
    jenis_bantuan VARCHAR(50) NOT NULL,
    tenggat_waktu DATE NOT NULL,
    atribut_khusus JSON NOT NULL
) ENGINE=InnoDB;

-- Data Tabel Objek --
INSERT INTO bantuan_objek
(id_bantuan, nama_bantuan, jenis_bantuan, tenggat_waktu, atribut_khusus)
VALUES
('PB001', 'Beasiswa Prestasi Akademik PNM', 'Beasiswa Prestasi', '2026-11-30',
 '{"target": "Mahasiswa berprestasi", "kategori": "Akademik",
   "persyaratan": ["KTM", "Transkrip Nilai"]}'),

('PB002', 'Bantuan Biaya UKT Semester Genap', 'Bantuan Pendidikan', '2026-12-15',
 '{"target": "Mahasiswa yang membutuhkan bantuan biaya pendidikan",
   "periode": "Semester Genap",
   "persyaratan": ["KTM", "Kartu Keluarga"]}'),

('PB003', 'Bantuan Biaya Hidup Mahasiswa', 'Bantuan Ekonomi', '2026-12-20',
 '{"target": "Mahasiswa dengan kondisi ekonomi kurang mampu",
   "prioritas": "Mahasiswa dengan kondisi ekonomi kurang mampu",
   "persyaratan": ["KTM", "Kartu Keluarga", "Surat Keterangan Penghasilan Orang Tua", "Surat Keterangan Tidak Mampu"]}');

-- Ambil data per jenis objek --
SELECT * FROM bantuan_objek WHERE jenis_bantuan = 'Beasiswa Prestasi';
SELECT * FROM bantuan_objek WHERE jenis_bantuan = 'Bantuan Pendidikan';
SELECT * FROM bantuan_objek WHERE jenis_bantuan = 'Bantuan Ekonomi';

-- Gabungkan data objek dan relasional --
SELECT m.nama_mahasiswa,
       b.nama_bantuan,
       b.jenis_bantuan,
       p.status_pengajuan,
       JSON_EXTRACT(b.atribut_khusus, '$.persyaratan') AS persyaratan
FROM pendaftaran p
JOIN mahasiswa m ON p.id_mahasiswa = m.id_mahasiswa
JOIN bantuan_objek b ON p.id_program = b.id_bantuan;
