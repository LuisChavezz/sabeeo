import '/backend/api_requests/api_calls.dart';
import '/components/authorizations/authorization_pdf_list/authorization_pdf_list_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'authorization_details_widget.dart' show AuthorizationDetailsWidget;
import 'package:flutter/material.dart';

class AuthorizationDetailsModel
    extends FlutterFlowModel<AuthorizationDetailsWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  bool wasUpdated = false;

  String? authorizationStatusValue;

  String? authorizationStatusLabel;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Authorization Details)] action in Authorization_details widget.
  ApiCallResponse? authorizationResp;
  // Stores action output result for [Backend Call - API (Refresh Token)] action in Authorization_details widget.
  ApiCallResponse? refreshTokenResp1;
  // Model for AuthorizationPdfList component.
  late AuthorizationPdfListModel authorizationPdfListModel;
  // Stores action output result for [Backend Call - API (Response Authorization)] action in Button widget.
  ApiCallResponse? rejectedAuthoResp;
  // Stores action output result for [Backend Call - API (Refresh Token)] action in Button widget.
  ApiCallResponse? refreshTokenResp2;
  // Stores action output result for [Backend Call - API (Response Authorization)] action in Button widget.
  ApiCallResponse? approvedAuthResp;
  // Stores action output result for [Backend Call - API (Refresh Token)] action in Button widget.
  ApiCallResponse? refreshTokenResp3;

  @override
  void initState(BuildContext context) {
    authorizationPdfListModel =
        createModel(context, () => AuthorizationPdfListModel());
  }

  @override
  void dispose() {
    authorizationPdfListModel.dispose();
  }
}
