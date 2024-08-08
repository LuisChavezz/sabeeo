import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'anomalies_list_widget.dart' show AnomaliesListWidget;
import 'package:flutter/material.dart';

class AnomaliesListModel extends FlutterFlowModel<AnomaliesListWidget> {
  ///  Local state fields for this component.

  int moreAnomaliesPerPage = 10;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Get Anomalies)] action in Column widget.
  ApiCallResponse? refreshAnomaliesResp;
  // Stores action output result for [Backend Call - API (Refresh Token)] action in Column widget.
  ApiCallResponse? refreshTokenResp1;
  // Stores action output result for [Backend Call - API (Get Anomalies)] action in Button widget.
  ApiCallResponse? moreAnomaliesResp;
  // Stores action output result for [Backend Call - API (Refresh Token)] action in Button widget.
  ApiCallResponse? refreshTokenResp2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
