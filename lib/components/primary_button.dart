import 'package:flutter/material.dart'; // Mengimpor paket Material untuk komponen UI
import 'package:kenafi/theme/themes.dart'; // Mengimpor tema khusus dari proyek
import 'touchable_opacity.dart'; // Mengimpor widget TouchableOpacity untuk mendeteksi ketukan

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  String? text; // Teks yang akan ditampilkan pada tombol
  void Function()? onTap; // Fungsi callback yang akan dipanggil saat tombol ditekan
  Color? color; // Warna latar belakang tombol
  Color? textColor; // Warna teks tombol
  Widget? child; // Widget anak yang dapat ditampilkan dalam tombol
  EdgeInsets? padding; // Padding di sekitar konten tombol
  Border? border; // Border untuk tombol

  // Konstruktor untuk PrimaryButton dengan parameter opsional
  PrimaryButton({
    Key? key,
    this.text,
    this.onTap,
    this.color,
    this.textColor,
    this.child,
    this.padding,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mengatur nilai default untuk warna, warna teks, dan padding
    color ??= KenafiColors.primary; // Menggunakan warna utama jika tidak ditentukan
    textColor ??= Colors.white; // Menggunakan warna putih untuk teks jika tidak ditentukan
    padding ??= const EdgeInsets.all(16); // Menggunakan padding default jika tidak ditentukan

    // Membuat tombol dengan efek ketukan
    return TouchableOpacity(
      onTap: onTap ?? () {}, // Memanggil fungsi onTap jika ada, jika tidak, tidak melakukan apa-apa
      child: AnimatedContainer( // Membuat container yang dapat dianimasikan
        duration: const Duration(milliseconds: 300), // Durasi animasi
        padding: padding, // Padding di sekitar konten
        decoration: BoxDecoration(
          border: border, // Border tombol
          color: onTap != null ? color : KenafiColors.grayStroke, // Mengatur warna latar belakang berdasarkan apakah onTap ada
          borderRadius: BorderRadius.circular(12), // Sudut melengkung pada tombol
          boxShadow: onTap != null // Mengatur bayangan jika onTap ada
              ? [
                  BoxShadow(
                    color: color!.withOpacity(0.5), // Warna bayangan dengan opasitas
                    offset: const Offset(0, 4), // Offset bayangan
                    blurRadius: 12, // Blur radius untuk bayangan
                  )
                ]
              : [],
        ),
        child: Center(
          child: child ?? // Jika child tidak ada, tampilkan teks
              Text(
                text!,
                style: KenafiFonts(context).boldQuicksand(size: 14).apply(
                      color: onTap != null
                          ? textColor
                          : KenafiColors.black.withOpacity(0.6), // Warna teks berdasarkan status onTap
                    ),
              ),
        ),
      ),
    );
  }
}

// Mendefinisikan AnimatedButtonLogin sebagai StatefulWidget
class AnimatedButtonLogin extends StatefulWidget {
  const AnimatedButtonLogin({super.key}); // Konstruktor dengan key opsional

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedButtonLoginState createState() => _AnimatedButtonLoginState(); // Menghubungkan dengan state yang sesuai
}

// State untuk AnimatedButtonLogin
class _AnimatedButtonLoginState extends State<AnimatedButtonLogin> {
  bool _clicked = false; // Status untuk mengetahui apakah tombol telah diklik

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        setState(() {
          _clicked = !_clicked; // Mengubah status saat tombol diklik
        });
      },
      child: AnimatedContainer( // Membuat container yang dapat dianimasikan
        width: _clicked ? 50 : MediaQuery.of(context).size.width, // Mengubah lebar berdasarkan status klik
        height: 50, // Tinggi tetap untuk tombol
        curve: Curves.fastOutSlowIn, // Kurva animasi
        duration: const Duration(milliseconds: 400), // Durasi animasi
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_clicked ? 50 : 15), // Mengubah sudut melengkung berdasarkan status klik
          gradient: const LinearGradient( // Gradien latar belakang
            colors: [
              KenafiColors.secondary, // Warna gradien awal
              KenafiColors.primary, // Warna gradien akhir
            ],
            begin: Alignment.centerLeft, // Titik awal gradien
            end: Alignment.centerRight, // Titik akhir gradien
          ),
        ),
        child: Center(
            child: Text(
          'LOGIN', // Teks yang ditampilkan di tengah tombol
          style: KenafiFonts(context).boldQuicksand(
            color: KenafiColors.lightPrimary, // Warna teks
            size: 14, // Ukuran font
          ),
        )),
      ),
    );
  }
}