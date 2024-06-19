import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'kpis_list_widget.dart' show KpisListWidget;
import 'package:flutter/material.dart';

class KpisListModel extends FlutterFlowModel<KpisListWidget> {
  ///  Local state fields for this component.

  int moreKpisPerPage = 10;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Get Kpis)] action in Column widget.
  ApiCallResponse? refreshKpisResp;
  // Stores action output result for [Backend Call - API (Get Kpis)] action in Button widget.
  ApiCallResponse? moreKpisResp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
