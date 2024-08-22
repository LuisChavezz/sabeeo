import '/backend/api_requests/api_calls.dart';
import '/components/communication/memorandum_list/memorandum_list_widget.dart';
import '/components/communication/notifications_list/notifications_list_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'communication_widget.dart' show CommunicationWidget;
import 'package:flutter/material.dart';

class CommunicationModel extends FlutterFlowModel<CommunicationWidget> {
  ///  Local state fields for this page.

  String switchValue = 'comun';

  bool isLoading = true;

  int? memorandumsPerPage = 10;

  int? memorandumsTotal;

  int? notificationsPerPage = 10;

  int? notificationsTotal;

  String notificationsSwitchValue = 'unread';

  String memorandumsSwitchValue = 'UNVIEWED';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Get Memorandums)] action in Communication widget.
  ApiCallResponse? memorandumsResp;
  // Stores action output result for [Backend Call - API (Get Notifications)] action in Communication widget.
  ApiCallResponse? notificationsResp;
  // Model for MemorandumList component.
  late MemorandumListModel memorandumListModel;
  // Model for NotificationsList component.
  late NotificationsListModel notificationsListModel;
  // Stores action output result for [Backend Call - API (Get Memorandums)] action in unreadedButton widget.
  ApiCallResponse? readedMemorandumsResp;
  // Stores action output result for [Backend Call - API (Get Notifications)] action in unreadedButton widget.
  ApiCallResponse? readedNotificationsResp;
  // Stores action output result for [Backend Call - API (Get Memorandums)] action in readedButton widget.
  ApiCallResponse? unreadedMemorandumsResp;
  // Stores action output result for [Backend Call - API (Get Notifications)] action in readedButton widget.
  ApiCallResponse? unreadedNotificationsResp;

  @override
  void initState(BuildContext context) {
    memorandumListModel = createModel(context, () => MemorandumListModel());
    notificationsListModel =
        createModel(context, () => NotificationsListModel());
  }

  @override
  void dispose() {
    memorandumListModel.dispose();
    notificationsListModel.dispose();
  }
}
