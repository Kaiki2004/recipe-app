import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAbdcHufh6F63wSzKPyb1GH09ulSEdH4H8',
    authDomain: 'app-culinaria.firebaseapp.com',
    projectId: 'app-culinaria',
    storageBucket: 'app-culinaria.appspot.com',
    messagingSenderId: '533238709437',
    appId: '1:533238709437:web:c5b0424d8f55394d894bd4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA6FN6GdMLrkg6LNviXyD9hMx1LqeD7-Qc',
    appId: '1:533238709437:android:39fe7617aa1f8f06894bd4',
    messagingSenderId: '533238709437',
    projectId: 'app-culinaria',
    storageBucket: 'app-culinaria.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'api_key_aqui', // Ainda falta configurar o iOS no Firebase!
    appId: 'app_id_aqui',
    messagingSenderId: '533238709437',
    projectId: 'app-culinaria',
    storageBucket: 'app-culinaria.appspot.com',
    iosBundleId: 'com.example.recipe', // Supondo que seja esse
  );
}
