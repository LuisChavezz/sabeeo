import '/backend/api_requests/api_calls.dart';
import '/components/users/users_directory_list/users_directory_list_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'user_directory_widget.dart' show UserDirectoryWidget;
import 'package:flutter/material.dart';

class UserDirectoryModel extends FlutterFlowModel<UserDirectoryWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  int? usersPerPage = 10;

  int? usersTotal;

  String? searchValue;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Directory)] action in User_directory widget.
  ApiCallResponse? usersResp;
  // State field(s) for searchField widget.
  FocusNode? searchFieldFocusNode;
  TextEditingController? searchFieldTextController;
  String? Function(BuildContext, String?)? searchFieldTextControllerValidator;
  // Stores action output result for [Backend Call - API (Directory)] action in Container widget.
  ApiCallResponse? searchUsersResp;
  // Stores action output result for [Backend Call - API (Directory)] action in Container widget.
  ApiCallResponse? clearSearchUsersResp;
  // Model for UsersDirectoryList component.
  late UsersDirectoryListModel usersDirectoryListModel;

  @override
  void initState(BuildContext context) {
    usersDirectoryListModel =
        createModel(context, () => UsersDirectoryListModel());
  }

  @override
  void dispose() {
    searchFieldFocusNode?.dispose();
    searchFieldTextController?.dispose();

    usersDirectoryListModel.dispose();
  }
}
