import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'received_authorizations_list_widget.dart'
    show ReceivedAuthorizationsListWidget;
import 'package:flutter/material.dart';

class ReceivedAuthorizationsListModel
    extends FlutterFlowModel<ReceivedAuthorizationsListWidget> {
  ///  Local state fields for this component.

  int moreAuthorizationsPerPage = 10;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Get Received Auths)] action in Column widget.
  ApiCallResponse? refreshRecAuthsResp;
  // Stores action output result for [Backend Call - API (Refresh Token)] action in Column widget.
  ApiCallResponse? refreshTokenResp1;
  // Stores action output result for [Backend Call - API (Get Received Auths)] action in Button widget.
  ApiCallResponse? moreAuthorizationsResp;
  // Stores action output result for [Backend Call - API (Refresh Token)] action in Button widget.
  ApiCallResponse? refreshTokenResp2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
