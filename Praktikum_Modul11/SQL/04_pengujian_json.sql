no 6

-- Atribut jenis
SELECT
    nama_program,
    JSON_EXTRACT(spesifikasi, '$.jenis') AS jenis
FROM program_bantuan;

-- Atribut target
SELECT
    nama_program,
    JSON_EXTRACT(spesifikasi, '$.target') AS target_penerima
no 6

FROM program_bantuan;

-- Atribut persyaratan (array)
SELECT
    nama_program,
    JSON_EXTRACT(spesifikasi, '$.persyaratan') AS persyaratan
FROM program_bantuan;

-------------------------------------------------------------------------------------------

no 7

UPDATE program_bantuan
SET spesifikasi = JSON_SET(
    spesifikasi,
    '$.periode',
    'Semester Ganjil'
)
WHERE nama_program = 'Bantuan Biaya UKT Semester Genap';

periksa hasil

SELECT
    nama_program,
    JSON_EXTRACT(spesifikasi, '$.periode') AS periode
FROM program_bantuan
WHERE nama_program = 'Bantuan Biaya UKT Semester Genap';

-------------------------------------------------------------------------------------------

no 8 

UPDATE program_bantuan
SET spesifikasi = JSON_SET(
    spesifikasi,
    '$.kuota',
    50
)
WHERE nama_program = 'Beasiswa Prestasi Akademik PNM';

periksa hasil 

SELECT
    nama_program,
    spesifikasi
FROM program_bantuan
WHERE nama_program = 'Beasiswa Prestasi Akademik PNM';

-------------------------------------------------------------------------------------------

no 9

UPDATE program_bantuan
SET spesifikasi = JSON_REMOVE(
    spesifikasi,
    '$.kuota'
)
WHERE nama_program = 'Beasiswa Prestasi Akademik PNM';

periksa hasil

SELECT
    nama_program,
    spesifikasi
FROM program_bantuan;

-------------------------------------------------------------------------------------------

no 10 

SELECT
    nama_program,
    kategori,
    tenggat_waktu,
    spesifikasi
FROM program_bantuan
WHERE JSON_UNQUOTE(
    JSON_EXTRACT(
        spesifikasi,
        '$.jenis'
    )
) = 'Beasiswa Prestasi';

Cari program dengan periode Semester Ganjil 

SELECT
    nama_program,
    kategori,
    tenggat_waktu
FROM program_bantuan
WHERE JSON_UNQUOTE(
    JSON_EXTRACT(
        spesifikasi,
        '$.periode'
    )
) = 'Semester Ganjil';

-------------------------------------------------------------------------------------------

no 11

-- Membuat objek JSON
SELECT JSON_OBJECT(
    'nama', 'Budi',
    'umur', 21,
    'status', 'Mahasiswa'
) AS data_mahasiswa;

-- Membuat array JSON
SELECT JSON_ARRAY(
    'MySQL',
    'MariaDB',
    'PostgreSQL'
) AS daftar_dbms;

-- Memeriksa validitas JSON
SELECT JSON_VALID(
    '{"nama":"Budi","umur":21}'
) AS json_valid;

-- Menghitung jumlah atribut JSON
SELECT
    nama_program,
    JSON_LENGTH(spesifikasi) AS jumlah_atribut
FROM program_bantuan;

