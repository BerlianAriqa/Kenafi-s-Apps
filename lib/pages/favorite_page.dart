import 'package:cloud_firestore/cloud_firestore.dart'; // Mengimpor paket Firestore untuk mengakses database
import 'package:flutter/material.dart'; // Mengimpor paket material untuk komponen UI
import 'package:url_launcher/url_launcher.dart'; // Mengimpor paket untuk meluncurkan URL

// Mendefinisikan halaman FavoritePage sebagai StatefulWidget.
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

// State dari FavoritePage yang akan mengelola logika dan tampilan.
class _FavoritePageState extends State<FavoritePage> {
  List<dynamic> data = []; // Menyimpan data favorit

  // Memuat item favorit dari Firestore
  Future<void> _loadItems() async {
    List<Map<String, dynamic>> items = await loadFavoritesFromFirestore();
    if (items.isNotEmpty) {
      setState(() {
        data = items; // Mengupdate state lokal dengan data yang dimuat
      });
    }
  }

  // Mengambil data dari Firestore
  Future<List<Map<String, dynamic>>> loadFavoritesFromFirestore() async {
    CollectionReference favorites =
        FirebaseFirestore.instance.collection('favorites'); // Mengakses koleksi 'favorites'
    QuerySnapshot querySnapshot = await favorites.get(); // Mengambil seluruh dokumen dari koleksi
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>) // Mengonversi dokumen ke Map
        .toList(); // Mengembalikan daftar hasil
  }

  // Menghapus item dari Firestore
  Future<void> removeFavoriteFromFirestore(String itemId) async {
    CollectionReference favorites =
        FirebaseFirestore.instance.collection('favorites'); // Mengakses koleksi 'favorites'
    await favorites.doc(itemId).delete(); // Menghapus dokumen berdasarkan ID
  }

  @override
  void initState() {
    super.initState();
    _loadItems(); // Memuat data saat inisialisasi halaman
  }

  // Meluncurkan URL
  _launchURL(String url) async {
    if (await canLaunch(url)) { // Memeriksa apakah URL dapat diluncurkan
      await launch(url); // Meluncurkan URL
    } else {
      throw 'Could not launch $url'; // Menangani kesalahan jika URL tidak dapat diluncurkan
    }
  }

  // Method untuk membangun tampilan halaman
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 85, 6), // Warna latar belakang AppBar
        title: const Text(
          'Favorite',
          style: TextStyle(color: Colors.white), // Mengatur warna teks menjadi putih
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20), // Margin horizontal untuk kontainer
        child: Column(
          children: [
            const SizedBox(height: 20), // Spasi di atas konten
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom dalam grid
                  crossAxisSpacing: 10, // Jarak horizontal antar kolom
                  mainAxisSpacing: 10, // Jarak vertikal antar baris
                ),
                itemCount: data.length, // Jumlah item yang ditampilkan
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color.fromARGB(255, 211, 211, 211), // Warna latar belakang kartu
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8), // Sudut membulat untuk efek klik
                      onTap: () {
                        _launchURL(data[index]['link']); // Meluncurkan URL saat kartu diklik
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8), // Padding dalam kartu
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.network(
                                data[index]['image'], // Mengambil gambar dari URL
                                loadingBuilder: (BuildContext context, Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child; // Jika gambar sudah dimuat
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes! // Menampilkan progress loading
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 8), // Spasi antara gambar dan nama
                            Text(
                              data[index]['name'], // Menampilkan nama item
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8), // Spasi sebelum ikon hapus
                            IconButton(
                              onPressed: () async {
                                String itemId = data[index]['id'].toString(); // Mengambil ID item
                                String itemName = data[index]['name']; // Menyimpan nama untuk pesan

                                await removeFavoriteFromFirestore(itemId); // Menghapus item dari Firestore

                                setState(() {
                                  data.removeAt(index); // Menghapus item dari state lokal
                                });

                                // Menampilkan pesan bahwa item dihapus
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Data $itemName berhasil dihapus'), // Pesan konfirmasi
                                    backgroundColor: Colors.red, // Warna latar belakang SnackBar
                                  ),
                                );
                              },
                              icon: const Icon(Icons.heart_broken, color: Colors.red), // Ikon hapus
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}