import '/flutter_flow/flutter_flow_util.dart';
import 'confirm_action_widget.dart' show ConfirmActionWidget;
import 'package:flutter/material.dart';

class ConfirmActionModel extends FlutterFlowModel<ConfirmActionWidget> {
  ///  Local state fields for this component.

  bool showFieldValidationMessage = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for textField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textFieldTextController;
  String? Function(BuildContext, String?)? textFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textFieldTextController?.dispose();
  }
}
