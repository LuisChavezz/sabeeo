import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/communication/memorandum_list/memorandum_list_widget.dart';
import '/components/communication/notifications_list/notifications_list_widget.dart';
import '/components/ui/alert_message/alert_message_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'communication_model.dart';
export 'communication_model.dart';

class CommunicationWidget extends StatefulWidget {
  const CommunicationWidget({super.key});

  @override
  State<CommunicationWidget> createState() => _CommunicationWidgetState();
}

class _CommunicationWidgetState extends State<CommunicationWidget> {
  late CommunicationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommunicationModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Function() navigate = () {};
      _model.isLoading = true;
      _model.switchValue = 'notis';
      safeSetState(() {});
      _model.memorandumsResp = await MemorandumGroup.getMemorandumsCall.call(
        token: currentAuthenticationToken,
        perPage: _model.memorandumsPerPage,
        status: 'UNVIEWED',
      );

      if ((_model.memorandumsResp?.succeeded ?? true)) {
        FFAppState().memorandumsArray = MemorandumGroup.getMemorandumsCall
            .rows(
              (_model.memorandumsResp?.jsonBody ?? ''),
            )!
            .toList()
            .cast<dynamic>();
        FFAppState().tempIntValue = 0;
        safeSetState(() {});
        _model.memorandumsTotal = MemorandumGroup.getMemorandumsCall.totalRows(
          (_model.memorandumsResp?.jsonBody ?? ''),
        );
        safeSetState(() {});
      } else {
        if ((_model.memorandumsResp?.statusCode ?? 200) == 401) {
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
                          'Error: ${(_model.memorandumsResp?.statusCode ?? 200).toString()}',
                      message: valueOrDefault<String>(
                        MemorandumGroup.getMemorandumsCall.message(
                          (_model.memorandumsResp?.jsonBody ?? ''),
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

      _model.notificationsResp =
          await NotificationsGroup.getNotificationsCall.call(
        token: currentAuthenticationToken,
        perPage: _model.notificationsPerPage,
        read: 'false',
      );

      if ((_model.notificationsResp?.succeeded ?? true)) {
        FFAppState().notificationsArray =
            NotificationsGroup.getNotificationsCall
                .rows(
                  (_model.notificationsResp?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
        safeSetState(() {});
        _model.notificationsTotal =
            NotificationsGroup.getNotificationsCall.totalRows(
          (_model.notificationsResp?.jsonBody ?? ''),
        );
        safeSetState(() {});
      } else {
        if ((_model.notificationsResp?.statusCode ?? 200) == 401) {
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
                          'Error: ${(_model.notificationsResp?.statusCode ?? 200).toString()}',
                      message: valueOrDefault<String>(
                        NotificationsGroup.getNotificationsCall
                            .message(
                              (_model.notificationsResp?.jsonBody ?? ''),
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

      _model.isLoading = false;
      safeSetState(() {});

      navigate();
    });
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
                          FFButtonWidget(
                            onPressed: () async {
                              _model.switchValue = 'comun';
                              safeSetState(() {});
                            },
                            text: 'Comunicados',
                            options: FFButtonOptions(
                              height: 48.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  6.0, 0.0, 6.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: _model.switchValue == 'comun'
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context)
                                      .primaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Montserrat',
                                    color: _model.switchValue == 'comun'
                                        ? FlutterFlowTheme.of(context)
                                            .primaryBackground
                                        : FlutterFlowTheme.of(context).primary,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                              elevation: 2.0,
                              borderSide: BorderSide(
                                color: _model.switchValue == 'comun'
                                    ? Colors.transparent
                                    : FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              _model.switchValue = 'notis';
                              safeSetState(() {});
                            },
                            text: 'Notificaciones',
                            options: FFButtonOptions(
                              height: 48.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  6.0, 0.0, 6.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: _model.switchValue == 'notis'
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context)
                                      .primaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Montserrat',
                                    color: _model.switchValue == 'notis'
                                        ? FlutterFlowTheme.of(context)
                                            .primaryBackground
                                        : FlutterFlowTheme.of(context).primary,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                              elevation: 2.0,
                              borderSide: BorderSide(
                                color: _model.switchValue == 'notis'
                                    ? Colors.transparent
                                    : FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ].divide(const SizedBox(width: 16.0)),
                      ),
                    ),
                    if (_model.isLoading)
                      Lottie.asset(
                        'assets/lottie_animations/loading_sabeeo.json',
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        height: MediaQuery.sizeOf(context).height * 0.25,
                        fit: BoxFit.contain,
                        animate: true,
                      ),
                    if (((_model.memorandumsSwitchValue == 'UNVIEWED') ||
                            (_model.notificationsSwitchValue == 'unread')) &&
                        !_model.isLoading)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 24.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_model.switchValue == 'comun')
                              Text(
                                valueOrDefault<String>(
                                  FFAppState().tempIntValue > 0
                                      ? FFAppState().tempIntValue.toString()
                                      : _model.memorandumsTotal?.toString(),
                                  'zzz',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            if (_model.switchValue == 'notis')
                              Text(
                                valueOrDefault<String>(
                                  _model.notificationsTotal?.toString(),
                                  '0',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            Text(
                              'por leer.',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ].divide(const SizedBox(width: 2.0)),
                        ),
                      ),
                    if ((_model.switchValue == 'comun') && !_model.isLoading)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 24.0),
                          child: wrapWithModel(
                            model: _model.memorandumListModel,
                            updateCallback: () => safeSetState(() {}),
                            child: MemorandumListWidget(
                              memorandumsTotalRows: valueOrDefault<int>(
                                FFAppState().tempIntValue > 0
                                    ? FFAppState().tempIntValue
                                    : _model.memorandumsTotal,
                                0,
                              ),
                              memorandumsArray: FFAppState().memorandumsArray,
                              viewedValue: _model.memorandumsSwitchValue,
                              toggleIsLoading: () async {
                                _model.isLoading = !_model.isLoading;
                                safeSetState(() {});
                              },
                              setMemorandumsTotal: (totalRows) async {
                                _model.memorandumsTotal = totalRows;
                                safeSetState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                    if ((_model.switchValue == 'notis') && !_model.isLoading)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 24.0),
                          child: wrapWithModel(
                            model: _model.notificationsListModel,
                            updateCallback: () => safeSetState(() {}),
                            child: NotificationsListWidget(
                              notificationsTotalRows:
                                  _model.notificationsTotal!,
                              notificationsArray:
                                  FFAppState().notificationsArray,
                              readValue: valueOrDefault<String>(
                                _model.notificationsSwitchValue == 'read'
                                    ? 'true'
                                    : 'false',
                                'false',
                              ),
                              toggleIsLoading: () async {
                                _model.isLoading = !_model.isLoading;
                                safeSetState(() {});
                              },
                              setNotificationsTotal: (totalRows) async {
                                _model.notificationsTotal = totalRows;
                                safeSetState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                if ((_model.notificationsSwitchValue == 'unread') &&
                    !_model.isLoading)
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
                        icon: FaIcon(
                          FontAwesomeIcons.eyeSlash,
                          color: FlutterFlowTheme.of(context).tertiary,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          var shouldSetState = false;
                          Function() navigate = () {};
                          _model.notificationsSwitchValue = 'read';
                          _model.isLoading = true;
                          _model.memorandumsSwitchValue = 'VIEWED';
                          safeSetState(() {});
                          _model.readedMemorandumsResp =
                              await MemorandumGroup.getMemorandumsCall.call(
                            token: currentAuthenticationToken,
                            perPage: _model.memorandumsPerPage,
                            status: 'VIEWED',
                          );

                          shouldSetState = true;
                          if ((_model.readedMemorandumsResp?.succeeded ??
                              true)) {
                            FFAppState().memorandumsArray =
                                MemorandumGroup.getMemorandumsCall
                                    .rows(
                                      (_model.readedMemorandumsResp?.jsonBody ??
                                          ''),
                                    )!
                                    .toList()
                                    .cast<dynamic>();
                            safeSetState(() {});
                            _model.memorandumsTotal =
                                MemorandumGroup.getMemorandumsCall.totalRows(
                              (_model.readedMemorandumsResp?.jsonBody ?? ''),
                            );
                            safeSetState(() {});
                          } else {
                            if ((_model.readedMemorandumsResp?.statusCode ??
                                    200) ==
                                401) {
                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signOut();
                              GoRouter.of(context).clearRedirectLocation();

                              navigate = () =>
                                  context.goNamedAuth('Login', context.mounted);

                              navigate();
                              if (shouldSetState) safeSetState(() {});
                              return;
                            } else {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                barrierColor:
                                    FlutterFlowTheme.of(context).barrierColor,
                                context: context,
                                builder: (context) {
                                  return WebViewAware(
                                    child: GestureDetector(
                                      onTap: () =>
                                          FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: AlertMessageWidget(
                                          buttonText: 'Aceptar',
                                          title:
                                              'Error: ${(_model.readedMemorandumsResp?.statusCode ?? 200).toString()}',
                                          message: MemorandumGroup
                                              .getMemorandumsCall
                                              .message(
                                            (_model.readedMemorandumsResp
                                                    ?.jsonBody ??
                                                ''),
                                          )!,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            }
                          }

                          _model.readedNotificationsResp =
                              await NotificationsGroup.getNotificationsCall
                                  .call(
                            token: currentAuthenticationToken,
                            perPage: _model.notificationsPerPage,
                            read: 'true',
                          );

                          shouldSetState = true;
                          if ((_model.readedNotificationsResp?.succeeded ??
                              true)) {
                            FFAppState().notificationsArray = NotificationsGroup
                                .getNotificationsCall
                                .rows(
                                  (_model.readedNotificationsResp?.jsonBody ??
                                      ''),
                                )!
                                .toList()
                                .cast<dynamic>();
                            safeSetState(() {});
                            _model.notificationsTotal = NotificationsGroup
                                .getNotificationsCall
                                .totalRows(
                              (_model.readedNotificationsResp?.jsonBody ?? ''),
                            );
                            safeSetState(() {});
                          } else {
                            if ((_model.readedNotificationsResp?.statusCode ??
                                    200) ==
                                401) {
                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signOut();
                              GoRouter.of(context).clearRedirectLocation();

                              navigate = () =>
                                  context.goNamedAuth('Login', context.mounted);

                              navigate();
                              if (shouldSetState) safeSetState(() {});
                              return;
                            } else {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                barrierColor:
                                    FlutterFlowTheme.of(context).barrierColor,
                                context: context,
                                builder: (context) {
                                  return WebViewAware(
                                    child: GestureDetector(
                                      onTap: () =>
                                          FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: AlertMessageWidget(
                                          buttonText: 'Aceptar',
                                          title:
                                              'Error: ${(_model.readedNotificationsResp?.statusCode ?? 200).toString()}',
                                          message: NotificationsGroup
                                              .getNotificationsCall
                                              .message(
                                                (_model.readedNotificationsResp
                                                        ?.jsonBody ??
                                                    ''),
                                              )
                                              .toString(),
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
                          if (shouldSetState) safeSetState(() {});
                        },
                      ),
                    ),
                  ),
                if ((_model.notificationsSwitchValue == 'read') &&
                    !_model.isLoading)
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
                        icon: FaIcon(
                          FontAwesomeIcons.eye,
                          color: FlutterFlowTheme.of(context).tertiary,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          var shouldSetState = false;
                          Function() navigate = () {};
                          _model.notificationsSwitchValue = 'unread';
                          _model.isLoading = true;
                          _model.memorandumsSwitchValue = 'UNVIEWED';
                          safeSetState(() {});
                          _model.unreadedMemorandumsResp =
                              await MemorandumGroup.getMemorandumsCall.call(
                            token: currentAuthenticationToken,
                            perPage: _model.memorandumsPerPage,
                            status: 'UNVIEWED',
                          );

                          shouldSetState = true;
                          if ((_model.unreadedMemorandumsResp?.succeeded ??
                              true)) {
                            FFAppState().memorandumsArray = MemorandumGroup
                                .getMemorandumsCall
                                .rows(
                                  (_model.unreadedMemorandumsResp?.jsonBody ??
                                      ''),
                                )!
                                .toList()
                                .cast<dynamic>();
                            safeSetState(() {});
                            _model.memorandumsTotal =
                                MemorandumGroup.getMemorandumsCall.totalRows(
                              (_model.unreadedMemorandumsResp?.jsonBody ?? ''),
                            );
                            safeSetState(() {});
                          } else {
                            if ((_model.unreadedMemorandumsResp?.statusCode ??
                                    200) ==
                                401) {
                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signOut();
                              GoRouter.of(context).clearRedirectLocation();

                              navigate = () =>
                                  context.goNamedAuth('Login', context.mounted);

                              navigate();
                              if (shouldSetState) safeSetState(() {});
                              return;
                            } else {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                barrierColor:
                                    FlutterFlowTheme.of(context).barrierColor,
                                context: context,
                                builder: (context) {
                                  return WebViewAware(
                                    child: GestureDetector(
                                      onTap: () =>
                                          FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: AlertMessageWidget(
                                          buttonText: 'Aceptar',
                                          title:
                                              'Error: ${(_model.unreadedMemorandumsResp?.statusCode ?? 200).toString()}',
                                          message: MemorandumGroup
                                              .getMemorandumsCall
                                              .message(
                                            (_model.unreadedMemorandumsResp
                                                    ?.jsonBody ??
                                                ''),
                                          )!,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            }
                          }

                          _model.unreadedNotificationsResp =
                              await NotificationsGroup.getNotificationsCall
                                  .call(
                            token: currentAuthenticationToken,
                            perPage: _model.notificationsPerPage,
                            read: 'false',
                          );

                          shouldSetState = true;
                          if ((_model.unreadedNotificationsResp?.succeeded ??
                              true)) {
                            FFAppState().notificationsArray = NotificationsGroup
                                .getNotificationsCall
                                .rows(
                                  (_model.unreadedNotificationsResp?.jsonBody ??
                                      ''),
                                )!
                                .toList()
                                .cast<dynamic>();
                            safeSetState(() {});
                            _model.notificationsTotal = NotificationsGroup
                                .getNotificationsCall
                                .totalRows(
                              (_model.unreadedNotificationsResp?.jsonBody ??
                                  ''),
                            );
                            safeSetState(() {});
                          } else {
                            if ((_model.unreadedNotificationsResp?.statusCode ??
                                    200) ==
                                401) {
                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signOut();
                              GoRouter.of(context).clearRedirectLocation();

                              navigate = () =>
                                  context.goNamedAuth('Login', context.mounted);

                              navigate();
                              if (shouldSetState) safeSetState(() {});
                              return;
                            } else {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                barrierColor:
                                    FlutterFlowTheme.of(context).barrierColor,
                                context: context,
                                builder: (context) {
                                  return WebViewAware(
                                    child: GestureDetector(
                                      onTap: () =>
                                          FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: AlertMessageWidget(
                                          buttonText: 'Aceptar',
                                          title:
                                              'Error: ${(_model.unreadedNotificationsResp?.statusCode ?? 200).toString()}',
                                          message: NotificationsGroup
                                              .getNotificationsCall
                                              .message(
                                                (_model.unreadedNotificationsResp
                                                        ?.jsonBody ??
                                                    ''),
                                              )
                                              .toString(),
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
                          if (shouldSetState) safeSetState(() {});
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
