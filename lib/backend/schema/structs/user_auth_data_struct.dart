// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class UserAuthDataStruct extends FFFirebaseStruct {
  UserAuthDataStruct({
    String? email,
    String? password,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _email = email,
        _password = password,
        super(firestoreUtilData);

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  set password(String? val) => _password = val;

  bool hasPassword() => _password != null;

  static UserAuthDataStruct fromMap(Map<String, dynamic> data) =>
      UserAuthDataStruct(
        email: data['email'] as String?,
        password: data['password'] as String?,
      );

  static UserAuthDataStruct? maybeFromMap(dynamic data) => data is Map
      ? UserAuthDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'email': _email,
        'password': _password,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'password': serializeParam(
          _password,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserAuthDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserAuthDataStruct(
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        password: deserializeParam(
          data['password'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserAuthDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserAuthDataStruct &&
        email == other.email &&
        password == other.password;
  }

  @override
  int get hashCode => const ListEquality().hash([email, password]);
}

UserAuthDataStruct createUserAuthDataStruct({
  String? email,
  String? password,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserAuthDataStruct(
      email: email,
      password: password,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserAuthDataStruct? updateUserAuthDataStruct(
  UserAuthDataStruct? userAuthData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userAuthData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserAuthDataStructData(
  Map<String, dynamic> firestoreData,
  UserAuthDataStruct? userAuthData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userAuthData == null) {
    return;
  }
  if (userAuthData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userAuthData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userAuthDataData =
      getUserAuthDataFirestoreData(userAuthData, forFieldValue);
  final nestedData =
      userAuthDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userAuthData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserAuthDataFirestoreData(
  UserAuthDataStruct? userAuthData, [
  bool forFieldValue = false,
]) {
  if (userAuthData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userAuthData.toMap());

  // Add any Firestore field values
  userAuthData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserAuthDataListFirestoreData(
  List<UserAuthDataStruct>? userAuthDatas,
) =>
    userAuthDatas?.map((e) => getUserAuthDataFirestoreData(e, true)).toList() ??
    [];
