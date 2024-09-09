import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'users_directory_list_widget.dart' show UsersDirectoryListWidget;
import 'package:flutter/material.dart';

class UsersDirectoryListModel
    extends FlutterFlowModel<UsersDirectoryListWidget> {
  ///  Local state fields for this component.

  int moreUsersPerPage = 10;

  String? searchValueCS;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Directory)] action in Column widget.
  ApiCallResponse? refreshUsersResp;
  // Stores action output result for [Backend Call - API (Directory)] action in Button widget.
  ApiCallResponse? moreUsersResp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
