// File generated by FlutterFire CLI. // Menunjukkan bahwa file ini dihasilkan secara otomatis oleh alat FlutterFire CLI.
// ignore_for_file: type=lint // Mengabaikan peringatan linting untuk file ini

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions; // Mengimpor FirebaseOptions dari paket Firebase Core
import 'package:flutter/foundation.dart' // Mengimpor komponen dasar Flutter
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
/// 
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  // Mendapatkan FirebaseOptions berdasarkan platform saat ini
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) { // Memeriksa apakah platform adalah web
      return web; // Mengembalikan opsi untuk web
    }
    switch (defaultTargetPlatform) { // Memeriksa platform target saat ini
      case TargetPlatform.android: // Jika platform Android
        return android; // Mengembalikan opsi untuk Android
      case TargetPlatform.iOS: // Jika platform iOS
        return ios; // Mengembalikan opsi untuk iOS
      case TargetPlatform.macOS: // Jika platform macOS
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        ); // Menampilkan kesalahan jika belum dikonfigurasi
      case TargetPlatform.windows: // Jika platform Windows
        return windows; // Mengembalikan opsi untuk Windows
      case TargetPlatform.linux: // Jika platform Linux
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        ); // Menampilkan kesalahan jika belum dikonfigurasi
      default: // Jika platform tidak dikenal
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        ); // Menampilkan kesalahan jika platform tidak didukung
    }
  }

  // Opsi Firebase untuk platform web
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAZB0s_ps4usr_8GXoqpKR-dR99CW3-RcM', // Kunci API untuk web
    appId: '1:294484172277:web:956abbf176184bd2d694bc', // ID aplikasi web
    messagingSenderId: '294484172277', // ID pengirim pesan
    projectId: 'kenafi', // ID proyek Firebase
    authDomain: 'kenafi.firebaseapp.com', // Domain otentikasi
    storageBucket: 'kenafi.appspot.com', // Bucket penyimpanan
    measurementId: 'G-GSGC5V16BH', // ID pengukuran
  );

  // Opsi Firebase untuk platform Android
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDcPlvPeU8EQiVyppRX7cNlQUrR4fzjbEg', // Kunci API untuk Android
    appId: '1:294484172277:android:571b0ed29dd125ddd694bc', // ID aplikasi Android
    messagingSenderId: '294484172277', // ID pengirim pesan
    projectId: 'kenafi', // ID proyek Firebase
    storageBucket: 'kenafi.appspot.com', // Bucket penyimpanan
  );

  // Opsi Firebase untuk platform iOS
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6oy-IaRPdv3HVN9N8G1BPofAhR6ql0So', // Kunci API untuk iOS
    appId: '1:294484172277:ios:c1cd1f66a5dc2ec2d694bc', // ID aplikasi iOS
    messagingSenderId: '294484172277', // ID pengirim pesan
    projectId: 'kenafi', // ID proyek Firebase
    storageBucket: 'kenafi.appspot.com', // Bucket penyimpanan
    iosBundleId: 'com.example.kenafi', // Bundle ID untuk iOS
  );

  // Opsi Firebase untuk platform Windows
  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAZB0s_ps4usr_8GXoqpKR-dR99CW3-RcM', // Kunci API untuk Windows
    appId: '1:294484172277:web:c6097c329ed34fbdd694bc', // ID aplikasi Windows
    messagingSenderId: '294484172277', // ID pengirim pesan
    projectId: 'kenafi', // ID proyek Firebase
    authDomain: 'kenafi.firebaseapp.com', // Domain otentikasi
    storageBucket: 'kenafi.appspot.com', // Bucket penyimpanan
    measurementId: 'G-Z3DG08SXXT', // ID pengukuran
  );
}