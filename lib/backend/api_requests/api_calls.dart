import 'dart:convert';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Authenticate Group Code

class AuthenticateGroup {
  static String getBaseUrl() => 'https://apiv2.menita.cloud/api/authenticate';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'ignore-inactivity-check': 'true',
  };
  static LoginCall loginCall = LoginCall();
  static LoginOTPCall loginOTPCall = LoginOTPCall();
  static ValidateLoginOTPCall validateLoginOTPCall = ValidateLoginOTPCall();
  static RefreshTokenCall refreshTokenCall = RefreshTokenCall();
}

class LoginCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) async {
    final baseUrl = AuthenticateGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "email": "$email",
  "password": "$password"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Login',
      apiUrl: '$baseUrl/login_app',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  UserStruct? user(dynamic response) => UserStruct.maybeFromMap(getJsonField(
        response,
        r'''$.data.user''',
      ));
  String? token(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.token''',
      ));
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class LoginOTPCall {
  Future<ApiCallResponse> call({
    String? phone = '',
  }) async {
    final baseUrl = AuthenticateGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "phone": "$phone"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Login OTP',
      apiUrl: '$baseUrl/login_otp',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.success''',
      ));
  String? dataMessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.message''',
      ));
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class ValidateLoginOTPCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = AuthenticateGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "token": "$token"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Validate Login OTP',
      apiUrl: '$baseUrl/validate_login_otp',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  UserStruct? user(dynamic response) => UserStruct.maybeFromMap(getJsonField(
        response,
        r'''$.data.user''',
      ));
  String? token(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.token''',
      ));
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.message''',
      ));
}

class RefreshTokenCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = AuthenticateGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "token": "$token"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Refresh Token',
      apiUrl: '$baseUrl/refresh_token',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? token(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.token''',
      ));
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
}

/// End Authenticate Group Code

/// Start Users Group Code

class UsersGroup {
  static String getBaseUrl() => 'https://apiv2.menita.cloud/api/users';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'ignore-inactivity-check': 'true',
  };
  static RecoverPassCall recoverPassCall = RecoverPassCall();
  static ProfileCall profileCall = ProfileCall();
}

class RecoverPassCall {
  Future<ApiCallResponse> call({
    String? email = '',
  }) async {
    final baseUrl = UsersGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "email": "$email"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Recover Pass',
      apiUrl: '$baseUrl/recoverPass',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class ProfileCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = UsersGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Profile',
      apiUrl: '$baseUrl/profile/app_mitosis',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? picture(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.profile_picture''',
      ));
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  String? firstname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.firstname''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.email''',
      ));
  String? lastname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.lastname''',
      ));
  String? phone(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.phone''',
      ));
}

/// End Users Group Code

/// Start Anomalies Group Code

class AnomaliesGroup {
  static String getBaseUrl() => 'https://apiv2.menita.cloud/api/anomalies';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'ignore-inactivity-check': 'true',
  };
  static GetAnomaliesCall getAnomaliesCall = GetAnomaliesCall();
}

