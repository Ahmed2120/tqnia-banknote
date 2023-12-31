// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
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
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDWRQmEes5HDrkxoG-aDE0fuaF2Yfh9ZVU',
    appId: '1:513034986481:web:90f12a35239226516eda50',
    messagingSenderId: '513034986481',
    projectId: 'banknote-5f6be',
    authDomain: 'banknote-5f6be.firebaseapp.com',
    storageBucket: 'banknote-5f6be.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAH73pg6lSX9EAfGuCs6zbgldzMrcMX7hk',
    appId: '1:513034986481:android:b835fb2bf445f9fe6eda50',
    messagingSenderId: '513034986481',
    projectId: 'banknote-5f6be',
    storageBucket: 'banknote-5f6be.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAL-Xvf5gollw4z5A5RR4vhWRXEl0Su5IE',
    appId: '1:513034986481:ios:31d436dde4581d0d6eda50',
    messagingSenderId: '513034986481',
    projectId: 'banknote-5f6be',
    storageBucket: 'banknote-5f6be.appspot.com',
    iosBundleId: 'com.tqniait.banknote',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAL-Xvf5gollw4z5A5RR4vhWRXEl0Su5IE',
    appId: '1:513034986481:ios:e32a2bbb12e0c5826eda50',
    messagingSenderId: '513034986481',
    projectId: 'banknote-5f6be',
    storageBucket: 'banknote-5f6be.appspot.com',
    iosBundleId: 'com.tqniait.banknote.RunnerTests',
  );
}
