-- Data Tabel Mahasiswa --
INSERT INTO mahasiswa 
(id_mahasiswa, nim, nama_mahasiswa)
VALUES 
('M001', '264311033', 'Akbar Putra Pratama'), 
('M002', '264311036', 'Annisa Nimasturna'),
('M003', '264311052', 'Nazril Desta');

-- Data Tabel Program Bantuan --
INSERT INTO program_bantuan (
    id_program,
    nama_program,
    kategori,
    tenggat_waktu,
    spesifikasi
)
VALUES
(
    'PB001',
    'Beasiswa Prestasi Akademik PNM',
    'Beasiswa',
    '2026-11-30',
    '{
        "jenis": "Beasiswa Prestasi",
        "target": "Mahasiswa berprestasi",
        "kategori": "Akademik",
        "persyaratan": [
            "KTM",
            "Transkrip Nilai"
        ]
    }'
);

INSERT INTO program_bantuan (
    id_program,
    nama_program,
    kategori,
    tenggat_waktu,
    spesifikasi
)
VALUES
(
    'PB002',
    'Bantuan Biaya UKT Semester Genap',
    'Bantuan',
    '2026-12-15',
    '{
        "jenis": "Bantuan Pendidikan",
        "target": "Mahasiswa yang membutuhkan bantuan biaya pendidikan",
        "periode": "Semester Genap",
        "persyaratan": [
            "KTM",
            "Kartu Keluarga"
        ]
    }'
);

INSERT INTO program_bantuan (
    id_program,
    nama_program,
    kategori,
    tenggat_waktu,
    spesifikasi
)
VALUES 
(
    'PB003',
    'Bantuan Biaya Hidup Mahasiswa',
    'Bantuan Ekonomi',
    '2026-12-20',
    '{
        "jenis": "Bantuan Ekonomi",
        "target": "Mahasiswa dengan kondisi ekonomi kurang mampu",
        "persyaratan": [
            "KTM",
            "Kartu Keluarga",
            "Surat Keterangan Penghasilan Orang Tua",
            "Surat Keterangan Tidak Mampu"
        ],
        "prioritas": "Mahasiswa dengan kondisi ekonomi kurang mampu"
    }'
);

-- Data Tabel Pendaftaran --
INSERT INTO pendaftaran 
(id_pendaftaran, id_mahasiswa, id_program, tanggal_daftar, status_pengajuan)
VALUES 
('P001', 'M001', 'PB001', '2026-10-01', 'Diterima'), 
('P002', 'M002', 'PB001', '2026-10-02', 'Dalam Verifikasi'), 
('P003', 'M003', 'PB002', '2026-10-05', 'Terkirim');

-- Data Tabel Berkas Pendaftaraan --
INSERT INTO berkas_pendaftaran
(id_berkas, id_pendaftaran, nama_berkas, file_berkas, tanggal_upload, status_verifikasi)
VALUES
('B001', 'P001', 'Kartu Tanda Mahasiswa', 'ktm_akbar.pdf', '2026-10-01', 'Terverifikasi'),
('B002', 'P001', 'Kartu Keluarga', 'kk_akbar.pdf', '2026-10-01', 'Terverifikasi'),
('B003', 'P002', 'Kartu Tanda Mahasiswa', 'ktm_annisa.pdf', '2026-10-02', 'Menunggu'),
('B004', 'P002', 'Kartu Keluarga', 'kk_annisa.pdf', '2026-10-02', 'Menunggu'),
('B005', 'P003', 'Kartu Tanda Mahasiswa', 'ktm_nazril.pdf', '2026-10-05', 'Menunggu'),
('B006', 'P003', 'Kartu Keluarga', 'kk_nazril.pdf', '2026-10-05', 'Menunggu');

-- Data Tabel Kategori --
INSERT INTO kategori (id_kategori, nama_kategori, deskripsi)
VALUES
('K001', 'Beasiswa Prestasi', 'Bantuan untuk mahasiswa berprestasi'),
('K002', 'Bantuan Ekonomi', 'Bantuan untuk mahasiswa yang membutuhkan'),
('K003', 'Bantuan Pendidikan', 'Bantuan untuk menunjang biaya pendidikan');
