import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      if (prefs.containsKey('ff_userAuthData')) {
        try {
          final serializedData = prefs.getString('ff_userAuthData') ?? '{}';
          _userAuthData = UserAuthDataStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _rememberMe = prefs.getBool('ff_rememberMe') ?? _rememberMe;
    });
    _safeInit(() {
      _fcmToken = prefs.getString('ff_fcmToken') ?? _fcmToken;
    });
    _safeInit(() {
      _apnsToken = prefs.getString('ff_apnsToken') ?? _apnsToken;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  UserAuthDataStruct _userAuthData =
      UserAuthDataStruct.fromSerializableMap(jsonDecode('{}'));
  UserAuthDataStruct get userAuthData => _userAuthData;
  set userAuthData(UserAuthDataStruct value) {
    _userAuthData = value;
    prefs.setString('ff_userAuthData', value.serialize());
  }

  void updateUserAuthDataStruct(Function(UserAuthDataStruct) updateFn) {
    updateFn(_userAuthData);
    prefs.setString('ff_userAuthData', _userAuthData.serialize());
  }

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;
  set rememberMe(bool value) {
    _rememberMe = value;
    prefs.setBool('ff_rememberMe', value);
  }

  List<dynamic> _anomaliesArray = [];
  List<dynamic> get anomaliesArray => _anomaliesArray;
  set anomaliesArray(List<dynamic> value) {
    _anomaliesArray = value;
  }

  void addToAnomaliesArray(dynamic value) {
    anomaliesArray.add(value);
  }

  void removeFromAnomaliesArray(dynamic value) {
    anomaliesArray.remove(value);
  }

  void removeAtIndexFromAnomaliesArray(int index) {
    anomaliesArray.removeAt(index);
  }

  void updateAnomaliesArrayAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    anomaliesArray[index] = updateFn(_anomaliesArray[index]);
  }

  void insertAtIndexInAnomaliesArray(int index, dynamic value) {
    anomaliesArray.insert(index, value);
  }

  List<dynamic> _kpisArray = [];
  List<dynamic> get kpisArray => _kpisArray;
  set kpisArray(List<dynamic> value) {
    _kpisArray = value;
  }

  void addToKpisArray(dynamic value) {
    kpisArray.add(value);
  }

  void removeFromKpisArray(dynamic value) {
    kpisArray.remove(value);
  }

  void removeAtIndexFromKpisArray(int index) {
    kpisArray.removeAt(index);
  }

  void updateKpisArrayAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    kpisArray[index] = updateFn(_kpisArray[index]);
  }

  void insertAtIndexInKpisArray(int index, dynamic value) {
    kpisArray.insert(index, value);
  }

  List<dynamic> _memorandumsArray = [];
  List<dynamic> get memorandumsArray => _memorandumsArray;
  set memorandumsArray(List<dynamic> value) {
    _memorandumsArray = value;
  }

  void addToMemorandumsArray(dynamic value) {
    memorandumsArray.add(value);
  }

  void removeFromMemorandumsArray(dynamic value) {
    memorandumsArray.remove(value);
  }

  void removeAtIndexFromMemorandumsArray(int index) {
    memorandumsArray.removeAt(index);
  }

  void updateMemorandumsArrayAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    memorandumsArray[index] = updateFn(_memorandumsArray[index]);
  }

  void insertAtIndexInMemorandumsArray(int index, dynamic value) {
    memorandumsArray.insert(index, value);
  }

  List<dynamic> _notificationsArray = [];
  List<dynamic> get notificationsArray => _notificationsArray;
  set notificationsArray(List<dynamic> value) {
    _notificationsArray = value;
  }

  void addToNotificationsArray(dynamic value) {
    notificationsArray.add(value);
  }

  void removeFromNotificationsArray(dynamic value) {
    notificationsArray.remove(value);
  }

  void removeAtIndexFromNotificationsArray(int index) {
    notificationsArray.removeAt(index);
  }

  void updateNotificationsArrayAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    notificationsArray[index] = updateFn(_notificationsArray[index]);
  }

  void insertAtIndexInNotificationsArray(int index, dynamic value) {
    notificationsArray.insert(index, value);
  }

  List<dynamic> _reqAuthorizationsArray = [];
  List<dynamic> get reqAuthorizationsArray => _reqAuthorizationsArray;
  set reqAuthorizationsArray(List<dynamic> value) {
    _reqAuthorizationsArray = value;
  }

  void addToReqAuthorizationsArray(dynamic value) {
    reqAuthorizationsArray.add(value);
  }

  void removeFromReqAuthorizationsArray(dynamic value) {
    reqAuthorizationsArray.remove(value);
  }

  void removeAtIndexFromReqAuthorizationsArray(int index) {
    reqAuthorizationsArray.removeAt(index);
  }

  void updateReqAuthorizationsArrayAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    reqAuthorizationsArray[index] = updateFn(_reqAuthorizationsArray[index]);
  }

  void insertAtIndexInReqAuthorizationsArray(int index, dynamic value) {
    reqAuthorizationsArray.insert(index, value);
  }

  List<dynamic> _recAuthorizationsArray = [];
  List<dynamic> get recAuthorizationsArray => _recAuthorizationsArray;
  set recAuthorizationsArray(List<dynamic> value) {
    _recAuthorizationsArray = value;
  }

  void addToRecAuthorizationsArray(dynamic value) {
    recAuthorizationsArray.add(value);
  }

  void removeFromRecAuthorizationsArray(dynamic value) {
    recAuthorizationsArray.remove(value);
  }

  void removeAtIndexFromRecAuthorizationsArray(int index) {
    recAuthorizationsArray.removeAt(index);
  }

  void updateRecAuthorizationsArrayAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    recAuthorizationsArray[index] = updateFn(_recAuthorizationsArray[index]);
  }

  void insertAtIndexInRecAuthorizationsArray(int index, dynamic value) {
    recAuthorizationsArray.insert(index, value);
  }

  List<dynamic> _allAuthorizations = [];
  List<dynamic> get allAuthorizations => _allAuthorizations;
  set allAuthorizations(List<dynamic> value) {
    _allAuthorizations = value;
  }

  void addToAllAuthorizations(dynamic value) {
    allAuthorizations.add(value);
  }

  void removeFromAllAuthorizations(dynamic value) {
    allAuthorizations.remove(value);
  }

  void removeAtIndexFromAllAuthorizations(int index) {
    allAuthorizations.removeAt(index);
  }

  void updateAllAuthorizationsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    allAuthorizations[index] = updateFn(_allAuthorizations[index]);
  }

  void insertAtIndexInAllAuthorizations(int index, dynamic value) {
    allAuthorizations.insert(index, value);
  }

  List<dynamic> _rulesDocumentsArray = [];
  List<dynamic> get rulesDocumentsArray => _rulesDocumentsArray;
  set rulesDocumentsArray(List<dynamic> value) {
    _rulesDocumentsArray = value;
  }

  void addToRulesDocumentsArray(dynamic value) {
    rulesDocumentsArray.add(value);
  }

  void removeFromRulesDocumentsArray(dynamic value) {
    rulesDocumentsArray.remove(value);
  }

  void removeAtIndexFromRulesDocumentsArray(int index) {
    rulesDocumentsArray.removeAt(index);
  }

  void updateRulesDocumentsArrayAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    rulesDocumentsArray[index] = updateFn(_rulesDocumentsArray[index]);
  }

  void insertAtIndexInRulesDocumentsArray(int index, dynamic value) {
    rulesDocumentsArray.insert(index, value);
  }

  int _tempIntValue = 0;
  int get tempIntValue => _tempIntValue;
  set tempIntValue(int value) {
    _tempIntValue = value;
  }

  String _fcmToken = '';
  String get fcmToken => _fcmToken;
  set fcmToken(String value) {
    _fcmToken = value;
    prefs.setString('ff_fcmToken', value);
  }

  String _apnsToken = '';
  String get apnsToken => _apnsToken;
  set apnsToken(String value) {
    _apnsToken = value;
    prefs.setString('ff_apnsToken', value);
  }

  List<dynamic> _usersArray = [];
  List<dynamic> get usersArray => _usersArray;
  set usersArray(List<dynamic> value) {
    _usersArray = value;
  }

  void addToUsersArray(dynamic value) {
    usersArray.add(value);
  }

  void removeFromUsersArray(dynamic value) {
    usersArray.remove(value);
  }

  void removeAtIndexFromUsersArray(int index) {
    usersArray.removeAt(index);
  }

  void updateUsersArrayAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    usersArray[index] = updateFn(_usersArray[index]);
  }

  void insertAtIndexInUsersArray(int index, dynamic value) {
    usersArray.insert(index, value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
