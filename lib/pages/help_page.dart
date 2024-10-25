import 'package:flutter/material.dart'; // Mengimpor paket Material untuk komponen UI
import 'package:kenafi/theme/themes.dart'; // Mengimpor tema khusus untuk aplikasi

// Mendefinisikan halaman HelpPage sebagai StatelessWidget, yang berarti tidak memiliki state internal.
class HelpPage extends StatelessWidget {
  const HelpPage({super.key}); // Konstruktor halaman dengan key opsional.

  // Method untuk membangun tampilan halaman.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding di sekitar konten
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Mengatur alignment kolom ke kiri
              mainAxisAlignment: MainAxisAlignment.start, // Mengatur alignment kolom ke atas
              children: [
                Center( // Mengatur judul agar berada di tengah
                  child: Text(
                    'Tata Cara Penggunaan aplikasi', // Judul halaman
                    style: KenafiFonts(context).semiBoldQuicksand(size: 18).copyWith(
                      fontWeight: FontWeight.bold, // Mengatur teks menjadi tebal
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Spasi antara judul dan bullet points
                // Membuat bullet points dengan memanggil method _buildBulletPoint.
                _buildBulletPoint(
                    '1. Masukkan email dan password di halaman login.'),
                _buildBulletPoint(
                    '2. Jika belum memiliki akun, klik "Register Here" untuk registrasi akun.'),
                _buildBulletPoint(
                    '3. Terdapat 4 menu pada Halaman Utama saat user berhasil melakukan login.'),
                _buildBulletPoint(
                    '4. User dapat masuk ke halaman bantuan melalui navigator bar untuk mendapatkan panduan penggunaan aplikasi.'),
                _buildBulletPoint(
                    '5. Data Anggota berisi data-data anggota yang mengerjakan project ini.'),
                _buildBulletPoint(
                    '6. Stopwatch berisi logic simple untuk menampilkan jam, menit, detik, dan milidetik.'),
                _buildBulletPoint(
                    '7. Link Rekomendasi menampilkan informasi tentang lingkungan serta pendanaan untuk kerusakan lingkungan.'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method untuk membangun bullet point
  Widget _buildBulletPoint(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10), // Spasi antar bullet points
      padding: const EdgeInsets.all(10), // Padding dalam kotak bullet point
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey), // Warna border bullet point
        borderRadius: BorderRadius.circular(8), // Sudut membulat
      ),
      child: BulletPoint(text: text), // Menggunakan widget BulletPoint untuk menampilkan isi
    );
  }
}

// Widget untuk menampilkan bullet point dengan nomor
class BulletPoint extends StatelessWidget {
  final String text; // Teks yang akan ditampilkan

  const BulletPoint({required this.text, Key? key}) : super(key: key); // Konstruktor untuk BulletPoint

  // Method untuk membangun tampilan bullet point
  @override
  Widget build(BuildContext context) {
    // Mengambil nomor dari teks
    final String number = text.split(' ')[0]; // Mendapatkan bagian pertama sebagai nomor
    final String bulletText = text.substring(number.length + 1); // Mendapatkan sisa teks setelah nomor

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Mengatur alignment baris ke atas
      children: [
        Container(
          width: 30, // Lebar kontainer untuk ikon
          height: 30, // Tinggi kontainer untuk ikon
          decoration: BoxDecoration(
            color: Colors.lightGreen, // Warna latar belakang ikon bulat
            shape: BoxShape.circle, // Membuatnya berbentuk lingkaran
          ),
          child: Center(
            child: Text(
              number, // Menampilkan nomor
              style: const TextStyle(
                color: Colors.white, // Warna teks
                fontWeight: FontWeight.bold, // Mengatur teks menjadi tebal
              ),
            ),
          ),
        ),
        const SizedBox(width: 8), // Spasi antara ikon dan teks
        Expanded(
          child: Text(
            bulletText, // Menampilkan teks bullet point
            style: KenafiFonts(context).regularQuicksand(size: 13), // Menggunakan font khusus
          ),
        ),
      ],
    );
  }
}