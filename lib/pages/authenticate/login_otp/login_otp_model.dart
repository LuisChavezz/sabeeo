import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'login_otp_widget.dart' show LoginOtpWidget;
import 'package:flutter/material.dart';

class LoginOtpModel extends FlutterFlowModel<LoginOtpWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  String? _pinCodeControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ingrese el código OTP';
    }
    if (val.length < 6) {
      return 'Requires 6 characters.';
    }
    return null;
  }

  // Stores action output result for [Backend Call - API (Validate Login OTP)] action in Button widget.
  ApiCallResponse? validateOtpResp;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
    pinCodeControllerValidator = _pinCodeControllerValidator;
  }

  @override
  void dispose() {
    pinCodeController?.dispose();
  }
}
