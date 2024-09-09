import '/backend/api_requests/api_calls.dart';
import '/components/authorizations/all_authorizations_list/all_authorizations_list_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'authorizations_history_widget.dart' show AuthorizationsHistoryWidget;
import 'package:flutter/material.dart';

class AuthorizationsHistoryModel
    extends FlutterFlowModel<AuthorizationsHistoryWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  int? authorizationsPerPage = 10;

  int? authorizationsTotal;

  String? searchValue;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Get History Auths)] action in Authorizations_history widget.
  ApiCallResponse? allAuthsResp;
  // State field(s) for searchField widget.
  FocusNode? searchFieldFocusNode;
  TextEditingController? searchFieldTextController;
  String? Function(BuildContext, String?)? searchFieldTextControllerValidator;
  // Stores action output result for [Backend Call - API (Get History Auths)] action in Container widget.
  ApiCallResponse? searchAuthsResp;
  // Stores action output result for [Backend Call - API (Get History Auths)] action in Container widget.
  ApiCallResponse? clearSearchAuthsResp;
  // Model for AllAuthorizationsList component.
  late AllAuthorizationsListModel allAuthorizationsListModel;

  @override
  void initState(BuildContext context) {
    allAuthorizationsListModel =
        createModel(context, () => AllAuthorizationsListModel());
  }

  @override
  void dispose() {
    searchFieldFocusNode?.dispose();
    searchFieldTextController?.dispose();

    allAuthorizationsListModel.dispose();
  }
}
