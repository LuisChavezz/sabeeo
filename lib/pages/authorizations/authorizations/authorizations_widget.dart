import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/authorizations/received_authorizations_list/received_authorizations_list_widget.dart';
import '/components/authorizations/requested_authorizations_list/requested_authorizations_list_widget.dart';
import '/components/ui/alert_message/alert_message_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'authorizations_model.dart';
export 'authorizations_model.dart';

class AuthorizationsWidget extends StatefulWidget {
  const AuthorizationsWidget({super.key});

  @override
  State<AuthorizationsWidget> createState() => _AuthorizationsWidgetState();
}

class _AuthorizationsWidgetState extends State<AuthorizationsWidget> {
  late AuthorizationsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AuthorizationsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Function() navigate = () {};
      _model.isLoading = true;
      safeSetState(() {});
      _model.reqAuthsResp =
          await AuthorizationsGroup.getRequestedAuthsCall.call(
        token: currentAuthenticationToken,
        perPage: _model.reqAuthorizationsPerPage,
        emitterId: currentUserUid,
      );

      if ((_model.reqAuthsResp?.succeeded ?? true)) {
        FFAppState().reqAuthorizationsArray =
            AuthorizationsGroup.getRequestedAuthsCall
                .rows(
                  (_model.reqAuthsResp?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
        safeSetState(() {});
        _model.reqAuthorizationsTotal =
            AuthorizationsGroup.getRequestedAuthsCall.totalRows(
          (_model.reqAuthsResp?.jsonBody ?? ''),
        );
        safeSetState(() {});
      } else {
        if ((_model.reqAuthsResp?.statusCode ?? 200) == 401) {
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
              return WebViewAware(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: AlertMessageWidget(
                      buttonText: 'Aceptar',
                      title:
                          'Error: ${(_model.reqAuthsResp?.statusCode ?? 200).toString()}',
                      message: valueOrDefault<String>(
                        AuthorizationsGroup.getRequestedAuthsCall
                            .message(
                              (_model.reqAuthsResp?.jsonBody ?? ''),
                            )
                            .toString(),
                        'Ocurrió un error en el servidor.',
                      ),
                    ),
                  ),
                ),
              );
            },
          ).then((value) => safeSetState(() {}));
        }
      }

      _model.recAuthsResp = await AuthorizationsGroup.getReceivedAuthsCall.call(
        token: currentAuthenticationToken,
        perPage: _model.recAuthorizationsPerPage,
      );

      if ((_model.recAuthsResp?.succeeded ?? true)) {
        FFAppState().recAuthorizationsArray =
            AuthorizationsGroup.getReceivedAuthsCall
                .rows(
                  (_model.recAuthsResp?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
        safeSetState(() {});
        _model.recAuthorizationsTotal =
            AuthorizationsGroup.getReceivedAuthsCall.totalRows(
          (_model.recAuthsResp?.jsonBody ?? ''),
        );
        safeSetState(() {});
      } else {
        if ((_model.recAuthsResp?.statusCode ?? 200) == 401) {
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
              return WebViewAware(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: AlertMessageWidget(
                      buttonText: 'Aceptar',
                      title:
                          'Error: ${(_model.recAuthsResp?.statusCode ?? 200).toString()}',
                      message: valueOrDefault<String>(
                        AuthorizationsGroup.getReceivedAuthsCall.message(
                          (_model.recAuthsResp?.jsonBody ?? ''),
                        ),
                        'Ocurrió un erro en el servidor.',
                      ),
                    ),
                  ),
                ),
              );
            },
          ).then((value) => safeSetState(() {}));
        }
      }

      _model.isLoading = false;
      safeSetState(() {});

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
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () async {
                                _model.switchValue = 'solic';
                                safeSetState(() {});
                                safeSetState(() {
                                  _model.searchFieldTextController?.text =
                                      (_model.searchReqValue != null &&
                                              _model.searchReqValue != ''
                                          ? _model.searchReqValue!
                                          : '');
                                  _model.searchFieldTextController?.selection =
                                      TextSelection.collapsed(
                                          offset: _model
                                              .searchFieldTextController!
                                              .text
                                              .length);
                                });
                              },
                              text: 'Solicitadas',
                              options: FFButtonOptions(
                                height: 48.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    6.0, 0.0, 6.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: _model.switchValue == 'solic'
                                    ? FlutterFlowTheme.of(context).primary
                                    : FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: _model.switchValue == 'solic'
                                          ? FlutterFlowTheme.of(context)
                                              .primaryBackground
                                          : FlutterFlowTheme.of(context)
                                              .primary,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                elevation: 2.0,
                                borderSide: BorderSide(
                                  color: _model.switchValue == 'solic'
                                      ? Colors.transparent
                                      : FlutterFlowTheme.of(context).primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () async {
                                _model.switchValue = 'recib';
                                safeSetState(() {});
                                safeSetState(() {
                                  _model.searchFieldTextController?.text =
                                      (_model.searchRecValue != null &&
                                              _model.searchRecValue != ''
                                          ? _model.searchRecValue!
                                          : '');
                                  _model.searchFieldTextController?.selection =
                                      TextSelection.collapsed(
                                          offset: _model
                                              .searchFieldTextController!
                                              .text
                                              .length);
                                });
                              },
                              text: 'Recibidas',
                              options: FFButtonOptions(
                                height: 48.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    6.0, 0.0, 6.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: _model.switchValue == 'recib'
                                    ? FlutterFlowTheme.of(context).primary
                                    : FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: _model.switchValue == 'recib'
                                          ? FlutterFlowTheme.of(context)
                                              .primaryBackground
                                          : FlutterFlowTheme.of(context)
                                              .primary,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                elevation: 2.0,
                                borderSide: BorderSide(
                                  color: _model.switchValue == 'recib'
                                      ? Colors.transparent
                                      : FlutterFlowTheme.of(context).primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ].divide(const SizedBox(width: 16.0)),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
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
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
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
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor: FlutterFlowTheme.of(context).primary,
                              validator: _model
                                  .searchFieldTextControllerValidator
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
                              safeSetState(() {});
                              if (_model.switchValue == 'solic') {
                                _model.searchReqValue =
                                    _model.searchFieldTextController.text;
                                safeSetState(() {});
                                _model.reqSearchAuthsResp =
                                    await AuthorizationsGroup
                                        .getRequestedAuthsCall
                                        .call(
                                  token: currentAuthenticationToken,
                                  perPage: _model.reqAuthorizationsPerPage,
                                  searchValue:
                                      _model.searchFieldTextController.text,
                                  emitterId: currentUserUid,
                                );

                                shouldSetState = true;
                                if ((_model.reqSearchAuthsResp?.succeeded ??
                                    true)) {
                                  FFAppState().reqAuthorizationsArray =
                                      AuthorizationsGroup.getRequestedAuthsCall
                                          .rows(
                                            (_model.reqSearchAuthsResp
                                                    ?.jsonBody ??
                                                ''),
                                          )!
                                          .toList()
                                          .cast<dynamic>();
                                  safeSetState(() {});
                                  _model.reqAuthorizationsTotal =
                                      AuthorizationsGroup.getRequestedAuthsCall
                                          .totalRows(
                                    (_model.reqSearchAuthsResp?.jsonBody ?? ''),
                                  );
                                  safeSetState(() {});
                                } else {
                                  if ((_model.reqSearchAuthsResp?.statusCode ??
                                          200) ==
                                      401) {
                                    GoRouter.of(context).prepareAuthEvent();
                                    await authManager.signOut();
                                    GoRouter.of(context)
                                        .clearRedirectLocation();

                                    navigate = () => context.goNamedAuth(
                                        'Login', context.mounted);

                                    navigate();
                                    if (shouldSetState) safeSetState(() {});
                                    return;
                                  } else {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      barrierColor: FlutterFlowTheme.of(context)
                                          .barrierColor,
                                      context: context,
                                      builder: (context) {
                                        return WebViewAware(
                                          child: GestureDetector(
                                            onTap: () => FocusScope.of(context)
                                                .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: AlertMessageWidget(
                                                buttonText: 'Aceptar',
                                                title:
                                                    'Error: ${(_model.reqSearchAuthsResp?.statusCode ?? 200).toString()}',
                                                message: valueOrDefault<String>(
                                                  AuthorizationsGroup
                                                      .getRequestedAuthsCall
                                                      .message(
                                                        (_model.reqSearchAuthsResp
                                                                ?.jsonBody ??
                                                            ''),
                                                      )
                                                      .toString(),
                                                  'Ocurrió un erro en el servidor.',
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  }
                                }
                              } else {
                                _model.searchRecValue =
                                    _model.searchFieldTextController.text;
                                safeSetState(() {});
                                _model.recSearchAuthsResp =
                                    await AuthorizationsGroup
                                        .getReceivedAuthsCall
                                        .call(
                                  token: currentAuthenticationToken,
                                  perPage: _model.recAuthorizationsPerPage,
                                  searchValue:
                                      _model.searchFieldTextController.text,
                                );

                                shouldSetState = true;
                                if ((_model.recSearchAuthsResp?.succeeded ??
                                    true)) {
                                  FFAppState().recAuthorizationsArray =
                                      AuthorizationsGroup.getReceivedAuthsCall
                                          .rows(
                                            (_model.recSearchAuthsResp
                                                    ?.jsonBody ??
                                                ''),
                                          )!
                                          .toList()
                                          .cast<dynamic>();
                                  safeSetState(() {});
                                  _model.recAuthorizationsTotal =
                                      AuthorizationsGroup.getReceivedAuthsCall
                                          .totalRows(
                                    (_model.recSearchAuthsResp?.jsonBody ?? ''),
                                  );
                                  safeSetState(() {});
                                } else {
                                  if ((_model.recSearchAuthsResp?.statusCode ??
                                          200) ==
                                      401) {
                                    GoRouter.of(context).prepareAuthEvent();
                                    await authManager.signOut();
                                    GoRouter.of(context)
                                        .clearRedirectLocation();

                                    navigate = () => context.goNamedAuth(
                                        'Login', context.mounted);

                                    navigate();
                                    if (shouldSetState) safeSetState(() {});
                                    return;
                                  } else {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      barrierColor: FlutterFlowTheme.of(context)
                                          .barrierColor,
                                      context: context,
                                      builder: (context) {
                                        return WebViewAware(
                                          child: GestureDetector(
                                            onTap: () => FocusScope.of(context)
                                                .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: AlertMessageWidget(
                                                buttonText: 'Aceptar',
                                                title:
                                                    'Error: ${(_model.recSearchAuthsResp?.statusCode ?? 200).toString()}',
                                                message: valueOrDefault<String>(
                                                  AuthorizationsGroup
                                                      .getReceivedAuthsCall
                                                      .message(
                                                    (_model.recSearchAuthsResp
                                                            ?.jsonBody ??
                                                        ''),
                                                  ),
                                                  'Ocurrió un error en el servidor.',
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  }
                                }
                              }

                              _model.isLoading = false;
                              safeSetState(() {});

                              navigate();
                              if (shouldSetState) safeSetState(() {});
                            },
                            child: Container(
                              width: 48.0,
                              height: 48.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  width: 2.0,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 36.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (((_model.switchValue == 'solic') &&
                                  (_model.searchReqValue != null &&
                                      _model.searchReqValue != '')) ||
                              ((_model.switchValue == 'recib') &&
                                  (_model.searchRecValue != null &&
                                      _model.searchRecValue != '')))
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                var shouldSetState = false;
                                Function() navigate = () {};
                                _model.isLoading = true;
                                safeSetState(() {});
                                safeSetState(() {
                                  _model.searchFieldTextController?.text = '';
                                  _model.searchFieldTextController?.selection =
                                      TextSelection.collapsed(
                                          offset: _model
                                              .searchFieldTextController!
                                              .text
                                              .length);
                                });
                                if (_model.switchValue == 'solic') {
                                  _model.searchReqValue = null;
                                  safeSetState(() {});
                                  _model.reqClearSearchAuthsResp =
                                      await AuthorizationsGroup
                                          .getRequestedAuthsCall
                                          .call(
                                    token: currentAuthenticationToken,
                                    perPage: _model.reqAuthorizationsPerPage,
                                    emitterId: currentUserUid,
                                  );

                                  shouldSetState = true;
                                  if ((_model
                                          .reqClearSearchAuthsResp?.succeeded ??
                                      true)) {
                                    FFAppState().reqAuthorizationsArray =
                                        AuthorizationsGroup
                                            .getRequestedAuthsCall
                                            .rows(
                                              (_model.reqClearSearchAuthsResp
                                                      ?.jsonBody ??
                                                  ''),
                                            )!
                                            .toList()
                                            .cast<dynamic>();
                                    safeSetState(() {});
                                    _model.reqAuthorizationsTotal =
                                        AuthorizationsGroup
                                            .getRequestedAuthsCall
                                            .totalRows(
                                      (_model.reqClearSearchAuthsResp
                                              ?.jsonBody ??
                                          ''),
                                    );
                                    safeSetState(() {});
                                  } else {
                                    if ((_model.reqClearSearchAuthsResp
                                                ?.statusCode ??
                                            200) ==
                                        401) {
                                      GoRouter.of(context).prepareAuthEvent();
                                      await authManager.signOut();
                                      GoRouter.of(context)
                                          .clearRedirectLocation();

                                      navigate = () => context.goNamedAuth(
                                          'Login', context.mounted);

                                      navigate();
                                      if (shouldSetState) safeSetState(() {});
                                      return;
                                    } else {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        barrierColor:
                                            FlutterFlowTheme.of(context)
                                                .barrierColor,
                                        context: context,
                                        builder: (context) {
                                          return WebViewAware(
                                            child: GestureDetector(
                                              onTap: () =>
                                                  FocusScope.of(context)
                                                      .unfocus(),
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child: AlertMessageWidget(
                                                  buttonText: 'Aceptar',
                                                  title:
                                                      'Error: ${(_model.reqClearSearchAuthsResp?.statusCode ?? 200).toString()}',
                                                  message:
                                                      valueOrDefault<String>(
                                                    AuthorizationsGroup
                                                        .getRequestedAuthsCall
                                                        .message(
                                                          (_model.reqClearSearchAuthsResp
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )
                                                        .toString(),
                                                    'Ocurrió un error en el servidor.',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    }
                                  }
                                } else {
                                  _model.searchRecValue = null;
                                  safeSetState(() {});
                                  _model.recClearSearchAuthsResp =
                                      await AuthorizationsGroup
                                          .getReceivedAuthsCall
                                          .call(
                                    token: currentAuthenticationToken,
                                    perPage: _model.recAuthorizationsPerPage,
                                  );

                                  shouldSetState = true;
                                  if ((_model
                                          .recClearSearchAuthsResp?.succeeded ??
                                      true)) {
                                    FFAppState().recAuthorizationsArray =
                                        AuthorizationsGroup.getReceivedAuthsCall
                                            .rows(
                                              (_model.recClearSearchAuthsResp
                                                      ?.jsonBody ??
                                                  ''),
                                            )!
                                            .toList()
                                            .cast<dynamic>();
                                    safeSetState(() {});
                                    _model.recAuthorizationsTotal =
                                        AuthorizationsGroup.getReceivedAuthsCall
                                            .totalRows(
                                      (_model.recClearSearchAuthsResp
                                              ?.jsonBody ??
                                          ''),
                                    );
                                    safeSetState(() {});
                                  } else {
                                    if ((_model.recClearSearchAuthsResp
                                                ?.statusCode ??
                                            200) ==
                                        401) {
                                      GoRouter.of(context).prepareAuthEvent();
                                      await authManager.signOut();
                                      GoRouter.of(context)
                                          .clearRedirectLocation();

                                      navigate = () => context.goNamedAuth(
                                          'Login', context.mounted);

                                      navigate();
                                      if (shouldSetState) safeSetState(() {});
                                      return;
                                    } else {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        barrierColor:
                                            FlutterFlowTheme.of(context)
                                                .barrierColor,
                                        context: context,
                                        builder: (context) {
                                          return WebViewAware(
                                            child: GestureDetector(
                                              onTap: () =>
                                                  FocusScope.of(context)
                                                      .unfocus(),
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child: AlertMessageWidget(
                                                  buttonText: 'Aceptar',
                                                  title:
                                                      'Error: ${(_model.recClearSearchAuthsResp?.statusCode ?? 200).toString()}',
                                                  message:
                                                      valueOrDefault<String>(
                                                    AuthorizationsGroup
                                                        .getReceivedAuthsCall
                                                        .message(
                                                      (_model.recClearSearchAuthsResp
                                                              ?.jsonBody ??
                                                          ''),
                                                    ),
                                                    'Ocurrió un error en el servidor.',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    }
                                  }
                                }

                                _model.isLoading = false;
                                safeSetState(() {});

                                navigate();
                                if (shouldSetState) safeSetState(() {});
                              },
                              child: Container(
                                width: 48.0,
                                height: 48.0,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    width: 2.0,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.clear,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                        child: Lottie.asset(
                          'assets/lottie_animations/loading_sabeeo.json',
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          height: MediaQuery.sizeOf(context).height * 0.25,
                          fit: BoxFit.contain,
                          animate: true,
                        ),
                      ),
                    if ((_model.switchValue == 'solic') && !_model.isLoading)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 24.0),
                          child: wrapWithModel(
                            model: _model.requestedAuthorizationsListModel,
                            updateCallback: () => safeSetState(() {}),
                            child: RequestedAuthorizationsListWidget(
                              authorizationsTotalRows:
                                  _model.reqAuthorizationsTotal!,
                              authorizationsArray:
                                  FFAppState().reqAuthorizationsArray,
                              searchValue: _model.searchReqValue != null &&
                                      _model.searchReqValue != ''
                                  ? _model.searchReqValue!
                                  : '',
                              toggleIsLoading: () async {
                                _model.isLoading = !_model.isLoading;
                                safeSetState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                    if ((_model.switchValue == 'recib') && !_model.isLoading)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 24.0),
                          child: wrapWithModel(
                            model: _model.receivedAuthorizationsListModel,
                            updateCallback: () => safeSetState(() {}),
                            child: ReceivedAuthorizationsListWidget(
                              authorizationsTotalRows:
                                  _model.recAuthorizationsTotal!,
                              authorizationsArray:
                                  FFAppState().recAuthorizationsArray,
                              searchValue: _model.searchRecValue != null &&
                                      _model.searchRecValue != ''
                                  ? _model.searchRecValue!
                                  : '',
                              toggleIsLoading: () async {
                                _model.isLoading = !_model.isLoading;
                                safeSetState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Align(
                  alignment: const AlignmentDirectional(1.0, 1.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 24.0, 24.0),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 60.0,
                      borderWidth: 0.0,
                      buttonSize: 50.0,
                      fillColor: FlutterFlowTheme.of(context).secondary,
                      icon: Icon(
                        Icons.history_sharp,
                        color: FlutterFlowTheme.of(context).tertiary,
                        size: 32.0,
                      ),
                      onPressed: () async {
                        context.pushNamed('Authorizations_history');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
