import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'notifications_list_widget.dart' show NotificationsListWidget;
import 'package:flutter/material.dart';

class NotificationsListModel extends FlutterFlowModel<NotificationsListWidget> {
  ///  Local state fields for this component.

  int? moreNotificationsPerPage = 10;

  String? readCS;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Get Notifications)] action in Column widget.
  ApiCallResponse? refreshNotificationsResp;
  // Stores action output result for [Backend Call - API (Refresh Token)] action in Column widget.
  ApiCallResponse? refreshTokenResp1;
  // Stores action output result for [Backend Call - API (Read Notificaction)] action in Row widget.
  ApiCallResponse? readNotiResp;
  // Stores action output result for [Backend Call - API (Get Notifications)] action in Row widget.
  ApiCallResponse? readNotificationsResp;
  // Stores action output result for [Backend Call - API (Get Notifications)] action in Button widget.
  ApiCallResponse? moreNotificationsResp;
  // Stores action output result for [Backend Call - API (Refresh Token)] action in Button widget.
  ApiCallResponse? refreshTokenResp2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
