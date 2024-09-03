import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserFcmTokensRecord extends FirestoreRecord {
  UserFcmTokensRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "userEmail" field.
  String? _userEmail;
  String get userEmail => _userEmail ?? '';
  bool hasUserEmail() => _userEmail != null;

  // "fcmTokens" field.
  List<String>? _fcmTokens;
  List<String> get fcmTokens => _fcmTokens ?? const [];
  bool hasFcmTokens() => _fcmTokens != null;

  void _initializeFields() {
    _userId = snapshotData['userId'] as String?;
    _userEmail = snapshotData['userEmail'] as String?;
    _fcmTokens = getDataList(snapshotData['fcmTokens']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('userFcmTokens');

  static Stream<UserFcmTokensRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserFcmTokensRecord.fromSnapshot(s));

  static Future<UserFcmTokensRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserFcmTokensRecord.fromSnapshot(s));

  static UserFcmTokensRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserFcmTokensRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserFcmTokensRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserFcmTokensRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserFcmTokensRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserFcmTokensRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserFcmTokensRecordData({
  String? userId,
  String? userEmail,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userId': userId,
      'userEmail': userEmail,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserFcmTokensRecordDocumentEquality
    implements Equality<UserFcmTokensRecord> {
  const UserFcmTokensRecordDocumentEquality();

  @override
  bool equals(UserFcmTokensRecord? e1, UserFcmTokensRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userId == e2?.userId &&
        e1?.userEmail == e2?.userEmail &&
        listEquality.equals(e1?.fcmTokens, e2?.fcmTokens);
  }

  @override
  int hash(UserFcmTokensRecord? e) =>
      const ListEquality().hash([e?.userId, e?.userEmail, e?.fcmTokens]);

  @override
  bool isValidKey(Object? o) => o is UserFcmTokensRecord;
}
