import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return android;
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      return ios;
    } else {
      throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUdP_2CVEIhqB1EwaBkrbvRB5DjnsjrTI',
    appId: '1:758997374577:android:d4ea9f948bca3af765add0',
    messagingSenderId: '758997374577',
    projectId: 'spinndo-da216',
    storageBucket: 'spinndo-da216.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '<YOUR_IOS_API_KEY>',
    appId: '<YOUR_IOS_APP_ID>',
    messagingSenderId: '<YOUR_MESSAGING_SENDER_ID>',
    projectId: '<YOUR_PROJECT_ID>',
    storageBucket: '<YOUR_STORAGE_BUCKET>',
    iosBundleId: '<YOUR_IOS_BUNDLE_ID>',
  );
}
