import 'package:flutter/material.dart';

// Mendefinisikan halaman AnggotaPage sebagai StatefulWidget.
class AnggotaPage extends StatefulWidget {
  const AnggotaPage({super.key});

  @override
  _AnggotaPageState createState() => _AnggotaPageState();
}

// State dari AnggotaPage yang akan mengelola logika dan tampilan.
class _AnggotaPageState extends State<AnggotaPage> {
  // Daftar berisi informasi dari setiap developer.
  final List<Map<String, String>> developers = [
    {
      'name': 'Berlian Ariqa Hanna Aurora',
      'nim': '124220016',
      'image': 'img/hana.jpg',
    },
    {
      'name': 'Kesha Azka Afleni',
      'nim': '124220023',
      'image': 'img/kesa.jpg',
    },
    {
      'name': 'Aafiyah Najlaa Labiibah',
      'nim': '124220025',
      'image': 'img/fiya.jpg',
    }
  ];

  // Method ini membangun tampilan halaman.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar untuk menampilkan judul dan tombol kembali.
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 85, 6), // Warna latar belakang AppBar
        title: const Text(
          'Daftar Anggota',
          style: TextStyle(color: Colors.white), // Mengatur warna teks menjadi putih
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ikon untuk tombol kembali
          onPressed: () {
            Navigator.pop(context); // Fungsi untuk kembali ke halaman sebelumnya
          },
        ),
      ),
      // Body halaman menggunakan ListView untuk daftar anggota.
      body: ListView.builder(
        itemCount: developers.length, // Jumlah item yang ditampilkan
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 20), // Spasi antar kotak
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                  255, 192, 233, 194), // Warna latar belakang kotak
              borderRadius: BorderRadius.circular(10), // Sudut membulat
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Warna bayangan
                  spreadRadius: 2, // Jarak penyebaran bayangan
                  blurRadius: 5, // Seberapa kabur bayangan
                  offset: const Offset(0, 3), // Posisi bayangan
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0), // Padding dalam kotak
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // GestureDetector untuk merespons ketukan pada gambar
                    GestureDetector(
                      onTap: () {
                        _showImageDialog(context, developers[index]['image']!); // Menampilkan dialog gambar
                      },
                      child: CircleAvatar(
                        radius: 50.0, // Radius lingkaran avatar
                        backgroundImage: AssetImage(
                          developers[index]['image'] ?? 'assets/img/default.png', // Gambar default jika tidak ada
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Spasi antara avatar dan nama
                    Text(
                      '${developers[index]['name']}', // Menampilkan nama developer
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold, // Mengatur teks tebal
                        color: Colors.black, // Warna teks
                      ),
                    ),
                    const SizedBox(height: 5), // Spasi antara nama dan NIM
                    Text(
                      '${developers[index]['nim']}', // Menampilkan NIM developer
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal, // Mengatur teks normal
                        color: Colors.black, // Warna teks
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Method untuk menampilkan dialog gambar saat avatar diketuk.
  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Membuat latar belakang dialog transparan
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Mengatur lebar dialog
            height: MediaQuery.of(context).size.width * 0.8, // Mengatur tinggi dialog agar berbentuk persegi
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 10), // Menambahkan border putih
              shape: BoxShape.circle, // Membuat kontainer berbentuk lingkaran
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath, // Menampilkan gambar yang dipilih
                fit: BoxFit.cover, // Mengatur gambar agar memenuhi area oval
              ),
            ),
          ),
        );
      },
    );
  }
}