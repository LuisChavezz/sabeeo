import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'rule_details_widget.dart' show RuleDetailsWidget;
import 'package:flutter/material.dart';

class RuleDetailsModel extends FlutterFlowModel<RuleDetailsWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  bool wasUpdated = false;

  String? authorizationStatusValue;

  String? authorizationStatusLabel;

  String? userNip;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Confirm Document)] action in Button widget.
  ApiCallResponse? ruleDocConfirmResp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
