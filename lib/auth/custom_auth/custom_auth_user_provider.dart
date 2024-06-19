import 'package:rxdart/rxdart.dart';

import '/backend/schema/structs/index.dart';
import 'custom_auth_manager.dart';

class SabeeoAuthUser {
  SabeeoAuthUser({
    required this.loggedIn,
    this.uid,
    this.userData,
  });

  bool loggedIn;
  String? uid;
  UserStruct? userData;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<SabeeoAuthUser> sabeeoAuthUserSubject =
    BehaviorSubject.seeded(SabeeoAuthUser(loggedIn: false));
Stream<SabeeoAuthUser> sabeeoAuthUserStream() =>
    sabeeoAuthUserSubject.asBroadcastStream().map((user) => currentUser = user);
