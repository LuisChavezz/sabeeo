import '/backend/api_requests/api_calls.dart';
import '/components/home/anomalies_list/anomalies_list_widget.dart';
import '/components/home/kpis_list/kpis_list_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  String switchValue = 'anom';

  int? anomaliesPerPage = 10;

  int? anomaliesTotal;

  bool isLoading = true;

  int? kpisPerPage = 10;

  int? kpisTotal;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Get Anomalies)] action in Home widget.
  ApiCallResponse? anomaliesResp;
  // Stores action output result for [Backend Call - API (Get Kpis)] action in Home widget.
  ApiCallResponse? kpisResp;
  // Model for AnomaliesList component.
  late AnomaliesListModel anomaliesListModel;
  // Model for KpisList component.
  late KpisListModel kpisListModel;

  @override
  void initState(BuildContext context) {
    anomaliesListModel = createModel(context, () => AnomaliesListModel());
    kpisListModel = createModel(context, () => KpisListModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    anomaliesListModel.dispose();
    kpisListModel.dispose();
  }
}
