import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'requested_authorizations_list_widget.dart'
    show RequestedAuthorizationsListWidget;
import 'package:flutter/material.dart';

class RequestedAuthorizationsListModel
    extends FlutterFlowModel<RequestedAuthorizationsListWidget> {
  ///  Local state fields for this component.

  int moreAuthorizationsPerPage = 10;

  String? searchValueCS;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Get Requested Auths)] action in Column widget.
  ApiCallResponse? refreshReqAuthsResp;
  // Stores action output result for [Backend Call - API (Refresh Token)] action in Column widget.
  ApiCallResponse? refreshTokenResp1;
  // Stores action output result for [Backend Call - API (Get Requested Auths)] action in Button widget.
  ApiCallResponse? moreAuthorizationsResp;
  // Stores action output result for [Backend Call - API (Refresh Token)] action in Button widget.
  ApiCallResponse? refreshTokenResp2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
