import 'package:flutter/material.dart'; // Mengimpor paket Material untuk komponen UI
import 'package:kenafi/auth/auth.dart'; // Mengimpor halaman otentikasi
import 'package:kenafi/firebase_options.dart'; // Mengimpor konfigurasi Firebase
import 'package:kenafi/theme/light_mode.dart'; // Mengimpor tema untuk mode terang
import 'package:firebase_core/firebase_core.dart'; // Mengimpor paket inti Firebase
import 'dart:async'; // Mengimpor pustaka untuk penggunaan timer

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Memastikan binding widget diinisialisasi sebelum menjalankan aplikasi
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Menginisialisasi Firebase dengan opsi yang sesuai untuk platform saat ini
  runApp(const MyApp()); // Menjalankan aplikasi dengan widget MyApp sebagai root
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Konstruktor untuk MyApp

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug di sudut kanan atas
      home: const SplashScreen(), // Menetapkan SplashScreen sebagai halaman awal
      theme: lightMode, // Mengatur tema aplikasi ke lightMode
    );
  }
}

// Mendefinisikan SplashScreen sebagai StatefulWidget
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key}); // Konstruktor untuk SplashScreen

  @override
  State<SplashScreen> createState() => _SplashScreenState(); // Menghubungkan dengan state yang sesuai
}

// State untuk SplashScreen
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState(); // Memanggil initState dari superclass
    Timer(const Duration(seconds: 3), () { // Mengatur timer selama 3 detik
      Navigator.of(context).pushReplacement( // Mengganti halaman saat timer selesai
        MaterialPageRoute(builder: (context) => const AuthPage()), // Navigasi ke AuthPage
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Membangun UI untuk SplashScreen
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 4), // Durasi animasi
        decoration: BoxDecoration(
          gradient: LinearGradient( // Mengatur latar belakang dengan gradien
            colors: [
              const Color.fromARGB(255, 2, 85, 6), // Warna hijau gelap
              const Color.fromARGB(255, 188, 255, 152), // Warna kuning muda
            ],
            begin: Alignment.topLeft, // Titik awal gradien
            end: Alignment.bottomRight, // Titik akhir gradien
          ),
        ),
        child: Center( // Menyusun konten di tengah
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Menyusun kolom di tengah secara vertikal
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Bentuk lingkaran
                  color: Colors.white, // Warna latar belakang lingkaran
                ),
                padding: const EdgeInsets.all(20), // Padding di sekitar ikon
                child: const Icon(
                  Icons.forest, // Ikon hutan
                  size: 80, // Ukuran ikon
                  color: Colors.green, // Warna ikon
                ),
              ),
              const SizedBox(height: 20), // Spacing antara ikon dan teks
              const Text(
                'KENAFI APPS', // Teks yang ditampilkan
                style: TextStyle(
                  fontSize: 24, // Ukuran font
                  fontWeight: FontWeight.bold, // Ketebalan font
                  color: Colors.white, // Warna teks
                ),
              ),
              const SizedBox(height: 20), // Spacing antara teks dan indikator loading
              const CircularProgressIndicator(), // Indikator loading
            ],
          ),
        ),
      ),
    );
  }
}