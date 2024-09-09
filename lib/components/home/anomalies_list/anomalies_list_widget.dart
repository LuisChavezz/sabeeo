import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/home/anomaly_info/anomaly_info_widget.dart';
import '/components/ui/alert_message/alert_message_widget.dart';
import '/components/ui/empty_list/empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'anomalies_list_model.dart';
export 'anomalies_list_model.dart';

class AnomaliesListWidget extends StatefulWidget {
  const AnomaliesListWidget({
    super.key,
    required this.anomaliesArray,
    required this.anomaliesTotalRows,
    required this.toggleIsLoading,
  });

  final List<dynamic>? anomaliesArray;
  final int? anomaliesTotalRows;
  final Future Function()? toggleIsLoading;

  @override
  State<AnomaliesListWidget> createState() => _AnomaliesListWidgetState();
}

class _AnomaliesListWidgetState extends State<AnomaliesListWidget> {
  late AnomaliesListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnomaliesListModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return RefreshIndicator(
      color: FlutterFlowTheme.of(context).primary,
      onRefresh: () async {
        Function() navigate = () {};
        await widget.toggleIsLoading?.call();
        _model.refreshAnomaliesResp =
            await AnomaliesGroup.getAnomaliesCall.call(
          token: currentAuthenticationToken,
          perPage: _model.moreAnomaliesPerPage,
        );

        if ((_model.refreshAnomaliesResp?.succeeded ?? true)) {
          FFAppState().anomaliesArray = AnomaliesGroup.getAnomaliesCall
              .rows(
                (_model.refreshAnomaliesResp?.jsonBody ?? ''),
              )!
              .toList()
              .cast<dynamic>();
          _model.updatePage(() {});
        } else {
          if ((_model.refreshAnomaliesResp?.statusCode ?? 200) == 401) {
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
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: AlertMessageWidget(
                      buttonText: 'Aceptar',
                      title:
                          'Error: ${(_model.refreshAnomaliesResp?.statusCode ?? 200).toString()}',
                      message: valueOrDefault<String>(
                        AnomaliesGroup.getAnomaliesCall.message(
                          (_model.refreshAnomaliesResp?.jsonBody ?? ''),
                        ),
                        'Ocurrió un error con el servidor.',
                      ),
                    ),
                  ),
                );
              },
            ).then((value) => safeSetState(() {}));
          }
        }

        await widget.toggleIsLoading?.call();

        navigate();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Builder(
              builder: (context) {
                final anomaliesItem = widget.anomaliesArray!.toList();
                if (anomaliesItem.isEmpty) {
                  return const EmptyListWidget(
                    title: 'Sin Anomalías',
                    text: 'No hay anomalías, intenta de nuevo más tarde.',
                  );
                }

                return MasonryGridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  itemCount: anomaliesItem.length,
                  shrinkWrap: true,
                  itemBuilder: (context, anomaliesItemIndex) {
                    final anomaliesItemItem = anomaliesItem[anomaliesItemIndex];
                    return Container(
                      height: 170.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).info,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 20.0, 12.0, 20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      getJsonField(
                                        anomaliesItemItem,
                                        r'''$.issueValue''',
                                      ).toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: valueOrDefault<Color>(
                                              () {
                                                if (functions
                                                        .objectStringValueToString(
                                                            getJsonField(
                                                      anomaliesItemItem,
                                                      r'''$.category.name''',
                                                    ).toString()) ==
                                                    'Desarrollo') {
                                                  return const Color(0xFF5086DC);
                                                } else if (functions
                                                        .objectStringValueToString(
                                                            getJsonField(
                                                      anomaliesItemItem,
                                                      r'''$.category.name''',
                                                    ).toString()) ==
                                                    'Inventarios') {
                                                  return const Color(0xFF91A2E8);
                                                } else if (functions
                                                        .objectStringValueToString(
                                                            getJsonField(
                                                      anomaliesItemItem,
                                                      r'''$.category.name''',
                                                    ).toString()) ==
                                                    'Compras') {
                                                  return const Color(0xFF8A8A8A);
                                                } else if (functions
                                                        .objectStringValueToString(
                                                            getJsonField(
                                                      anomaliesItemItem,
                                                      r'''$.category.name''',
                                                    ).toString()) ==
                                                    'Cuentas por Cobrar') {
                                                  return const Color(0xFFA1A1A1);
                                                } else if (functions
                                                        .objectStringValueToString(
                                                            getJsonField(
                                                      anomaliesItemItem,
                                                      r'''$.category.name''',
                                                    ).toString()) ==
                                                    'RR.HH.') {
                                                  return const Color(0xFF3C47D7);
                                                } else if (functions
                                                        .objectStringValueToString(
                                                            getJsonField(
                                                      anomaliesItemItem,
                                                      r'''$.category.name''',
                                                    ).toString()) ==
                                                    'Direccion') {
                                                  return const Color(0xFF2660A4);
                                                } else {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .error;
                                                }
                                              }(),
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                            ),
                                            fontSize: 60.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: AutoSizeText(
                                        getJsonField(
                                          anomaliesItemItem,
                                          r'''$.issue''',
                                        ).toString(),
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ].divide(const SizedBox(width: 12.0)),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1.0, -1.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 12.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    barrierColor: FlutterFlowTheme.of(context)
                                        .barrierColor,
                                    context: context,
                                    builder: (context) {
                                      return WebViewAware(
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: AnomalyInfoWidget(
                                            ownerPositionName: getJsonField(
                                              anomaliesItemItem,
                                              r'''$.ownerPosition.name''',
                                            ).toString(),
                                            ownerPositionUserName:
                                                '${getJsonField(
                                              anomaliesItemItem,
                                              r'''$.ownerPosition.users[0].firstname''',
                                            ).toString()} ${getJsonField(
                                              anomaliesItemItem,
                                              r'''$.ownerPosition.users[0].lastname''',
                                            ).toString()}',
                                            categoryName: getJsonField(
                                              anomaliesItemItem,
                                              r'''$.category.name''',
                                            ).toString(),
                                            description: getJsonField(
                                              anomaliesItemItem,
                                              r'''$.body''',
                                            ).toString(),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                child: Icon(
                                  Icons.info_outline,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            if (FFAppState().anomaliesArray.length <
                widget.anomaliesTotalRows!)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    var shouldSetState = false;
                    Function() navigate = () {};
                    await widget.toggleIsLoading?.call();
                    _model.moreAnomaliesPerPage =
                        _model.moreAnomaliesPerPage + 10;
                    safeSetState(() {});
                    _model.moreAnomaliesResp =
                        await AnomaliesGroup.getAnomaliesCall.call(
                      token: currentAuthenticationToken,
                      perPage: _model.moreAnomaliesPerPage,
                    );

                    shouldSetState = true;
                    if ((_model.moreAnomaliesResp?.succeeded ?? true)) {
                      FFAppState().anomaliesArray =
                          AnomaliesGroup.getAnomaliesCall
                              .rows(
                                (_model.moreAnomaliesResp?.jsonBody ?? ''),
                              )!
                              .toList()
                              .cast<dynamic>();
                      _model.updatePage(() {});
                    } else {
                      if ((_model.moreAnomaliesResp?.statusCode ?? 200) ==
                          401) {
                        GoRouter.of(context).prepareAuthEvent();
                        await authManager.signOut();
                        GoRouter.of(context).clearRedirectLocation();

                        navigate =
                            () => context.goNamedAuth('Login', context.mounted);

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
                              child: Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: AlertMessageWidget(
                                  buttonText: 'Aceptar',
                                  title:
                                      'Error: ${(_model.moreAnomaliesResp?.statusCode ?? 200).toString()}',
                                  message: valueOrDefault<String>(
                                    AnomaliesGroup.getAnomaliesCall.message(
                                      (_model.moreAnomaliesResp?.jsonBody ??
                                          ''),
                                    ),
                                    'Ocurrió un error con el servidor.',
                                  ),
                                ),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      }
                    }

                    await widget.toggleIsLoading?.call();

                    navigate();
                    if (shouldSetState) safeSetState(() {});
                  },
                  text: 'Ver más',
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 48.0,
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
                    iconPadding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Montserrat',
                          color: const Color(0xFF232323),
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                    elevation: 2.0,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
