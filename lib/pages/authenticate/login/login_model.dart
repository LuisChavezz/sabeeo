import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'login_widget.dart' show LoginWidget;
import 'package:flutter/material.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for emailField widget.
  FocusNode? emailFieldFocusNode;
  TextEditingController? emailFieldTextController;
  String? Function(BuildContext, String?)? emailFieldTextControllerValidator;
  String? _emailFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ingrese un correo electrónico';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Formato inválido';
    }
    return null;
  }

  // State field(s) for passwordField widget.
  FocusNode? passwordFieldFocusNode;
  TextEditingController? passwordFieldTextController;
  late bool passwordFieldVisibility;
  String? Function(BuildContext, String?)? passwordFieldTextControllerValidator;
  String? _passwordFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ingrese una contraseña';
    }

    if (val.length < 8) {
      return '*Min. 8 caracteres';
    }

    return null;
  }

  // State field(s) for RememberMeCheck widget.
  bool? rememberMeCheckValue;
  // Stores action output result for [Backend Call - API (Login)] action in Button widget.
  ApiCallResponse? loginResp;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UserFcmTokensRecord? userFcmTokenDoc;

  @override
  void initState(BuildContext context) {
    emailFieldTextControllerValidator = _emailFieldTextControllerValidator;
    passwordFieldVisibility = false;
    passwordFieldTextControllerValidator =
        _passwordFieldTextControllerValidator;
  }

  @override
  void dispose() {
    emailFieldFocusNode?.dispose();
    emailFieldTextController?.dispose();

    passwordFieldFocusNode?.dispose();
    passwordFieldTextController?.dispose();
  }
}
