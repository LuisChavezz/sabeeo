import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'memorandum_list_widget.dart' show MemorandumListWidget;
import 'package:flutter/material.dart';

class MemorandumListModel extends FlutterFlowModel<MemorandumListWidget> {
  ///  Local state fields for this component.

  int moreMemorandumsPerPage = 10;

  String? viewedCS;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Get Memorandums)] action in Column widget.
  ApiCallResponse? refreshMemorandumsResp;
  // Stores action output result for [Backend Call - API (Get Memorandums)] action in Button widget.
  ApiCallResponse? moreMemorandumResp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
