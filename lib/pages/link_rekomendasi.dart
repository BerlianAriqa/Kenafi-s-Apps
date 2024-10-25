import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkRekomendasiPage extends StatefulWidget {
  const LinkRekomendasiPage({super.key});

  @override
  State<LinkRekomendasiPage> createState() => _LinkRekomendasiPageState();
}

class _LinkRekomendasiPageState extends State<LinkRekomendasiPage> {
  final List<Map<String, dynamic>> linkRekomendations = [
    {
      'id': 1,
      'name': 'Global Environment Facility',
      'link': 'https://www.thegef.org/',
      'image':
          'data:image/png;base64,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',
    },
    {
      'id': 2,
      'name': 'World Vision',
      'link': 'https://global6k.worldvision.org/',
      'image':
          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABwAAAAcCAMAAABF0y+mAAAALVBMVEX/ZgD/ZgD/ZgD/ZgD/ZgD/YAD/////cyD/gj3/k1n/pHP/8ur/yav/3sv/s4riPCvNAAAABHRSTlP79O/oJw6pWQAAAIRJREFUKJGd0lEOAyEIBFC7KwKi3P+4tWvSaLNMm86XyUuQAOkR50w5zvGBDJCFANYYSRygdoDVwoaIelk/fSONcCvF9HpuKFpbt/KKNVfhFXmo92lVZcdZ14fxVZRuurX7hia2IjG6rZP/fQhfxocwS/sT4T7hJWRWhOjA4GnuORLI+QRx3g08s+NwdAAAAABJRU5ErkJggg==',
    },
    {
      'id': 3,
      'name': 'Environmental Defense Fund',
      'link': 'https://www.edf.org/',
      'image':
          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABwAAAAcCAMAAABF0y+mAAAA3lBMVEX////M8P+T4P9c1P9H0P+o5v80zP8cyf+g4//l9/8Axv/V8v+G3f+66//4/f////jr+M/e9Lja87Hz++Xk9sSv5kaa4ACf4QBz2f/7/vGe4QCh4hLL7pD4/urw+9rX8qvU8aNT0v/n8+vB4Mqy2LvU6dut5T+t1rYioEQAjgAAlCBZs2/H7Yby+fUypE8Aly0AmTMAlSdzvIS16FeHxJWTyp9Fql7IzvJleNoKOc4AJMsbQc/U2fTi5fk+WNMAGckALcsAMMwBM8x7it4ACMi7w+6MmeIuTNGapeVLYtWOKojxAAABS0lEQVR4AWKgBgCwPQ8KDMNQFEBfbTvpbNb9/09bMG+3CE4oiJIsS6LwhxRV01QS8te/yJCp8GimZr2bpT1Fsx3Ddd/nvUwB8PwgDKMnPklyIU5Smux5Fu1uORRJijANKr8mShChDN+TchMeE92CGUpZAoYiR82BhFiKy3jiFdPZnKHEJy4gTHGGQoDlar3eAI/MJ1qAMNp6sNsfjjSnF5KTnhFK4HI9VjVNVb2W1dwoRVu4VIQ4Xp8HIotuU2I1tappmqppH1chJz2nHTeyWz/042ENLJpkQJnOYUmsOQ7wERdgXnqwPlbVofXg1hpZGzAMxABQq4ShCyeCZ9x/oBgaU+t7BvHn+0P6MozYvS/Xy/sAorSxzuC4aqfn/XnaAvhgXEvgkeLYL5IQuycbIoxgxExao+tAwzCloEZjrUGtEyz5+EpUfYQVaAC73S+KQdSqswAAAABJRU5ErkJggg==',
    },
    {
      'id': 4,
      'name': 'Environmental Defense Fund',
      'link': 'https://www.greenclimate.fund/',
      'image':
          'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjUlHyU3Nzc3Nzc3Nzc3Nzc3Ny03Ljc3Nzg1NzU3NzcxNzI1Nzc1Nzc3MjU1ODctNzUtMS02N//AABEIABwAHAMBEQACEQEDEQH/xAAaAAACAgMAAAAAAAAAAAAAAAAGBwMEAAEF/8QAKhAAAgEDAQcCBwAAAAAAAAAAAQIDAAQRMQUGEkFRcZETIQcUMkJhcrH/xAAaAQADAAMBAAAAAAAAAAAAAAAABAUBAgMG/8QAIREAAgEEAgIDAAAAAAAAAAAAAQIAAwQRIRIxUdEFEyL/2gAMAwEAAhEDEQA/AHXd3MVnbvPO2EQZPU/gVo7rTUs3UwzBRkwZud75MlrWzHp8vVb3PjSpjfJ70uoq1yewJc2HvVZ7TmFrNi3vD9MZOVk/U8+2vfWnqFytYeDNqVyrnidGEFMRmBfxCvpIDbwK5VGRmAHNtBU2/wCTMqjqI3rlRAJ70rGschIJ+7qK4LRGcyS91xUKZR+bnsyl1FJlraVZY8nPurA+Ko0bfiPtxucKNSojA5yAdR+xtxxqxUrxAHhOopiergt8QN2n25YxXFmCb60JMa5x6inVe/MeOdCgcw3iI39qa9P89iKO4keN2iuwYpIjhhKOFgehBplbSkG5gepENqSMOdidnc3d672/tGCeKIjZsMqtNO4wrhSCUXqTjHQf3pUYIDnuN2Vo5IJ6Ed1JS9MohInt4JGLPDGzHmygmjMxgSRFVFCooVRoAMAUTM3RCf/Z',
    },
    {
      'id': 5,
      'name': 'The Nature Conservancy',
      'link': 'https://www.nature.org/en-us/',
      'image':
          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAAZlBMVEVHcExJqUJEqDxqtWWizp/g79/////s9ezl8eS52rcNlgKQyY1JqUJDpzwvoSV3unP2+/av1a07pTPU6NOby5lJqUJhslxssmiZype+3b2IwoTI4sb///8bmw9IqUFJqUL////+//6rYaQLAAAAInRSTlMAS5jC5////s2XVAz//////v3//4rh/xn////+if/J6pKoVrwrRAAAAZZJREFUeAFtk9ti2yAQRLEaHZqG69IiAbXV/v9PVhFBsd2cR+0wO6Bddcdl+vYyo7+//lBf8DaZHes8EOL09lzfyx2JAMn9fDz+y5xkALKNdyaL+cR6ANZi5uU8//79FFQIULU2DI/d361uCPLsPVSoKZz5XOFUGOcKoYH2/P5oICsQ7fBYYQbwmKUbCABJukAKnRjWaRd8Brcih4uLMF8Dc0qyv28PDjgXqYdCoLoCBXc5ImaA4laI0pt4kQYNN6mbMWllhlgB3ZOKNZJgDu6mtqNBYeDOF9XQZFM94pzoNDGDayFbo3a/AFR6vRt0ctnVausWVfcG4qwZ2L2+vYeUrNEZQF9b8NbccTsmxV4bvgDM46aDSV3GFLnAQX5wuCjVfw8k4aA+CD6mUWyCkp8cxJrpnLdr6IozgoiJXpZzoK0PkDKMS7QGvKqDrW9EbVBDFOuMcwagjaEd7+Ly6mPOuj99qMt/Y2+tdXRalV7vHtv9XugS41pf3r5ePSMZCPxRTyxDYnMK+u9p/7j+t73Vdpvu1/8fcgkpFOQptUcAAAAASUVORK5CYII=',
    },
    {
      'id': 6,
      'name': 'Hijauku',
      'link': 'https://hijauku.com/#google_vignette',
      'image':
          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABwAAAAcCAMAAABF0y+mAAAASFBMVEVHcEx50iN20hx30h540yF70yV+0yuB0zJ60iNz0hV90yx90yt80yuT11J30h2h2ml80yd70yWK1UR/0y+J1EGo3XGp2neo2XXze3LqAAAAGHRSTlMAuuzczK2CQsP/YXVqLPYVn5EgVDUKU2OynqUiAAAA6UlEQVR4Ab3RBWKEQBBE0RqfZtzI/W+aXt+45+F8HPyMkGdKaWMdnvD01PbkTFL6Qkmu4S4airhJmajgqpIF7PliJiWieh8bYHgCyw6CMq4a1ScxEPVrtGSASvmIHAbx7CKQB4zpifV8jOMaN1JPLuvuX5U3+puxEAn087vNxfH+xRuRDG6mfrI9iaj0xNOIKd6JrLuxxXBiJ04CT7bjdaLDGrA1O57zKoQyTEtVujbWFK4G7f3pwnpUVY33Roigq21V1KrF+Q+mBadKR0ml8ASerbXKwqnq7MD2hz3xNHna94eEk77wnx4BYooN7okVWDUAAAAASUVORK5CYII=',
    }
  ];

