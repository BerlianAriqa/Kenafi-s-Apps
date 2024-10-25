import 'package:flutter/material.dart'; // Mengimpor paket Material untuk komponen UI

// Mendefinisikan MyTextField sebagai StatelessWidget
class MyTextField extends StatelessWidget {
  final String hintText; // Teks petunjuk yang akan ditampilkan di dalam field
  final bool obscureText; // Menentukan apakah teks yang dimasukkan harus disembunyikan (seperti password)
  final TextEditingController controller; // Kontrol untuk mengelola teks yang dimasukkan
  final Widget? prefixIcon; // Ikon di depan input field
  final Widget? suffixIcon; // Ikon di belakang input field

  // Konstruktor untuk MyTextField dengan parameter yang diperlukan
  const MyTextField({
    super.key, // Key opsional untuk widget
    required this.hintText, // Mengharuskan teks petunjuk
    required this.obscureText, // Mengharuskan status obscuring
    required this.controller, // Mengharuskan controller teks
    this.prefixIcon, // Ikon depan opsional
    this.suffixIcon, // Ikon belakang opsional
  });

  @override
  Widget build(BuildContext context) {
    // Membangun UI untuk MyTextField
    return TextField(
      controller: controller, // Menghubungkan controller dengan TextField
      obscureText: obscureText, // Mengatur apakah teks disembunyikan
      decoration: InputDecoration( // Mengatur dekorasi untuk teks field
        border: OutlineInputBorder( // Border default
          borderRadius: BorderRadius.circular(12), // Sudut melengkung pada border
          borderSide: const BorderSide(color: Colors.grey), // Warna border default
        ),
        focusedBorder: OutlineInputBorder( // Border saat field dalam fokus
          borderRadius: BorderRadius.circular(12), // Sudut melengkung pada border
          borderSide: const BorderSide(color: Colors.green), // Warna border saat fokus
        ),
        hintText: hintText, // Teks petunjuk yang ditampilkan di dalam field
        hintStyle: const TextStyle(color: Colors.grey), // Gaya teks untuk hint
        prefixIcon: prefixIcon, // Menampilkan ikon di depan input field jika ada
        suffixIcon: suffixIcon, // Menampilkan ikon di belakang input field jika ada
        contentPadding: const EdgeInsets.all(15), // Padding di dalam field
      ),
    );
  }
}