class GetAnomaliesCall {
  Future<ApiCallResponse> call({
    int? page = 1,
    int? perPage = 10,
    String? token = '',
  }) async {
    final baseUrl = AnomaliesGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get Anomalies',
      apiUrl: '$baseUrl/user/app_mitosis',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {
        'page': page,
        'perPage': perPage,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? rows(dynamic response) => getJsonField(
        response,
        r'''$.data.rows''',
        true,
      ) as List?;
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  int? totalRows(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.total''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

/// End Anomalies Group Code

/// Start KPI Group Code

class KpiGroup {
  static String getBaseUrl() => 'https://apiv2.menita.cloud/api/kpi';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'ignore-inactivity-check': 'true',
  };
  static GetKpisCall getKpisCall = GetKpisCall();
}

class GetKpisCall {
  Future<ApiCallResponse> call({
    String? token = '',
    String? page = '1',
    String? perPage = '10',
  }) async {
    final baseUrl = KpiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get Kpis',
      apiUrl: '$baseUrl/app_mitosis',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {
        'page': page,
        'perPage': perPage,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? rows(dynamic response) => getJsonField(
        response,
        r'''$.data.rows''',
        true,
      ) as List?;
  int? totalRows(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.total''',
      ));
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

/// End KPI Group Code

/// Start Memorandum Group Code

class MemorandumGroup {
  static String getBaseUrl() => 'https://apiv2.menita.cloud/api/memorandum';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'ignore-inactivity-check': 'true',
  };
  static GetMemorandumsCall getMemorandumsCall = GetMemorandumsCall();
  static ConfirmMemorandumCall confirmMemorandumCall = ConfirmMemorandumCall();
}

class GetMemorandumsCall {
  Future<ApiCallResponse> call({
    int? page = 1,
    int? perPage = 10,
    String? token = '',
  }) async {
    final baseUrl = MemorandumGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get Memorandums',
      apiUrl: '$baseUrl/app_mitosis',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {
        'page': page,
        'perPage': perPage,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? rows(dynamic response) => getJsonField(
        response,
        r'''$.data.rows''',
        true,
      ) as List?;
  int? totalRows(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.total''',
      ));
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class ConfirmMemorandumCall {
  Future<ApiCallResponse> call({
    String? id = '',
    String? token = '',
  }) async {
    final baseUrl = MemorandumGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Confirm Memorandum',
      apiUrl: '$baseUrl/confirm/$id',
      callType: ApiCallType.PATCH,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Memorandum Group Code

/// Start Notifications Group Code

class NotificationsGroup {
  static String getBaseUrl() =>
      'https://apiv2.menita.cloud/api/broadcast-messages';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'ignore-inactivity-check': 'true',
  };
  static GetNotificationsCall getNotificationsCall = GetNotificationsCall();
  static ReadNotificactionCall readNotificactionCall = ReadNotificactionCall();
}

class GetNotificationsCall {
  Future<ApiCallResponse> call({
    String? token = '',
    int? page = 1,
    int? perPage = 10,
    String? read = '',
  }) async {
    final baseUrl = NotificationsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get Notifications',
      apiUrl: '$baseUrl/app_mitosis',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {
        'page': page,
        'perPage': perPage,
        'read': read,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? rows(dynamic response) => getJsonField(
        response,
        r'''$.data.rows''',
        true,
      ) as List?;
  int? totalRows(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.total''',
      ));
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class ReadNotificactionCall {
  Future<ApiCallResponse> call({
    String? id = '',
    String? token = '',
  }) async {
    final baseUrl = NotificationsGroup.getBaseUrl();

    const ffApiRequestBody = '''
{
  "read": true
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Read Notificaction',
      apiUrl: '$baseUrl/$id',
      callType: ApiCallType.PATCH,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Notifications Group Code

/// Start Authorizations Group Code

class AuthorizationsGroup {
  static String getBaseUrl() => 'https://apiv2.menita.cloud/api/authorization';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'ignore-inactivity-check': 'true',
  };
  static GetRequestedAuthsCall getRequestedAuthsCall = GetRequestedAuthsCall();
  static GetReceivedAuthsCall getReceivedAuthsCall = GetReceivedAuthsCall();
  static AuthorizationDetailsCall authorizationDetailsCall =
      AuthorizationDetailsCall();
  static ResponseAuthorizationCall responseAuthorizationCall =
      ResponseAuthorizationCall();
  static GetHistoryAuthsCall getHistoryAuthsCall = GetHistoryAuthsCall();
}

class GetRequestedAuthsCall {
  Future<ApiCallResponse> call({
    String? token = '',
    int? page = 1,
    int? perPage = 10,
    String? searchKeys = 'subject,id',
    String? searchValue = '',
    String? emitterId = '',
    String? status = 'pendant',
  }) async {
    final baseUrl = AuthorizationsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get Requested Auths',
      apiUrl: '$baseUrl/solicitadas/app_mitosis',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {
        'page': page,
        'perPage': perPage,
        'searchKeys': searchKeys,
        'searchValue': searchValue,
        'status': status,
        'emitterId': emitterId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? rows(dynamic response) => getJsonField(
        response,
        r'''$.data.rows''',
        true,
      ) as List?;
  int? totalRows(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.total''',
      ));
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class GetReceivedAuthsCall {
  Future<ApiCallResponse> call({
    String? token = '',
    int? page = 1,
    int? perPage = 10,
    String? searchKeys = 'subject,id',
    String? searchValue = '',
    String? status = 'pendant',
  }) async {
    final baseUrl = AuthorizationsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get Received Auths',
      apiUrl: '$baseUrl/recibidas/app_mitosis',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {
        'page': page,
        'perPage': perPage,
        'searchKeys': searchKeys,
        'searchValue': searchValue,
        'status': status,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? rows(dynamic response) => getJsonField(
        response,
        r'''$.data.rows''',
        true,
      ) as List?;
  int? totalRows(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.total''',
      ));
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class AuthorizationDetailsCall {
  Future<ApiCallResponse> call({
    String? id = '',
    String? token = '',
  }) async {
    final baseUrl = AuthorizationsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Authorization Details',
      apiUrl: '$baseUrl/app_movil_detail/$id',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  String? body(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.body''',
      ));
  String? subject(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.subject''',
      ));
  String? statusValue(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.status''',
      ));
  String? date(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.createdAt''',
      ));
  String? statusLabel(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.statusTranslations''',
      ));
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  String? emitterProfilePic(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.emitter_profile_picture''',
      ));
  String? authorizerProfilePic(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.originalAuthorizer_profile_picture''',
      ));
  List? pdfResource(dynamic response) => getJsonField(
        response,
        r'''$.data.pdfResource''',
        true,
      ) as List?;
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  bool? isAuthorizer(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.isAuthorizer''',
      ));
}

class ResponseAuthorizationCall {
  Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    String? status = '',
  }) async {
    final baseUrl = AuthorizationsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "status": "$status"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Response Authorization',
      apiUrl: '$baseUrl/$id',
      callType: ApiCallType.PATCH,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  String? statusValue(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.status''',
      ));
  String? statusLabel(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.statusTranslation''',
      ));
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class GetHistoryAuthsCall {
  Future<ApiCallResponse> call({
    String? token = '',
    int? page = 1,
    int? perPage = 10,
    String? searchKeys = 'subject,id',
    String? searchValue = '',
  }) async {
    final baseUrl = AuthorizationsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get History Auths',
      apiUrl: '$baseUrl/historial/app_mitosis',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {
        'page': page,
        'perPage': perPage,
        'searchKeys': searchKeys,
        'searchValue': searchValue,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? rows(dynamic response) => getJsonField(
        response,
        r'''$.data.rows''',
        true,
      ) as List?;
  int? totalRows(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.total''',
      ));
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

/// End Authorizations Group Code

/// Start Original API Endpoints Group Code

class OriginalAPIEndpointsGroup {
  static String getBaseUrl() => 'https://apiv2.menita.cloud/api';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'ignore-inactivity-check': 'true',
  };
  static GetDocumentsCall getDocumentsCall = GetDocumentsCall();
  static ConfirmDocumentCall confirmDocumentCall = ConfirmDocumentCall();
}

class GetDocumentsCall {
  Future<ApiCallResponse> call({
    String? token = '',
    int? page = 1,
    int? perPage = 10,
    String? searchValue = '',
  }) async {
    final baseUrl = OriginalAPIEndpointsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get Documents',
      apiUrl: '$baseUrl/confirmed-documents/user',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {
        'page': page,
        'perPage': perPage,
        'searchKeys': "document_name",
        'searchValue': searchValue,
        'sortBy': "id",
        'descending': 1,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
}

class ConfirmDocumentCall {
  Future<ApiCallResponse> call({
    String? token = '',
    int? documentId,
    int? versionId,
    bool? status = true,
    String? nip = '',
  }) async {
    final baseUrl = OriginalAPIEndpointsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "documentId": $documentId,
  "versionId": $versionId,
  "status": $status,
  "nip": $nip
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Confirm Document',
      apiUrl: '$baseUrl/confirmed-documents/confirm',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'ignore-inactivity-check': 'true',
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

/// End Original API Endpoints Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