 List<dynamic> items = []; // Daftar untuk menyimpan item favorit yang diambil dari Firestore

// Fungsi untuk memuat item dari koleksi Firestore
Future<void> _loadItems() async {
  CollectionReference favorites = FirebaseFirestore.instance.collection('favorites'); // Mengakses koleksi 'favorites'
  QuerySnapshot querySnapshot = await favorites.get(); // Mengambil semua dokumen dalam koleksi
  setState(() { // Memperbarui state untuk merender ulang UI
    items = querySnapshot.docs // Mengonversi dokumen menjadi daftar Map
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  });
}

// Fungsi untuk menambah data ke Firestore
Future<void> _addFavorite(Map<String, dynamic> favorite) async {
  CollectionReference favorites = FirebaseFirestore.instance.collection('favorites'); // Mengakses koleksi 'favorites'
  await favorites.doc(favorite['id'].toString()).set(favorite); // Menyimpan data favorit menggunakan ID sebagai dokumen
  setState(() { // Memperbarui state untuk merender ulang UI
    items.add(favorite); // Menambahkan item favorit ke daftar lokal
  });
}

// Fungsi untuk menghapus data dari Firestore
Future<void> _removeFavorite(int id) async {
  CollectionReference favorites = FirebaseFirestore.instance.collection('favorites'); // Mengakses koleksi 'favorites'
  await favorites.doc(id.toString()).delete(); // Menghapus dokumen berdasarkan ID
  setState(() { // Memperbarui state untuk merender ulang UI
    items.removeWhere((item) => item['id'] == id); // Menghapus item dari daftar lokal
  });
}

@override
void initState() {
  super.initState(); // Memanggil initState dari superclass
  _loadItems(); // Memuat item saat widget diinisialisasi
}

// Fungsi untuk meluncurkan URL di browser
_launchURL(String url) async {
  if (await canLaunch(url)) { // Memeriksa apakah URL dapat diluncurkan
    await launch(url); // Meluncurkan URL
  } else {
    throw 'Could not launch $url'; // Menangani error jika URL tidak dapat diluncurkan
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold( // Struktur dasar halaman
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 2, 85, 6), // Warna latar belakang AppBar
      title: const Text(
        'Link Rekomendasi', // Judul halaman
        style: TextStyle(color: Colors.white), // Mengubah warna teks menjadi putih
      ),
    ),
    body: Container(
      margin: const EdgeInsets.all(20), // Margin di sekitar konten
      child: GridView.builder( // Membuat tampilan grid untuk item
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah kolom
          crossAxisSpacing: 10, // Jarak antar kolom
          mainAxisSpacing: 10, // Jarak antar baris
        ),
        itemCount: linkRekomendations.length, // Jumlah item dalam grid
        itemBuilder: (context, index) { // Membangun item grid
          return Card( // Kontainer untuk setiap item
            color: const Color.fromARGB(255, 211, 211, 211), // Warna latar belakang kartu
            child: InkWell( // Widget yang mendukung interaksi sentuh
              onTap: () { // Aksi ketika item ditekan
                _launchURL(linkRekomendations[index]['link']); // Meluncurkan URL terkait
              },
              child: Padding(
                padding: const EdgeInsets.all(8), // Padding di sekitar konten dalam kartu
                child: Column( // Mengatur konten dalam kolom
                  crossAxisAlignment: CrossAxisAlignment.center, // Mengatur alignment kolom ke tengah
                  mainAxisAlignment: MainAxisAlignment.center, // Mengatur alignment kolom ke tengah
                  children: [
                    SizedBox(
                      height: 50, // Tinggi gambar
                      width: 50, // Lebar gambar
                      child: Image.network(linkRekomendations[index]['image']), // Menampilkan gambar dari URL
                    ),
                    const SizedBox(height: 10), // Spasi antara gambar dan teks
                    Text(linkRekomendations[index]['name'], // Menampilkan nama rekomendasi
                      style: const TextStyle(fontWeight: FontWeight.bold)), // Mengatur gaya teks
                    IconButton( // Tombol ikon untuk menandai favorit
                      icon: Icon(
                        items.any((item) => // Mengecek apakah item sudah ada dalam daftar favorit
                          item['id'] == linkRekomendations[index]['id'])
                          ? Icons.favorite // Ikon jika sudah menjadi favorit
                          : Icons.favorite_border, // Ikon jika belum menjadi favorit
                        color: Colors.red, // Warna ikon favorit
                      ),
                      onPressed: () async { // Aksi ketika tombol ikon ditekan
                        bool isFavorite = items.any((item) => // Mengecek status favorit
                          item['id'] == linkRekomendations[index]['id']);
                        if (!isFavorite) { // Jika belum favorit
                          await _addFavorite(linkRekomendations[index]); // Menambahkan ke favorit
                          ScaffoldMessenger.of(context).showSnackBar( // Menampilkan snackbar
                            SnackBar(
                              content: Text(
                                '${linkRekomendations[index]['name']} added to favorites'), // Pesan snackbar
                              backgroundColor: Colors.green, // Warna latar belakang snackbar
                            ),
                          );
                        } else { // Jika sudah favorit
                          await _removeFavorite(linkRekomendations[index]['id']); // Menghapus dari favorit
                          ScaffoldMessenger.of(context).showSnackBar( // Menampilkan snackbar
                            SnackBar(
                              content: Text(
                                '${linkRekomendations[index]['name']} removed from favorites'), // Pesan snackbar
                              backgroundColor: Colors.red, // Warna latar belakang snackbar
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}}