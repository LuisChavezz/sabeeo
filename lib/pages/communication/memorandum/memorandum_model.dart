import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'memorandum_widget.dart' show MemorandumWidget;
import 'package:flutter/material.dart';

class MemorandumModel extends FlutterFlowModel<MemorandumWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Confirm Memorandum)] action in Memorandum widget.
  ApiCallResponse? confirmMemoResp;
  // Stores action output result for [Backend Call - API (Get Memorandums)] action in Memorandum widget.
  ApiCallResponse? memorandumsResp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
