-- Tabel Mahasiswa --
CREATE TABLE mahasiswa (
    id_mahasiswa VARCHAR(10) PRIMARY KEY,
    nim VARCHAR(20) NOT NULL UNIQUE,
    nama_mahasiswa VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- Tabel Program Bantuan --
CREATE TABLE program_bantuan (
    id_program VARCHAR(10) PRIMARY KEY,
    nama_program VARCHAR(100) NOT NULL,
    spesifikasi JSON NOT NULL
) ENGINE=InnoDB;

-- Tabel Pendaftaran --
CREATE TABLE pendaftaran (
    id_pendaftaran VARCHAR(10) PRIMARY KEY,
    id_mahasiswa VARCHAR(10) NOT NULL,
    id_program VARCHAR(10) NOT NULL,
    tanggal_daftar DATETIME,
    status_pengajuan VARCHAR(30) NOT NULL,
    catatan_verifikasi TEXT,
    tanggal_verifikasi DATETIME,

    CONSTRAINT fk_pendaftaran_mahasiswa
        FOREIGN KEY (id_mahasiswa)
        REFERENCES mahasiswa(id_mahasiswa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_pendaftaran_program
        FOREIGN KEY (id_program)
        REFERENCES program_bantuan(id_program)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabel Berkas Pendaftaran --
CREATE TABLE berkas_pendaftaran (
    id_berkas VARCHAR(10) PRIMARY KEY,
    id_pendaftaran VARCHAR(10) NOT NULL,
    nama_berkas VARCHAR(100) NOT NULL,
    file_berkas VARCHAR(255),
    tanggal_upload DATETIME,
    status_verifikasi VARCHAR(30) NOT NULL,

    CONSTRAINT fk_berkas_pendaftaran
        FOREIGN KEY (id_pendaftaran)
        REFERENCES pendaftaran(id_pendaftaran)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabel Kategori --
CREATE TABLE kategori (
    id_kategori VARCHAR(10) PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL,
    deskripsi TEXT
) ENGINE=InnoDB;
