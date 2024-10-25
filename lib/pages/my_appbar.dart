import 'package:flutter/material.dart'; // Mengimpor paket Material untuk komponen UI Flutter
import 'package:kenafi/theme/themes.dart'; // Mengimpor tema khusus dari aplikasi Kenafi

// Mendefinisikan fungsi myAppBar yang mengembalikan widget AppBar
AppBar myAppBar(
  BuildContext context, { // Parameter context untuk mengakses informasi tentang lokasi widget dalam tree
  String title = '', // Judul yang akan ditampilkan di AppBar, default adalah string kosong
  List<Widget>? action, // Daftar widget untuk aksi di sisi kanan AppBar, opsional
  bool leading = false, // Mengatur apakah tombol kembali (leading) akan ditampilkan, default adalah false
  VoidCallback? leadingAction, // Aksi yang akan dijalankan ketika tombol kembali ditekan
  ImageProvider? image, // Opsional: gambar yang bisa ditampilkan di AppBar, saat ini tidak digunakan
  bool automaticImplyLeading = true, // Mengatur apakah AppBar harus otomatis menampilkan tombol kembali
}) {
  return AppBar(
    centerTitle: true, // Mengatur posisi judul di tengah
    title: Text(
      title, // Menggunakan parameter title untuk menampilkan judul
      style: KenafiFonts(context).appbarTitle, // Mengatur gaya teks judul menggunakan tema khusus
    ),
    actions: action, // Menambahkan aksi yang diteruskan ke AppBar
    elevation: 0, // Mengatur elevasi AppBar menjadi 0 (tanpa bayangan)
    automaticallyImplyLeading: automaticImplyLeading, // Mengatur perilaku otomatis tombol kembali
    backgroundColor: Colors.transparent, // Mengatur latar belakang AppBar menjadi transparan
    leading: leading // Menampilkan tombol kembali jika leading adalah true
        ? IconButton(
            icon: const Icon(Icons.arrow_back, // Ikon panah untuk tombol kembali
                color: Color.fromARGB(255, 39, 45, 49)), // Warna ikon
            onPressed: () {
              Navigator.pop(context); // Menutup halaman saat tombol kembali ditekan
            },
          )
        : null, // Jika leading adalah false, tidak ada ikon yang ditampilkan
  );
}