import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/rules/rules_documents_list/rules_documents_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'rules_model.dart';
export 'rules_model.dart';

class RulesWidget extends StatefulWidget {
  const RulesWidget({super.key});

  @override
  State<RulesWidget> createState() => _RulesWidgetState();
}

class _RulesWidgetState extends State<RulesWidget> {
  late RulesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RulesModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Function() navigate = () {};
      _model.isLoading = true;
      setState(() {});
      _model.rulesResp = await OriginalAPIEndpointsGroup.getDocumentsCall.call(
        token: currentAuthenticationToken,
        perPage: _model.rulesPerPage,
      );

      if ((_model.rulesResp?.succeeded ?? true)) {
        FFAppState().rulesDocumentsArray =
            OriginalAPIEndpointsGroup.getDocumentsCall
                .data(
                  (_model.rulesResp?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
        setState(() {});
        _model.rulesTotal = FFAppState().rulesDocumentsArray.length;
        _model.rulesDocuments = functions
            .pagination(
                OriginalAPIEndpointsGroup.getDocumentsCall
                    .data(
                      (_model.rulesResp?.jsonBody ?? ''),
                    )!
                    .toList(),
                _model.rulesPerPage!)
            .toList()
            .cast<dynamic>();
        setState(() {});
      } else {
        if ((_model.rulesResp?.statusCode ?? 200) == 401) {
          GoRouter.of(context).prepareAuthEvent();
          await authManager.signOut();
          GoRouter.of(context).clearRedirectLocation();

          navigate = () => context.goNamedAuth('Login', context.mounted);

          navigate();
          return;
        }
      }

      _model.isLoading = false;
      setState(() {});

      navigate();
    });

    _model.searchFieldTextController ??= TextEditingController();
    _model.searchFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Tus Políticas y Procesos',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ].divide(const SizedBox(width: 16.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _model.searchFieldTextController,
                        focusNode: _model.searchFieldFocusNode,
                        autofillHints: const [AutofillHints.name],
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Buscar...',
                          labelStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'Montserrat',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w300,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          contentPadding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                            ),
                        cursorColor: FlutterFlowTheme.of(context).primary,
                        validator: _model.searchFieldTextControllerValidator
                            .asValidator(context),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        _model.isLoading = true;
                        _model.searchValue =
                            _model.searchFieldTextController.text;
                        _model.rulesDocuments = functions
                            .pagination(
                                functions
                                    .searchRuleDocumentsFilter(
                                        FFAppState()
                                            .rulesDocumentsArray
                                            .toList(),
                                        _model.searchFieldTextController.text)
                                    .toList(),
                                _model.rulesPerPage!)
                            .toList()
                            .cast<dynamic>();
                        setState(() {});
                        _model.isLoading = false;
                        setState(() {});
                      },
                      child: Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).secondaryText,
                            width: 2.0,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 36.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_model.searchValue != null && _model.searchValue != '')
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          _model.isLoading = true;
                          _model.searchValue = null;
                          _model.rulesDocuments = functions
                              .pagination(
                                  FFAppState().rulesDocumentsArray.toList(),
                                  _model.rulesPerPage!)
                              .toList()
                              .cast<dynamic>();
                          setState(() {});
                          setState(() {
                            _model.searchFieldTextController?.text = '';
                            _model.searchFieldTextController?.selection =
                                TextSelection.collapsed(
                                    offset: _model.searchFieldTextController!
                                        .text.length);
                          });
                          _model.isLoading = false;
                          setState(() {});
                        },
                        child: Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              width: 2.0,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.clear,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 36.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ].divide(const SizedBox(width: 4.0)),
                ),
              ),
              if (_model.isLoading)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                  child: Lottie.asset(
                    'assets/lottie_animations/Animation_-_1716841230423.json',
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    height: MediaQuery.sizeOf(context).height * 0.25,
                    fit: BoxFit.contain,
                    animate: true,
                  ),
                ),
              if (!_model.isLoading)
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                    child: wrapWithModel(
                      model: _model.rulesDocumentsListModel,
                      updateCallback: () => setState(() {}),
                      child: RulesDocumentsListWidget(
                        rulesTotalRows: _model.rulesTotal!,
                        searchValue: _model.searchValue != null &&
                                _model.searchValue != ''
                            ? _model.searchValue!
                            : '',
                        rulesArray: _model.rulesDocuments,
                        toggleIsLoading: () async {
                          _model.isLoading = !_model.isLoading;
                          setState(() {});
                        },
                        setMoreRules: (perPage) async {
                          _model.rulesDocuments = functions
                              .pagination(
                                  functions
                                      .searchRuleDocumentsFilter(
                                          FFAppState()
                                              .rulesDocumentsArray
                                              .toList(),
                                          _model.searchFieldTextController.text)
                                      .toList(),
                                  perPage)
                              .toList()
                              .cast<dynamic>();
                          setState(() {});
                        },
                        reloadQuery: () async {
                          var shouldSetState = false;
                          Function() navigate = () {};
                          _model.isLoading = true;
                          setState(() {});
                          _model.reloadRulesResp =
                              await OriginalAPIEndpointsGroup.getDocumentsCall
                                  .call(
                            token: currentAuthenticationToken,
                            perPage: _model.rulesPerPage,
                          );

                          shouldSetState = true;
                          if ((_model.reloadRulesResp?.succeeded ?? true)) {
                            FFAppState().rulesDocumentsArray =
                                OriginalAPIEndpointsGroup.getDocumentsCall
                                    .data(
                                      (_model.reloadRulesResp?.jsonBody ?? ''),
                                    )!
                                    .toList()
                                    .cast<dynamic>();
                            setState(() {});
                            _model.rulesTotal =
                                FFAppState().rulesDocumentsArray.length;
                            _model.rulesDocuments = functions
                                .pagination(
                                    functions
                                        .searchRuleDocumentsFilter(
                                            OriginalAPIEndpointsGroup
                                                .getDocumentsCall
                                                .data(
                                                  (_model.reloadRulesResp
                                                          ?.jsonBody ??
                                                      ''),
                                                )!
                                                .toList(),
                                            _model
                                                .searchFieldTextController.text)
                                        .toList(),
                                    _model.rulesDocumentsListModel
                                        .moreRulesPerPage)
                                .toList()
                                .cast<dynamic>();
                            setState(() {});
                          } else {
                            if ((_model.reloadRulesResp?.statusCode ?? 200) ==
                                401) {
                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signOut();
                              GoRouter.of(context).clearRedirectLocation();

                              navigate = () =>
                                  context.goNamedAuth('Login', context.mounted);
                              if (shouldSetState) setState(() {});
                              return;
                            }
                          }

                          _model.isLoading = false;
                          setState(() {});

                          navigate();
                          if (shouldSetState) setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
