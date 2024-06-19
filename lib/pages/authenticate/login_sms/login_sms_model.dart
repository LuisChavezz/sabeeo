import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'login_sms_widget.dart' show LoginSmsWidget;
import 'package:flutter/material.dart';

class LoginSmsModel extends FlutterFlowModel<LoginSmsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for phoneField widget.
  FocusNode? phoneFieldFocusNode;
  TextEditingController? phoneFieldTextController;
  String? Function(BuildContext, String?)? phoneFieldTextControllerValidator;
  String? _phoneFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ingrese un número de teléfono';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (Login OTP)] action in Button widget.
  ApiCallResponse? loginOtpResp;

  @override
  void initState(BuildContext context) {
    phoneFieldTextControllerValidator = _phoneFieldTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    phoneFieldFocusNode?.dispose();
    phoneFieldTextController?.dispose();
  }
}
