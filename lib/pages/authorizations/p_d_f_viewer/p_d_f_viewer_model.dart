import '/flutter_flow/flutter_flow_util.dart';
import 'p_d_f_viewer_widget.dart' show PDFViewerWidget;
import 'package:flutter/material.dart';

class PDFViewerModel extends FlutterFlowModel<PDFViewerWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
