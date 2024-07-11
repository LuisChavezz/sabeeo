import '/backend/api_requests/api_calls.dart';
import '/components/rules/rules_documents_list/rules_documents_list_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'rules_widget.dart' show RulesWidget;
import 'package:flutter/material.dart';

class RulesModel extends FlutterFlowModel<RulesWidget> {
  ///  Local state fields for this page.

  String switchValue = 'solic';

  bool isLoading = true;

  int? rulesPerPage = 10;

  int? rulesTotal;

  String? searchValue;

  List<dynamic> rulesDocuments = [];
  void addToRulesDocuments(dynamic item) => rulesDocuments.add(item);
  void removeFromRulesDocuments(dynamic item) => rulesDocuments.remove(item);
  void removeAtIndexFromRulesDocuments(int index) =>
      rulesDocuments.removeAt(index);
  void insertAtIndexInRulesDocuments(int index, dynamic item) =>
      rulesDocuments.insert(index, item);
  void updateRulesDocumentsAtIndex(int index, Function(dynamic) updateFn) =>
      rulesDocuments[index] = updateFn(rulesDocuments[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Get Documents)] action in Rules widget.
  ApiCallResponse? rulesResp;
  // State field(s) for searchField widget.
  FocusNode? searchFieldFocusNode;
  TextEditingController? searchFieldTextController;
  String? Function(BuildContext, String?)? searchFieldTextControllerValidator;
  // Model for RulesDocumentsList component.
  late RulesDocumentsListModel rulesDocumentsListModel;
  // Stores action output result for [Backend Call - API (Get Documents)] action in RulesDocumentsList widget.
  ApiCallResponse? reloadRulesResp;

  @override
  void initState(BuildContext context) {
    rulesDocumentsListModel =
        createModel(context, () => RulesDocumentsListModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    searchFieldFocusNode?.dispose();
    searchFieldTextController?.dispose();

    rulesDocumentsListModel.dispose();
  }
}
