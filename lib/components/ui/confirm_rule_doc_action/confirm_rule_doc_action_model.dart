import '/flutter_flow/flutter_flow_util.dart';
import 'confirm_rule_doc_action_widget.dart' show ConfirmRuleDocActionWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ConfirmRuleDocActionModel
    extends FlutterFlowModel<ConfirmRuleDocActionWidget> {
  ///  Local state fields for this component.

  bool showButton = false;

  int? nipValue = 0;

  ///  State fields for stateful widgets in this component.

  // State field(s) for nipField widget.
  FocusNode? nipFieldFocusNode;
  TextEditingController? nipFieldTextController;
  final nipFieldMask = MaskTextInputFormatter(mask: '####');
  String? Function(BuildContext, String?)? nipFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nipFieldFocusNode?.dispose();
    nipFieldTextController?.dispose();
  }
}
