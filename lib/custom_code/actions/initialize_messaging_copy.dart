// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io'; // Required for Platform check

Future initializeMessagingCopy() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  try {
    // Commented out permission request
    // FirebaseMessaging.instance.requestPermission().then((settings) async {
    //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //     try {
    //       String? token = await FirebaseMessaging.instance.getToken();
    //       FFAppState().fcmToken = token ?? 'No token';
    //       print('FCM token: $token');
    //     } catch (error) {
    //       FFAppState().fcmToken = 'Token retrieval failed';
    //       print('Error getting FCM token: $error');
    //     }
    //   } else {
    //     FFAppState().fcmToken = 'Push permission not approved';
    //     print('Push notifications permission not granted.');
    //   }
    // }).catchError((error) {
    //   FFAppState().fcmToken = 'Permission request failed';
    //   print('Error requesting push notification permissions: $error');
    // });

    // Directly fetch token
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      FFAppState().fcmToken = token ?? 'No token';
      print('FCM token: $token');
    } catch (error) {
      FFAppState().fcmToken = 'Token retrieval failed';
      print('Error getting FCM token: $error');
    }

    // Fetch APNs token for iOS with retry mechanism
    if (Platform.isIOS) {
      String? apnsToken = await getAPNSTokenWithRetry();
      if (apnsToken != null) {
        print('APNs token: $apnsToken');
        FFAppState().apnsToken = apnsToken;
        FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
          print("FCM Token refreshed: $fcmToken");
          FFAppState().fcmToken = fcmToken ?? 'No token';
        });
      } else {
        print('APNs token not available after retry.');
      }
    }

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Received message: ${message.notification?.title}');
    });
  } catch (error) {
    print('Error in initializing messaging: $error');
    FFAppState().fcmToken = 'Initialization failed';
  }
}

// Function to retry getting APNs token
Future<String?> getAPNSTokenWithRetry(
    {int retries = 3, Duration delay = const Duration(seconds: 3)}) async {
  for (int i = 0; i < retries; i++) {
    try {
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        return apnsToken;
      }
    } catch (error) {
      print('Error getting APNs token on attempt ${i + 1}: $error');
    }
    await Future<void>.delayed(delay);
  }
  return null;
}
