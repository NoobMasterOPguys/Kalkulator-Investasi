# Kalkulator-Investasi

A.	Latar Belakang Studi Kasus 
"twelveTech", sebuah perusahaan pengembang perangkat lunak utilitas, berencana meluncurkan seri aplikasi kalkulator pintar untuk berbagai segmen pengguna. Perusahaan membutuhkan purwarupa (prototype) aplikasi berbasis mobile yang antarmukanya ramah pengguna dan memiliki logika perhitungan yang akurat.
Anda ditugaskan sebagai Mobile Developer untuk merancang dan membangun satu aplikasi kalkulator spesifik menggunakan framework Flutter.
B.	Pilihan Tema Aplikasi
1.	Kalkulator Investasi & Keuangan
a.	Fitur Utama: Menghitung Bunga Majemuk (Compound Interest), Return on Investment (ROI), atau Simulasi Cicilan (KPR/Kendaraan).
b.	Input yang dibutuhkan: Saldo awal, persentase bunga, jangka waktu (bulan/tahun), cicilan bulanan.
2.	Kalkulator Ilmiah (Scientific)
a.	Fitur Utama: Operasi matematika dasar (+, -, *, /) ditambah fungsi lanjutan seperti Sin, Cos, Tan, Logaritma, Akar Kuadrat, dan Pangkat.
b.	Tantangan: Mengelola urutan operasi matematika (PEMDAS) dan validasi format angka.
3.	Kalkulator Geometri (Bidang & Ruang)
a.	Fitur Utama: Menghitung Luas, Keliling, dan Volume dari berbagai bangun (Persegi, Segitiga, Lingkaran, Kubus, Tabung, dll).
b.	Fitur Tambahan: Pengguna dapat memilih jenis bangun datar/ruang melalui Dropdown atau Menu Tab.
4.	Kalkulator Kesehatan (Health & Fitness)
a.	Fitur Utama: Menghitung Body Mass Index (BMI), Kebutuhan Kalori Harian (BMR), atau Kebutuhan Air Putih.
b.	Input yang dibutuhkan: Berat badan, tinggi badan, usia, jenis kelamin, tingkat aktivitas.
C. Spesifikasi & Kebutuhan Sistem 
1.	Kebutuhan Fungsional (Wajib):
a.	Aplikasi harus dibangun menggunakan Flutter (menggunakan StatefulWidget atau State Management pilihan seperti Provider/GetX).
b.	Menggunakan minimal 3 input data (TextField) yang disesuaikan dengan tema.
c.	Memiliki tombol "Hitung" untuk memproses hasil dan tombol "Reset" atau "Clear" untuk mengosongkan input.
d.	Validasi Input: Aplikasi tidak boleh error atau crash jika pengguna menekan tombol hitung saat input masih kosong atau jika diisi dengan teks (huruf). Tampilkan SnackBar atau AlertDialog jika terjadi kesalahan input.
e.	Hasil perhitungan harus ditampilkan dengan format yang mudah dibaca (contoh: angka desimal dibatasi 2 angka di belakang koma, format mata uang untuk kalkulator investasi).
f.	
2.Kebutuhan Antarmuka (UI/UX): 
a.	Desain tata letak (layout) harus responsif, tidak terpotong saat di-scroll (gunakan SingleChildScrollView).
b.	Menggunakan elemen desain Flutter secara optimal (contoh: Card, Icon, Colors, Padding).
c.	Menampilkan judul aplikasi pada AppBar.
