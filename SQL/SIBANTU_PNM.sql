-- Tabel Mahasiswa--

CREATE TABLE mahasiswa (
    id_mahasiswa VARCHAR(10) NOT NULL,
    nim VARCHAR(20) UNIQUE NOT NULL,
    nama_mahasiswa VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_mahasiswa)
);

-- Tabel Program Bantuan --

CREATE TABLE program_bantuan (
    id_program VARCHAR (10) NOT NULL,
    nama_program VARCHAR(150) NOT NULL,
    kategori VARCHAR(50) NOT NULL,
    tenggat_waktu DATE NOT NULL,
    PRIMARY KEY (id_program)
);

-- Tabel Pendaftaran --

CREATE TABLE pendaftaran (
    id_pendaftaran VARCHAR (10) NOT NULL, 
    id_mahasiswa VARCHAR (10) NOT NULL,
    id_program VARCHAR (10) NOT NULL,
    tanggal_daftar DATE,
    status_pengajuan VARCHAR(50) DEFAULT 'Terkirim',
    PRIMARY KEY (id_pendaftaran),
    FOREIGN KEY (id_mahasiswa) REFERENCES mahasiswa(id_mahasiswa),
    FOREIGN KEY (id_program) REFERENCES program_bantuan(id_program)
);

-- Data Tabel Mahasiswa --

INSERT INTO mahasiswa VALUES 
('M001', '264311033', 'Akbar Putra Pratama'), 
('M002', '264311036', 'Annisa Nimasturna'),
('M003', '264311052', 'Nazril Desta');

-- Data Tabel Program Bantuan --

INSERT INTO program_bantuan VALUES 
('PB001', 'Beasiswa Prestasi Akademik PNM', 'Beasiswa', '2026-11-30'), 
('PB002', 'Bantuan Biaya UKT Semester Genap', 'Bantuan', '2026-12-15');

-- Data Tabel Pendaftaran --

INSERT INTO pendaftaran VALUES 
('P001', 'M001', 'PB001', '2026-10-01', 'Diterima'), 
('P002', 'M002', 'PB001', '2026-10-02', 'Dalam Verifikasi'), 
('P003', 'M003', 'PB002', '2026-10-05', 'Terkirim');
