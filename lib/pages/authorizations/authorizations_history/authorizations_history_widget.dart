import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/authorizations/all_authorizations_list/all_authorizations_list_widget.dart';
import '/components/ui/alert_message/alert_message_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'authorizations_history_model.dart';
export 'authorizations_history_model.dart';

class AuthorizationsHistoryWidget extends StatefulWidget {
  const AuthorizationsHistoryWidget({super.key});

  @override
  State<AuthorizationsHistoryWidget> createState() =>
      _AuthorizationsHistoryWidgetState();
}

class _AuthorizationsHistoryWidgetState
    extends State<AuthorizationsHistoryWidget> {
  late AuthorizationsHistoryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AuthorizationsHistoryModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Function() navigate = () {};
      _model.isLoading = true;
      setState(() {});
      _model.allAuthsResp = await AuthorizationsGroup.getHistoryAuthsCall.call(
        token: currentAuthenticationToken,
        perPage: 10,
      );

      if ((_model.allAuthsResp?.succeeded ?? true)) {
        FFAppState().allAuthorizations = AuthorizationsGroup.getHistoryAuthsCall
            .rows(
              (_model.allAuthsResp?.jsonBody ?? ''),
            )!
            .toList()
            .cast<dynamic>();
        setState(() {});
        _model.authorizationsTotal =
            AuthorizationsGroup.getHistoryAuthsCall.totalRows(
          (_model.allAuthsResp?.jsonBody ?? ''),
        );
        setState(() {});
      } else {
        if ((_model.allAuthsResp?.statusCode ?? 200) == 401) {
          GoRouter.of(context).prepareAuthEvent();
          await authManager.signOut();
          GoRouter.of(context).clearRedirectLocation();

          navigate = () => context.goNamedAuth('Login', context.mounted);

          navigate();
          return;
        } else {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            barrierColor: FlutterFlowTheme.of(context).barrierColor,
            context: context,
            builder: (context) {
              return GestureDetector(
                onTap: () => _model.unfocusNode.canRequestFocus
                    ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                    : FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: AlertMessageWidget(
                    buttonText: 'Aceptar',
                    title:
                        'Error: ${(_model.allAuthsResp?.statusCode ?? 200).toString()}',
                    message: valueOrDefault<String>(
                      AuthorizationsGroup.getHistoryAuthsCall.message(
                        (_model.allAuthsResp?.jsonBody ?? ''),
                      ),
                      'Ocurrió un error en el servidor.',
                    ),
                  ),
                ),
              );
            },
          ).then((value) => safeSetState(() {}));
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
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
              onPressed: () async {
                context.safePop();
              },
            ),
            title: Text(
              'Historial de Autorizaciones',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Montserrat',
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 18.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            actions: const [],
            centerTitle: false,
            elevation: 0.0,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
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
                        var shouldSetState = false;
                        Function() navigate = () {};
                        _model.isLoading = true;
                        setState(() {});
                        _model.searchValue =
                            _model.searchFieldTextController.text;
                        setState(() {});
                        _model.searchAuthsResp =
                            await AuthorizationsGroup.getHistoryAuthsCall.call(
                          token: currentAuthenticationToken,
                          perPage: _model.authorizationsPerPage,
                          searchValue: _model.searchFieldTextController.text,
                        );

                        shouldSetState = true;
                        if ((_model.searchAuthsResp?.succeeded ?? true)) {
                          FFAppState().allAuthorizations =
                              AuthorizationsGroup.getHistoryAuthsCall
                                  .rows(
                                    (_model.searchAuthsResp?.jsonBody ?? ''),
                                  )!
                                  .toList()
                                  .cast<dynamic>();
                          setState(() {});
                          _model.authorizationsTotal =
                              AuthorizationsGroup.getHistoryAuthsCall.totalRows(
                            (_model.searchAuthsResp?.jsonBody ?? ''),
                          );
                          setState(() {});
                        } else {
                          if ((_model.searchAuthsResp?.statusCode ?? 200) ==
                              401) {
                            GoRouter.of(context).prepareAuthEvent();
                            await authManager.signOut();
                            GoRouter.of(context).clearRedirectLocation();

                            navigate = () =>
                                context.goNamedAuth('Login', context.mounted);

                            navigate();
                            if (shouldSetState) setState(() {});
                            return;
                          } else {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              barrierColor:
                                  FlutterFlowTheme.of(context).barrierColor,
                              context: context,
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () =>
                                      _model.unfocusNode.canRequestFocus
                                          ? FocusScope.of(context)
                                              .requestFocus(_model.unfocusNode)
                                          : FocusScope.of(context).unfocus(),
                                  child: Padding(
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: AlertMessageWidget(
                                      buttonText: 'Aceptar',
                                      title:
                                          'Error: ${(_model.searchAuthsResp?.statusCode ?? 200).toString()}',
                                      message: valueOrDefault<String>(
                                        AuthorizationsGroup.getHistoryAuthsCall
                                            .message(
                                          (_model.searchAuthsResp?.jsonBody ??
                                              ''),
                                        ),
                                        'Ocurrió un error en el servidor.',
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          }
                        }

                        _model.isLoading = false;
                        setState(() {});

                        navigate();
                        if (shouldSetState) setState(() {});
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
                          var shouldSetState = false;
                          Function() navigate = () {};
                          _model.isLoading = true;
                          setState(() {});
                          setState(() {
                            _model.searchFieldTextController?.text = '';
                            _model.searchFieldTextController?.selection =
                                TextSelection.collapsed(
                                    offset: _model.searchFieldTextController!
                                        .text.length);
                          });
                          _model.searchValue = null;
                          setState(() {});
                          _model.clearSearchAuthsResp =
                              await AuthorizationsGroup.getHistoryAuthsCall
                                  .call(
                            token: currentAuthenticationToken,
                            perPage: _model.authorizationsPerPage,
                          );

                          shouldSetState = true;
                          if ((_model.clearSearchAuthsResp?.succeeded ??
                              true)) {
                            FFAppState().allAuthorizations = AuthorizationsGroup
                                .getHistoryAuthsCall
                                .rows(
                                  (_model.clearSearchAuthsResp?.jsonBody ?? ''),
                                )!
                                .toList()
                                .cast<dynamic>();
                            setState(() {});
                            _model.authorizationsTotal = AuthorizationsGroup
                                .getHistoryAuthsCall
                                .totalRows(
                              (_model.clearSearchAuthsResp?.jsonBody ?? ''),
                            );
                            setState(() {});
                          } else {
                            if ((_model.clearSearchAuthsResp?.statusCode ??
                                    200) ==
                                401) {
                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signOut();
                              GoRouter.of(context).clearRedirectLocation();

                              navigate = () =>
                                  context.goNamedAuth('Login', context.mounted);

                              navigate();
                              if (shouldSetState) setState(() {});
                              return;
                            } else {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                barrierColor:
                                    FlutterFlowTheme.of(context).barrierColor,
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () => _model
                                            .unfocusNode.canRequestFocus
                                        ? FocusScope.of(context)
                                            .requestFocus(_model.unfocusNode)
                                        : FocusScope.of(context).unfocus(),
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: AlertMessageWidget(
                                        buttonText: 'Aceptar',
                                        title:
                                            'Error: ${(_model.clearSearchAuthsResp?.statusCode ?? 200).toString()}',
                                        message: valueOrDefault<String>(
                                          AuthorizationsGroup
                                              .getHistoryAuthsCall
                                              .message(
                                            (_model.clearSearchAuthsResp
                                                    ?.jsonBody ??
                                                ''),
                                          ),
                                          'Ocurrió un error en el servidor.',
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            }
                          }

                          _model.isLoading = false;
                          setState(() {});

                          navigate();
                          if (shouldSetState) setState(() {});
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
                      model: _model.allAuthorizationsListModel,
                      updateCallback: () => setState(() {}),
                      child: AllAuthorizationsListWidget(
                        authorizationsTotalRows: _model.authorizationsTotal!,
                        searchValue: _model.searchValue != null &&
                                _model.searchValue != ''
                            ? _model.searchValue!
                            : '',
                        authorizationsArray: FFAppState().allAuthorizations,
                        toggleIsLoading: () async {
                          _model.isLoading = !_model.isLoading;
                          setState(() {});
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
