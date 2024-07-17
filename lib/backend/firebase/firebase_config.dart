import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDeBSe-4FF1dmMya2HUeuDjUuIEJ-_ZiWI",
            authDomain: "sabeeo-6d3a5.firebaseapp.com",
            projectId: "sabeeo-6d3a5",
            storageBucket: "sabeeo-6d3a5.appspot.com",
            messagingSenderId: "300052433540",
            appId: "1:300052433540:web:3020ebd1a4a269f9b0d0d1"));
  } else {
    await Firebase.initializeApp();
  }
}
