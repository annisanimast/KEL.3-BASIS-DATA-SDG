-- Memetakan Objek ke Struktur Relasional --
CREATE TABLE bantuan_objek (
    id_bantuan VARCHAR(10) PRIMARY KEY,
    nama_bantuan VARCHAR(150) NOT NULL,
    jenis_bantuan VARCHAR(50) NOT NULL,
    tenggat_waktu DATE NOT NULL,
    atribut_khusus JSON NOT NULL
) ENGINE=InnoDB;
