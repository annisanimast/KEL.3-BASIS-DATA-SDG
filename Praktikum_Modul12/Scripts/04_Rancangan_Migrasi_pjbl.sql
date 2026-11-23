
// 1. Inisialisasi Database Target
use sibantu_pnm;

// 2. Migrasi Skema ke Pola Hybrid Embedded dan Referenced
// Menggabungkan snapshot data mahasiswa dan bantuan
// ke dalam koleksi pengajuan_bantuan.

db.pengajuan_bantuan.insertOne({
  _id: "PG001",
  mahasiswa_id: "M001",
  jenis_bantuan_id: "PB003",

  mahasiswa_snapshot: {
    nim: "264311033",
    nama: "Akbar Putra Pratama",
    prodi: "D-IV TRPL"
  },

  bantuan_snapshot: {
    kode_bantuan: "PB003",
    nama_bantuan: "Bantuan Biaya Hidup Mahasiswa",
    nominal: 1500000,
    sumber_dana: "Dana Kemahasiswaan"
  },

  tanggal_pengajuan: ISODate("2026-11-21"),
  status_pengajuan: "Dalam Verifikasi"
});

// 3. Strategi Optimisasi: Pembuatan Compound Index
// Mempercepat pencarian berdasarkan status pengajuan
// dan pengurutan berdasarkan tanggal pengajuan.

db.pengajuan_bantuan.createIndex(
  { status_pengajuan: 1, tanggal_pengajuan: -1 },
  { name: "idx_status_tanggal_pengajuan" }
);

// 4. Rancangan Query Fitur Utama
// Menampilkan informasi mahasiswa dan bantuan
// berdasarkan status pengajuan.

db.pengajuan_bantuan.find(
  { status_pengajuan: "Dalam Verifikasi" },
  {
    _id: 0,
    "mahasiswa_snapshot.nim": 1,
    "mahasiswa_snapshot.nama": 1,
    "mahasiswa_snapshot.prodi": 1,
    "bantuan_snapshot.nama_bantuan": 1,
    "bantuan_snapshot.nominal": 1,
    tanggal_pengajuan: 1
  }
).sort({ tanggal_pengajuan: -1 });

// 5. Inspeksi Rencana Eksekusi
// Memeriksa penggunaan indeks dan statistik eksekusi query.

db.pengajuan_bantuan.find(
  { status_pengajuan: "Dalam Verifikasi" },
  {
    _id: 0,
    "mahasiswa_snapshot.nim": 1,
    "mahasiswa_snapshot.nama": 1,
    "mahasiswa_snapshot.prodi": 1,
    "bantuan_snapshot.nama_bantuan": 1,
    "bantuan_snapshot.nominal": 1,
    tanggal_pengajuan: 1
  }
).sort({ tanggal_pengajuan: -1 })
 .explain("executionStats");

// 6. Rancangan Kontrol Akses RBAC
// A. Mahasiswa: Melihat program bantuan dan mengajukan bantuan.

db.createRole({
  role: "mahasiswaRole",
  privileges: [
    {
      resource: { db: "sibantu_pnm", collection: "program_bantuan" },
      actions: ["find"]
    },
    {
      resource: { db: "sibantu_pnm", collection: "pengajuan_bantuan" },
      actions: ["find", "insert"]
    }
  ],
  roles: []
});

// B. Admin Kemahasiswaan: Mengelola informasi bantuan dan pengajuan.

db.createRole({
  role: "adminKemahasiswaanRole",
  privileges: [
    {
      resource: { db: "sibantu_pnm", collection: "program_bantuan" },
      actions: ["find", "insert", "update", "remove"]
    },
    {
      resource: { db: "sibantu_pnm", collection: "pengajuan_bantuan" },
      actions: ["find", "insert", "update", "remove"]
    }
  ],
  roles: []
});

// C. Pimpinan: Melihat laporan dan data penerima bantuan.

db.createRole({
  role: "pimpinanRole",
  privileges: [
    {
      resource: { db: "sibantu_pnm", collection: "program_bantuan" },
      actions: ["find"]
    },
    {
      resource: { db: "sibantu_pnm", collection: "pengajuan_bantuan" },
      actions: ["find"]
    }
  ],
  roles: []
});

// Verifikasi konfigurasi role
db.getRole("mahasiswaRole", { showPrivileges: true });
db.getRole("adminKemahasiswaanRole", { showPrivileges: true });
db.getRole("pimpinanRole", { showPrivileges: true });

