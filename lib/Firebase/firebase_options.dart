// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyD3vcoYoqcSNIrS22aUQQ__Cotwm1nu87g',
    appId: '1:505770952300:web:b1638e585ca8488e6f3a49',
    messagingSenderId: '505770952300',
    projectId: 'pemob-ea408',
    authDomain: 'pemob-ea408.firebaseapp.com',
    storageBucket: 'pemob-ea408.appspot.com',
    measurementId: 'G-0J68DQZ1M2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYT2h5pr19dEx4JpvZ9zRUWbVBVGEaeS4',
    appId: '1:505770952300:android:7cedd7a2f43649876f3a49',
    messagingSenderId: '505770952300',
    projectId: 'pemob-ea408',
    storageBucket: 'pemob-ea408.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCjAX4vbj0Ox_UvioagNN1Fs8n5A7QraOk',
    appId: '1:505770952300:ios:0a265c64bd5d1f716f3a49',
    messagingSenderId: '505770952300',
    projectId: 'pemob-ea408',
    storageBucket: 'pemob-ea408.appspot.com',
    iosBundleId: 'com.example.adamfaizFinalprojectSandi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCjAX4vbj0Ox_UvioagNN1Fs8n5A7QraOk',
    appId: '1:505770952300:ios:0a265c64bd5d1f716f3a49',
    messagingSenderId: '505770952300',
    projectId: 'pemob-ea408',
    storageBucket: 'pemob-ea408.appspot.com',
    iosBundleId: 'com.example.adamfaizFinalprojectSandi',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD3vcoYoqcSNIrS22aUQQ__Cotwm1nu87g',
    appId: '1:505770952300:web:97e4438240d069a86f3a49',
    messagingSenderId: '505770952300',
    projectId: 'pemob-ea408',
    authDomain: 'pemob-ea408.firebaseapp.com',
    storageBucket: 'pemob-ea408.appspot.com',
    measurementId: 'G-EVSC05RBZY',
  );
}
