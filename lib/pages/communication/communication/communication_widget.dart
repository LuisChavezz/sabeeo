import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/communication/memorandum_list/memorandum_list_widget.dart';
import '/components/communication/notifications_list/notifications_list_widget.dart';
import '/components/ui/alert_message/alert_message_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
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
      setState(() {});
      _model.memorandumsResp = await MemorandumGroup.getMemorandumsCall.call(
        token: currentAuthenticationToken,
        perPage: _model.memorandumsPerPage,
      );

      if ((_model.memorandumsResp?.succeeded ?? true)) {
        FFAppState().memorandumsArray = MemorandumGroup.getMemorandumsCall
            .rows(
              (_model.memorandumsResp?.jsonBody ?? ''),
            )!
            .toList()
            .cast<dynamic>();
        setState(() {});
        _model.memorandumsTotal = MemorandumGroup.getMemorandumsCall.totalRows(
          (_model.memorandumsResp?.jsonBody ?? ''),
        );
        setState(() {});
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
              return GestureDetector(
                onTap: () => _model.unfocusNode.canRequestFocus
                    ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                    : FocusScope.of(context).unfocus(),
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
              );
            },
          ).then((value) => safeSetState(() {}));
        }
      }

      _model.notificationsResp =
          await NotificationsGroup.getNotificationsCall.call(
        token: currentAuthenticationToken,
        perPage: _model.notificationsPerPage,
      );

      if ((_model.notificationsResp?.succeeded ?? true)) {
        FFAppState().notificationsArray =
            NotificationsGroup.getNotificationsCall
                .rows(
                  (_model.notificationsResp?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
        setState(() {});
        _model.notificationsTotal =
            NotificationsGroup.getNotificationsCall.totalRows(
          (_model.notificationsResp?.jsonBody ?? ''),
        );
        setState(() {});
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
              return GestureDetector(
                onTap: () => _model.unfocusNode.canRequestFocus
                    ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                    : FocusScope.of(context).unfocus(),
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
              );
            },
          ).then((value) => safeSetState(() {}));
        }
      }

      _model.isLoading = false;
      setState(() {});

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
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: Column(
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
                            _model.switchValue = 'comun';
                            setState(() {});
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
                      ),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.switchValue = 'notis';
                            setState(() {});
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
                      ),
                    ].divide(const SizedBox(width: 16.0)),
                  ),
                ),
                if (_model.isLoading)
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                    child: Lottie.asset(
                      'assets/lottie_animations/Animation_-_1716841230423.json',
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      height: MediaQuery.sizeOf(context).height * 0.25,
                      fit: BoxFit.contain,
                      animate: true,
                    ),
                  ),
                if ((_model.switchValue == 'comun') && !_model.isLoading)
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                      child: wrapWithModel(
                        model: _model.memorandumListModel,
                        updateCallback: () => setState(() {}),
                        child: MemorandumListWidget(
                          memorandumsTotalRows: _model.memorandumsTotal!,
                          memorandumsArray: FFAppState().memorandumsArray,
                          toggleIsLoading: () async {
                            _model.isLoading = !_model.isLoading;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                if ((_model.switchValue == 'notis') && !_model.isLoading)
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                      child: wrapWithModel(
                        model: _model.notificationsListModel,
                        updateCallback: () => setState(() {}),
                        child: NotificationsListWidget(
                          notificationsTotalRows: _model.notificationsTotal!,
                          notificationsArray: FFAppState().notificationsArray,
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
      ),
    );
  }
}
