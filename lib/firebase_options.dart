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

  static  FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDG30htGIhpf6b9jq2ox-ZSyfL_K3zJckU',
    appId: '1:647426385900:web:f0bc563b786a6fc03a02c9',
    messagingSenderId: '647426385900',
    projectId: 'chatvak-4c341',
    authDomain: 'chatvak-4c341.firebaseapp.com',
    storageBucket: 'chatvak-4c341.appspot.com',
  );

  static  FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAleH5yEHbaByWzjVjY8NmyTS4rcDIVxQ0',
    appId: '1:647426385900:android:b73cfdb46264e3eb3a02c9',
    messagingSenderId: '647426385900',
    projectId: 'chatvak-4c341',
    storageBucket: 'chatvak-4c341.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCCFrs3OVpKiwiAmPEnk7Cy_wcNq4-65B0',
    appId: '1:647426385900:ios:e934d53eb54fced73a02c9',
    messagingSenderId: '647426385900',
    projectId: 'chatvak-4c341',
    storageBucket: 'chatvak-4c341.appspot.com',
    iosBundleId: 'com.example.clickk',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCCFrs3OVpKiwiAmPEnk7Cy_wcNq4-65B0',
    appId: '1:647426385900:ios:a2ccc6da975af8023a02c9',
    messagingSenderId: '647426385900',
    projectId: 'chatvak-4c341',
    storageBucket: 'chatvak-4c341.appspot.com',
    iosBundleId: 'com.example.clickk.RunnerTests',
  );
}