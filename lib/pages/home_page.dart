import 'package:flutter/material.dart'; // Mengimpor paket Material untuk komponen UI
import 'package:kenafi/components/touchable_opacity.dart'; // Mengimpor komponen TouchableOpacity untuk efek sentuh
import 'package:kenafi/pages/anggota_page.dart'; // Mengimpor halaman AnggotaPage
import 'package:kenafi/pages/favorite_page.dart'; // Mengimpor halaman FavoritePage
import 'package:kenafi/pages/link_rekomendasi.dart'; // Mengimpor halaman LinkRekomendasiPage
import 'package:kenafi/pages/stopwatch_page.dart'; // Mengimpor halaman StopwatchPage
import 'package:kenafi/theme/themes.dart'; // Mengimpor tema khusus untuk aplikasi

// Mendefinisikan HomePage sebagai StatefulWidget, yang berarti dapat memiliki state internal.
class HomePage extends StatefulWidget {
  const HomePage({super.key}); // Konstruktor halaman dengan key opsional.

  @override
  State<HomePage> createState() => _HomePageState(); // Menghubungkan dengan state yang sesuai.
}

// State dari HomePage untuk mengelola logika dan tampilan.
class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController(); // Kontrol untuk scrolling halaman.

  // Daftar Content yang berisi informasi setiap menu.
  final List<Map<String, dynamic>> contents = [
    {
      'name': 'Anggota', // Nama menu
      'icon': Icons.person, // Ikon untuk menu
      'color': Colors.green, // Warna untuk menu
      'link': AnggotaPage(), // Halaman yang akan dituju
    },
    {
      'name': 'Stopwatch',
      'icon': Icons.access_time,
      'color': Colors.blue,
      'link': StopwatchPage(),
    },
    {
      'name': 'Link Rekomendasi',
      'icon': Icons.thumb_up,
      'color': Colors.orange,
      'link': LinkRekomendasiPage(),
    },
    {
      'name': 'Favorite',
      'icon': Icons.favorite,
      'color': Colors.red,
      'link': FavoritePage(),
    }
  ];

  // Method untuk membangun tampilan halaman.
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Struktur dasar halaman
      body: SingleChildScrollView( // Memungkinkan scroll pada konten
        controller: _scrollController, // Mengaitkan kontroler scroll
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), // Padding di sekitar konten
        child: Column( // Mengatur konten dalam kolom
          crossAxisAlignment: CrossAxisAlignment.start, // Mengatur alignment kolom ke kiri
          children: [
            // Menu items
            ...contents.map((data) => Container( // Mengiterasi daftar contents untuk membangun menu
              width: MediaQuery.of(context).size.width, // Mengatur lebar kontainer sesuai lebar layar
              height: MediaQuery.of(context).size.width / 3, // Mengatur tinggi kontainer
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15), // Margin antar kontainer
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), // Sudut membulat untuk kontainer
                color: Colors.grey[300], // Warna latar belakang kontainer
                boxShadow: <BoxShadow>[ // Menambahkan bayangan pada kontainer
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Warna bayangan
                    blurRadius: 8, // Tingkat blur bayangan
                    offset: const Offset(0, 2), // Offset posisi bayangan
                  ),
                ],
              ),
              child: TouchableOpacity( // Komponen dengan efek sentuh
                onTap: () { // Aksi ketika ditekan
                  Navigator.of(context).push( // Navigasi ke halaman baru
                    MaterialPageRoute(builder: (context) => data['link']), // Mengarahkan ke halaman yang sesuai
                  );
                },
                child: Column( // Mengatur konten dalam kolom
                  crossAxisAlignment: CrossAxisAlignment.center, // Mengatur alignment kolom ke tengah
                  mainAxisAlignment: MainAxisAlignment.center, // Mengatur alignment kolom ke tengah
                  children: [
                    CircleAvatar( // Lingkaran untuk menampilkan ikon
                      radius: 35, // Radius lingkaran
                      backgroundColor: data['color'].withOpacity(0.2), // Warna latar belakang lingkaran
                      child: Icon(
                        data['icon'], // Menampilkan ikon sesuai dengan data
                        size: 40, // Ukuran ikon
                        color: data['color'], // Warna ikon
                      ),
                    ),
                    const SizedBox(height: 10), // Spasi antara ikon dan teks
                    Text(
                      data['name'], // Menampilkan nama menu
                      style: KenafiFonts(context).boldQuicksand(size: 18), // Menggunakan font khusus
                    ),
                  ],
                ),
              ),
            )).toList(), // Mengonversi hasil map ke dalam daftar widget
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton( // Tombol aksi mengapung
        onPressed: () { // Aksi ketika tombol ditekan
          // Scroll to the top when the button is pressed
          _scrollController.animateTo( // Mengatur animasi scroll
            0, // Scroll ke atas
            duration: const Duration(milliseconds: 300), // Durasi animasi
            curve: Curves.easeInOut, // Kurva animasi
          );
        },
        backgroundColor: Colors.lightGreen, // Warna tombol aksi
        child: const Icon(Icons.arrow_upward), // Ikon panah ke atas pada tombol
      ),
    );
  }
}