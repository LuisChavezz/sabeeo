import '/backend/api_requests/api_calls.dart';
import '/components/authorizations/received_authorizations_list/received_authorizations_list_widget.dart';
import '/components/authorizations/requested_authorizations_list/requested_authorizations_list_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'authorizations_widget.dart' show AuthorizationsWidget;
import 'package:flutter/material.dart';

class AuthorizationsModel extends FlutterFlowModel<AuthorizationsWidget> {
  ///  Local state fields for this page.

  String switchValue = 'solic';

  bool isLoading = true;

  int? reqAuthorizationsPerPage = 10;

  int? reqAuthorizationsTotal;

  int? recAuthorizationsPerPage = 10;

  int? recAuthorizationsTotal;

  String? searchReqValue;

  String? searchRecValue;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Get Requested Auths)] action in Authorizations widget.
  ApiCallResponse? reqAuthsResp;
  // Stores action output result for [Backend Call - API (Get Received Auths)] action in Authorizations widget.
  ApiCallResponse? recAuthsResp;
  // State field(s) for searchField widget.
  FocusNode? searchFieldFocusNode;
  TextEditingController? searchFieldTextController;
  String? Function(BuildContext, String?)? searchFieldTextControllerValidator;
  // Stores action output result for [Backend Call - API (Get Requested Auths)] action in Container widget.
  ApiCallResponse? reqSearchAuthsResp;
  // Stores action output result for [Backend Call - API (Get Received Auths)] action in Container widget.
  ApiCallResponse? recSearchAuthsResp;
  // Stores action output result for [Backend Call - API (Get Requested Auths)] action in Container widget.
  ApiCallResponse? reqClearSearchAuthsResp;
  // Stores action output result for [Backend Call - API (Get Received Auths)] action in Container widget.
  ApiCallResponse? recClearSearchAuthsResp;
  // Model for RequestedAuthorizationsList component.
  late RequestedAuthorizationsListModel requestedAuthorizationsListModel;
  // Model for ReceivedAuthorizationsList component.
  late ReceivedAuthorizationsListModel receivedAuthorizationsListModel;

  @override
  void initState(BuildContext context) {
    requestedAuthorizationsListModel =
        createModel(context, () => RequestedAuthorizationsListModel());
    receivedAuthorizationsListModel =
        createModel(context, () => ReceivedAuthorizationsListModel());
  }

  @override
  void dispose() {
    searchFieldFocusNode?.dispose();
    searchFieldTextController?.dispose();

    requestedAuthorizationsListModel.dispose();
    receivedAuthorizationsListModel.dispose();
  }
}
