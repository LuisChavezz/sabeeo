// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class UserStruct extends FFFirebaseStruct {
  UserStruct({
    int? id,
    int? companyId,
    String? companyLogo,
    int? roleId,
    String? phone,
    String? email,
    String? firstname,
    String? lastname,
    int? positionId,
    String? prefixPhone,
    int? departmentId,
    bool? resetPassword,
    int? userMondayId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _companyId = companyId,
        _companyLogo = companyLogo,
        _roleId = roleId,
        _phone = phone,
        _email = email,
        _firstname = firstname,
        _lastname = lastname,
        _positionId = positionId,
        _prefixPhone = prefixPhone,
        _departmentId = departmentId,
        _resetPassword = resetPassword,
        _userMondayId = userMondayId,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "companyId" field.
  int? _companyId;
  int get companyId => _companyId ?? 0;
  set companyId(int? val) => _companyId = val;

  void incrementCompanyId(int amount) => companyId = companyId + amount;

  bool hasCompanyId() => _companyId != null;

  // "companyLogo" field.
  String? _companyLogo;
  String get companyLogo => _companyLogo ?? '';
  set companyLogo(String? val) => _companyLogo = val;

  bool hasCompanyLogo() => _companyLogo != null;

  // "roleId" field.
  int? _roleId;
  int get roleId => _roleId ?? 0;
  set roleId(int? val) => _roleId = val;

  void incrementRoleId(int amount) => roleId = roleId + amount;

  bool hasRoleId() => _roleId != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  set phone(String? val) => _phone = val;

  bool hasPhone() => _phone != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "firstname" field.
  String? _firstname;
  String get firstname => _firstname ?? '';
  set firstname(String? val) => _firstname = val;

  bool hasFirstname() => _firstname != null;

  // "lastname" field.
  String? _lastname;
  String get lastname => _lastname ?? '';
  set lastname(String? val) => _lastname = val;

  bool hasLastname() => _lastname != null;

  // "positionId" field.
  int? _positionId;
  int get positionId => _positionId ?? 0;
  set positionId(int? val) => _positionId = val;

  void incrementPositionId(int amount) => positionId = positionId + amount;

  bool hasPositionId() => _positionId != null;

  // "prefixPhone" field.
  String? _prefixPhone;
  String get prefixPhone => _prefixPhone ?? '';
  set prefixPhone(String? val) => _prefixPhone = val;

  bool hasPrefixPhone() => _prefixPhone != null;

  // "departmentId" field.
  int? _departmentId;
  int get departmentId => _departmentId ?? 0;
  set departmentId(int? val) => _departmentId = val;

  void incrementDepartmentId(int amount) =>
      departmentId = departmentId + amount;

  bool hasDepartmentId() => _departmentId != null;

  // "reset_password" field.
  bool? _resetPassword;
  bool get resetPassword => _resetPassword ?? false;
  set resetPassword(bool? val) => _resetPassword = val;

  bool hasResetPassword() => _resetPassword != null;

  // "userMondayId" field.
  int? _userMondayId;
  int get userMondayId => _userMondayId ?? 0;
  set userMondayId(int? val) => _userMondayId = val;

  void incrementUserMondayId(int amount) =>
      userMondayId = userMondayId + amount;

  bool hasUserMondayId() => _userMondayId != null;

  static UserStruct fromMap(Map<String, dynamic> data) => UserStruct(
        id: castToType<int>(data['id']),
        companyId: castToType<int>(data['companyId']),
        companyLogo: data['companyLogo'] as String?,
        roleId: castToType<int>(data['roleId']),
        phone: data['phone'] as String?,
        email: data['email'] as String?,
        firstname: data['firstname'] as String?,
        lastname: data['lastname'] as String?,
        positionId: castToType<int>(data['positionId']),
        prefixPhone: data['prefixPhone'] as String?,
        departmentId: castToType<int>(data['departmentId']),
        resetPassword: data['reset_password'] as bool?,
        userMondayId: castToType<int>(data['userMondayId']),
      );

  static UserStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'companyId': _companyId,
        'companyLogo': _companyLogo,
        'roleId': _roleId,
        'phone': _phone,
        'email': _email,
        'firstname': _firstname,
        'lastname': _lastname,
        'positionId': _positionId,
        'prefixPhone': _prefixPhone,
        'departmentId': _departmentId,
        'reset_password': _resetPassword,
        'userMondayId': _userMondayId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'companyId': serializeParam(
          _companyId,
          ParamType.int,
        ),
        'companyLogo': serializeParam(
          _companyLogo,
          ParamType.String,
        ),
        'roleId': serializeParam(
          _roleId,
          ParamType.int,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'firstname': serializeParam(
          _firstname,
          ParamType.String,
        ),
        'lastname': serializeParam(
          _lastname,
          ParamType.String,
        ),
        'positionId': serializeParam(
          _positionId,
          ParamType.int,
        ),
        'prefixPhone': serializeParam(
          _prefixPhone,
          ParamType.String,
        ),
        'departmentId': serializeParam(
          _departmentId,
          ParamType.int,
        ),
        'reset_password': serializeParam(
          _resetPassword,
          ParamType.bool,
        ),
        'userMondayId': serializeParam(
          _userMondayId,
          ParamType.int,
        ),
      }.withoutNulls;

  static UserStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        companyId: deserializeParam(
          data['companyId'],
          ParamType.int,
          false,
        ),
        companyLogo: deserializeParam(
          data['companyLogo'],
          ParamType.String,
          false,
        ),
        roleId: deserializeParam(
          data['roleId'],
          ParamType.int,
          false,
        ),
        phone: deserializeParam(
          data['phone'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        firstname: deserializeParam(
          data['firstname'],
          ParamType.String,
          false,
        ),
        lastname: deserializeParam(
          data['lastname'],
          ParamType.String,
          false,
        ),
        positionId: deserializeParam(
          data['positionId'],
          ParamType.int,
          false,
        ),
        prefixPhone: deserializeParam(
          data['prefixPhone'],
          ParamType.String,
          false,
        ),
        departmentId: deserializeParam(
          data['departmentId'],
          ParamType.int,
          false,
        ),
        resetPassword: deserializeParam(
          data['reset_password'],
          ParamType.bool,
          false,
        ),
        userMondayId: deserializeParam(
          data['userMondayId'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'UserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserStruct &&
        id == other.id &&
        companyId == other.companyId &&
        companyLogo == other.companyLogo &&
        roleId == other.roleId &&
        phone == other.phone &&
        email == other.email &&
        firstname == other.firstname &&
        lastname == other.lastname &&
        positionId == other.positionId &&
        prefixPhone == other.prefixPhone &&
        departmentId == other.departmentId &&
        resetPassword == other.resetPassword &&
        userMondayId == other.userMondayId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        companyId,
        companyLogo,
        roleId,
        phone,
        email,
        firstname,
        lastname,
        positionId,
        prefixPhone,
        departmentId,
        resetPassword,
        userMondayId
      ]);
}

UserStruct createUserStruct({
  int? id,
  int? companyId,
  String? companyLogo,
  int? roleId,
  String? phone,
  String? email,
  String? firstname,
  String? lastname,
  int? positionId,
  String? prefixPhone,
  int? departmentId,
  bool? resetPassword,
  int? userMondayId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserStruct(
      id: id,
      companyId: companyId,
      companyLogo: companyLogo,
      roleId: roleId,
      phone: phone,
      email: email,
      firstname: firstname,
      lastname: lastname,
      positionId: positionId,
      prefixPhone: prefixPhone,
      departmentId: departmentId,
      resetPassword: resetPassword,
      userMondayId: userMondayId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserStruct? updateUserStruct(
  UserStruct? user, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    user
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserStructData(
  Map<String, dynamic> firestoreData,
  UserStruct? user,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (user == null) {
    return;
  }
  if (user.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && user.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userData = getUserFirestoreData(user, forFieldValue);
  final nestedData = userData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = user.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserFirestoreData(
  UserStruct? user, [
  bool forFieldValue = false,
]) {
  if (user == null) {
    return {};
  }
  final firestoreData = mapToFirestore(user.toMap());

  // Add any Firestore field values
  user.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserListFirestoreData(
  List<UserStruct>? users,
) =>
    users?.map((e) => getUserFirestoreData(e, true)).toList() ?? [];
