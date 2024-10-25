import 'package:flutter/cupertino.dart'; // Mengimpor paket Cupertino untuk komponen UI iOS

// ignore: must_be_immutable
class TouchableOpacity extends StatelessWidget {
  Widget child; // Widget anak yang akan ditampilkan dalam tombol
  void Function()? onTap; // Fungsi callback yang akan dipanggil saat tombol ditekan

  // Konstruktor untuk TouchableOpacity dengan parameter yang diperlukan
  TouchableOpacity({
    Key? key, // Key opsional untuk widget
    required this.child, // Widget anak yang diperlukan
    required this.onTap, // Fungsi onTap yang diperlukan
  }) : super(key: key); // Memanggil konstruktor superclass

  @override
  Widget build(BuildContext context) {
    // Membangun UI untuk TouchableOpacity
    return CupertinoButton(
      padding: const EdgeInsets.all(0), // Mengatur padding menjadi nol
      onPressed: onTap, // Mengaitkan fungsi onTap dengan aksi tombol
      child: child, // Menampilkan widget anak
    );
  }
}