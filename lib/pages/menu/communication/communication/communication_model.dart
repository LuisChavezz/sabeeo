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

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Get Memorandums)] action in Communication widget.
  ApiCallResponse? memorandumsResp;
  // Stores action output result for [Backend Call - API (Get Notifications)] action in Communication widget.
  ApiCallResponse? notificationsResp;
  // Model for MemorandumList component.
  late MemorandumListModel memorandumListModel;
  // Model for NotificationsList component.
  late NotificationsListModel notificationsListModel;

  @override
  void initState(BuildContext context) {
    memorandumListModel = createModel(context, () => MemorandumListModel());
    notificationsListModel =
        createModel(context, () => NotificationsListModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    memorandumListModel.dispose();
    notificationsListModel.dispose();
  }
}
