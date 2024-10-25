import 'package:flutter/material.dart'; // Mengimpor paket Material untuk komponen UI
import 'dart:async'; // Mengimpor paket untuk menggunakan Timer

// Mendefinisikan StopwatchPage sebagai StatefulWidget
class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState(); // Menghubungkan dengan state yang sesuai
}

// State untuk StopwatchPage
class _StopwatchPageState extends State<StopwatchPage> {
  int _elapsedMilliseconds = 0; // Menyimpan waktu yang telah berlalu dalam milidetik
  late Timer _timer; // Deklarasi timer untuk menghitung waktu
  bool _isRunning = false; // Status untuk mengetahui apakah stopwatch sedang berjalan
  bool _isPaused = false; // Status untuk mengetahui apakah stopwatch sedang dijeda

  // Fungsi untuk memulai timer
  void _startTimer() {
    if (!_isRunning) { // Memastikan timer tidak berjalan
      _isRunning = true; // Menandai timer sebagai berjalan
      _isPaused = true; // Menandai timer sebagai dijeda

      // Mengatur timer untuk memperbarui setiap 10 milidetik
      _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
        setState(() {
          _elapsedMilliseconds += 10; // Menambah waktu yang telah berlalu
        });
      });
    }
  }

  // Fungsi untuk menjeda timer
  void _pauseTimer() {
    if (_isRunning) { // Memastikan timer sedang berjalan
      _isRunning = false; // Menandai timer sebagai tidak berjalan
      _isPaused = true; // Menandai timer sebagai dijeda
      _timer.cancel(); // Menghentikan timer
    }
  }

  // Fungsi untuk melanjutkan timer setelah dijeda
  void _continueTimer() {
    if (_isPaused) { // Memastikan timer sedang dijeda
      _startTimer(); // Memulai kembali timer
    }
  }

  // Fungsi untuk mereset timer
  void _resetTimer() {
    _isRunning = false; // Menandai timer sebagai tidak berjalan
    _isPaused = false; // Menandai timer sebagai tidak dijeda
    _elapsedMilliseconds = 0; // Mengatur waktu yang telah berlalu menjadi 0
    if (_timer.isActive) { // Memastikan timer aktif
      _timer.cancel(); // Menghentikan timer
    }
    setState(() {}); // Memperbarui UI
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung jam, menit, detik, dan milidetik dari waktu yang telah berlalu
    final hours = (_elapsedMilliseconds ~/ (1000 * 3600));
    final minutes = (_elapsedMilliseconds ~/ (1000 * 60)) % 60;
    final seconds = (_elapsedMilliseconds ~/ 1000) % 60;
    final milliseconds = (_elapsedMilliseconds ~/ 1) % 1000; // Ambil 2 digit terakhir

    return Scaffold( // Struktur dasar halaman
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 85, 6), // Warna latar belakang AppBar
        title: const Text(
          'Stopwatch',
          style: TextStyle(color: Colors.white), // Mengatur warna teks judul menjadi putih
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 188, 255, 152), // Warna latar belakang
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Padding di sekitar konten
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Mengatur posisi kolom di tengah
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround, // Mengatur jarak antar elemen
                  children: [
                    _timeCard(hours, 'Hours'), // Menampilkan jam
                    _timeCard(minutes, 'Minutes'), // Menampilkan menit
                    _timeCard(seconds, 'Seconds'), // Menampilkan detik
                    _timeCard(milliseconds, 'Milliseconds'), // Menampilkan milidetik
                  ],
                ),
                SizedBox(height: 40), // Spasi di bawah baris waktu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur jarak antar tombol
                  children: [
                    ElevatedButton(
                      onPressed: (!_isRunning && !_isPaused) ? _startTimer : null, // Mengaitkan fungsi start jika tidak berjalan dan tidak dijeda
                      child: Text('Start'), // Teks tombol Start
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Warna latar belakang tombol
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _isRunning ? _pauseTimer : null, // Mengaitkan fungsi pause jika sedang berjalan
                      child: Text('Pause'), // Teks tombol Pause
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF001E3C), // Warna latar belakang tombol
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _isPaused ? _continueTimer : null, // Mengaitkan fungsi continue jika sedang dijeda
                      child: Text('Continue'), // Teks tombol Continue
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Warna latar belakang tombol
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (_elapsedMilliseconds > 0) ? _resetTimer : null, // Mengaitkan fungsi reset jika ada waktu yang telah berlalu
                      child: Text('Reset'), // Teks tombol Reset
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF001E3C), // Warna latar belakang tombol
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan waktu dalam format yang teratur
  Widget _timeCard(int value, String label) {
    return Card(
      elevation: 4, // Elevasi untuk bayangan kartu
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Padding di dalam kartu
        child: Column(
          children: [
            Text(
              value.toString().padLeft(2, '0'), // Format 2 digit untuk waktu
              style: TextStyle(
                fontSize: 36, // Ukuran font untuk angka waktu
                fontWeight: FontWeight.bold, // Mengatur teks menjadi tebal
                color: Colors.green, // Warna teks
              ),
            ),
            SizedBox(height: 8), // Spasi di bawah angka
            Text(
              label, // Label untuk waktu (jam, menit, detik, milidetik)
              style: TextStyle(fontSize: 16), // Ukuran font untuk label
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Menghentikan timer jika masih aktif saat widget dibuang
    if (_timer.isActive) {
      _timer.cancel(); // Menghentikan timer
    }
    super.dispose(); // Memanggil dispose dari superclass
  }
}