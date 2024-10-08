import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/home/anomalies_list/anomalies_list_widget.dart';
import '/components/home/kpis_list/kpis_list_widget.dart';
import '/components/ui/alert_message/alert_message_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Function() navigate = () {};
      _model.isLoading = true;
      safeSetState(() {});
      _model.anomaliesResp = await AnomaliesGroup.getAnomaliesCall.call(
        token: currentAuthenticationToken,
        perPage: _model.anomaliesPerPage,
      );

      if ((_model.anomaliesResp?.succeeded ?? true)) {
        FFAppState().anomaliesArray = AnomaliesGroup.getAnomaliesCall
            .rows(
              (_model.anomaliesResp?.jsonBody ?? ''),
            )!
            .toList()
            .cast<dynamic>();
        safeSetState(() {});
        _model.anomaliesTotal = AnomaliesGroup.getAnomaliesCall.totalRows(
          (_model.anomaliesResp?.jsonBody ?? ''),
        );
        safeSetState(() {});
      } else {
        if ((_model.anomaliesResp?.statusCode ?? 200) == 401) {
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
                          'Error: ${(_model.anomaliesResp?.statusCode ?? 200).toString()}',
                      message: valueOrDefault<String>(
                        AnomaliesGroup.getAnomaliesCall.message(
                          (_model.anomaliesResp?.jsonBody ?? ''),
                        ),
                        'Ocurrió un error con el servidor.',
                      ),
                    ),
                  ),
                ),
              );
            },
          ).then((value) => safeSetState(() {}));
        }
      }

      _model.kpisResp = await KpiGroup.getKpisCall.call(
        token: currentAuthenticationToken,
        perPage: _model.kpisPerPage?.toString(),
      );

      if ((_model.kpisResp?.succeeded ?? true)) {
        FFAppState().kpisArray = KpiGroup.getKpisCall
            .rows(
              (_model.kpisResp?.jsonBody ?? ''),
            )!
            .toList()
            .cast<dynamic>();
        safeSetState(() {});
        _model.kpisTotal = KpiGroup.getKpisCall.totalRows(
          (_model.kpisResp?.jsonBody ?? ''),
        );
        safeSetState(() {});
      } else {
        if ((_model.kpisResp?.statusCode ?? 200) == 401) {
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
                          'Error: ${(_model.kpisResp?.statusCode ?? 200).toString()}',
                      message: valueOrDefault<String>(
                        KpiGroup.getKpisCall
                            .message(
                              (_model.kpisResp?.jsonBody ?? ''),
                            )
                            .toString(),
                        'Ocurrió un error con el servidor.',
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
                            _model.switchValue = 'anom';
                            safeSetState(() {});
                          },
                          text: 'Anomalías',
                          options: FFButtonOptions(
                            height: 48.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                6.0, 0.0, 6.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: _model.switchValue == 'anom'
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context)
                                    .primaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: _model.switchValue == 'anom'
                                      ? const Color(0xFF232323)
                                      : FlutterFlowTheme.of(context).primary,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                            elevation: 2.0,
                            borderSide: BorderSide(
                              color: _model.switchValue == 'anom'
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
                            _model.switchValue = 'kpi';
                            safeSetState(() {});
                          },
                          text: 'KPIs',
                          options: FFButtonOptions(
                            height: 48.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                6.0, 0.0, 6.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: _model.switchValue == 'kpi'
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context)
                                    .primaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: _model.switchValue == 'kpi'
                                      ? const Color(0xFF232323)
                                      : FlutterFlowTheme.of(context).primary,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                            elevation: 2.0,
                            borderSide: BorderSide(
                              color: _model.switchValue == 'kpi'
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
                      'assets/lottie_animations/loading_sabeeo.json',
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      height: MediaQuery.sizeOf(context).height * 0.25,
                      fit: BoxFit.contain,
                      animate: true,
                    ),
                  ),
                if ((_model.switchValue == 'anom') && !_model.isLoading)
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                      child: wrapWithModel(
                        model: _model.anomaliesListModel,
                        updateCallback: () => safeSetState(() {}),
                        child: AnomaliesListWidget(
                          anomaliesArray: FFAppState().anomaliesArray,
                          anomaliesTotalRows: _model.anomaliesTotal!,
                          toggleIsLoading: () async {
                            _model.isLoading = !_model.isLoading;
                            safeSetState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                if ((_model.switchValue == 'kpi') && !_model.isLoading)
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                      child: wrapWithModel(
                        model: _model.kpisListModel,
                        updateCallback: () => safeSetState(() {}),
                        child: KpisListWidget(
                          kpisTotalRows: _model.kpisTotal!,
                          kpisArray: FFAppState().kpisArray,
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
          ),
        ),
      ),
    );
  }
}
