// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserAuthDataStruct extends BaseStruct {
  UserAuthDataStruct({
    String? email,
    String? password,
  })  : _email = email,
        _password = password;

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
}) =>
    UserAuthDataStruct(
      email: email,
      password: password,
    );
