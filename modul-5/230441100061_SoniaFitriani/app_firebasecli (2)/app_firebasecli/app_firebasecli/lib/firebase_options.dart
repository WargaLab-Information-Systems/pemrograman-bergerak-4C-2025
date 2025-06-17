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
    apiKey: 'AIzaSyAMW5aAni-Gjxx9-CykrmVZVKjWX3MFVy0',
    appId: '1:523932937655:web:ceddc34c690397aa508c32',
    messagingSenderId: '523932937655',
    projectId: 'api-sonia-9999c',
    authDomain: 'api-sonia-9999c.firebaseapp.com',
    databaseURL: 'https://api-sonia-9999c-default-rtdb.firebaseio.com',
    storageBucket: 'api-sonia-9999c.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZY8m23EzSXjUicUDrrzltA_IkTm541Eg',
    appId: '1:523932937655:android:ed1e26bed14118e6508c32',
    messagingSenderId: '523932937655',
    projectId: 'api-sonia-9999c',
    databaseURL: 'https://api-sonia-9999c-default-rtdb.firebaseio.com',
    storageBucket: 'api-sonia-9999c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAz2hnFAyI18xjI1xHWEk43262MBeNCpY',
    appId: '1:523932937655:ios:9994439d9824e3dd508c32',
    messagingSenderId: '523932937655',
    projectId: 'api-sonia-9999c',
    databaseURL: 'https://api-sonia-9999c-default-rtdb.firebaseio.com',
    storageBucket: 'api-sonia-9999c.firebasestorage.app',
    iosBundleId: 'com.example.appFirebasecli',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAAz2hnFAyI18xjI1xHWEk43262MBeNCpY',
    appId: '1:523932937655:ios:9994439d9824e3dd508c32',
    messagingSenderId: '523932937655',
    projectId: 'api-sonia-9999c',
    databaseURL: 'https://api-sonia-9999c-default-rtdb.firebaseio.com',
    storageBucket: 'api-sonia-9999c.firebasestorage.app',
    iosBundleId: 'com.example.appFirebasecli',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAMW5aAni-Gjxx9-CykrmVZVKjWX3MFVy0',
    appId: '1:523932937655:web:7a63dcbd17084132508c32',
    messagingSenderId: '523932937655',
    projectId: 'api-sonia-9999c',
    authDomain: 'api-sonia-9999c.firebaseapp.com',
    databaseURL: 'https://api-sonia-9999c-default-rtdb.firebaseio.com',
    storageBucket: 'api-sonia-9999c.firebasestorage.app',
  );

}