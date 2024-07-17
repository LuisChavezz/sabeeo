import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/ui/alert_message/alert_message_widget.dart';
import '/components/ui/empty_list/empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'kpis_list_model.dart';
export 'kpis_list_model.dart';

class KpisListWidget extends StatefulWidget {
  const KpisListWidget({
    super.key,
    required this.kpisArray,
    required this.kpisTotalRows,
    required this.toggleIsLoading,
  });

  final List<dynamic>? kpisArray;
  final int? kpisTotalRows;
  final Future Function()? toggleIsLoading;

  @override
  State<KpisListWidget> createState() => _KpisListWidgetState();
}

class _KpisListWidgetState extends State<KpisListWidget> {
  late KpisListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => KpisListModel());
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
        _model.refreshKpisResp = await KpiGroup.getKpisCall.call(
          token: currentAuthenticationToken,
          perPage: _model.moreKpisPerPage.toString(),
        );

        if ((_model.refreshKpisResp?.succeeded ?? true)) {
          FFAppState().kpisArray = KpiGroup.getKpisCall
              .rows(
                (_model.refreshKpisResp?.jsonBody ?? ''),
              )!
              .toList()
              .cast<dynamic>();
          _model.updatePage(() {});
        } else {
          if ((_model.refreshKpisResp?.statusCode ?? 200) == 401) {
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
                return Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: AlertMessageWidget(
                    buttonText: 'Aceptar',
                    title:
                        'Error: ${(_model.refreshKpisResp?.statusCode ?? 200).toString()}',
                    message: valueOrDefault<String>(
                      KpiGroup.getKpisCall
                          .message(
                            (_model.refreshKpisResp?.jsonBody ?? ''),
                          )
                          .toString(),
                      'Ocurrió un error con el servidor.',
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
                final kpisItem = widget.kpisArray!.toList();
                if (kpisItem.isEmpty) {
                  return const EmptyListWidget(
                    title: 'Sin KPIs',
                    text: 'No hay KPIs, intenta de nuevo más tarde.',
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: kpisItem.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16.0),
                  itemBuilder: (context, kpisItemIndex) {
                    final kpisItemItem = kpisItem[kpisItemIndex];
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        getJsonField(
                                          kpisItemItem,
                                          r'''$.name''',
                                        ).toString(),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                          kpisItemItem,
                                          r'''$.valuef''',
                                        ).toString(),
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ].divide(const SizedBox(width: 12.0)),
                                ),
                              ].divide(const SizedBox(height: 8.0)),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1.0, -1.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 12.0, 0.0),
                              child: Icon(
                                Icons.info_outline,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 20.0,
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
            if (FFAppState().kpisArray.length < widget.kpisTotalRows!)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    var shouldSetState = false;
                    Function() navigate = () {};
                    await widget.toggleIsLoading?.call();
                    _model.moreKpisPerPage = _model.moreKpisPerPage + 10;
                    setState(() {});
                    _model.moreKpisResp = await KpiGroup.getKpisCall.call(
                      token: currentAuthenticationToken,
                      perPage: _model.moreKpisPerPage.toString(),
                    );

                    shouldSetState = true;
                    if ((_model.moreKpisResp?.succeeded ?? true)) {
                      FFAppState().kpisArray = KpiGroup.getKpisCall
                          .rows(
                            (_model.moreKpisResp?.jsonBody ?? ''),
                          )!
                          .toList()
                          .cast<dynamic>();
                      _model.updatePage(() {});
                    } else {
                      if ((_model.moreKpisResp?.statusCode ?? 200) == 401) {
                        GoRouter.of(context).prepareAuthEvent();
                        await authManager.signOut();
                        GoRouter.of(context).clearRedirectLocation();

                        navigate =
                            () => context.goNamedAuth('Login', context.mounted);

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
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: AlertMessageWidget(
                                buttonText: 'Aceptar',
                                title:
                                    'Error: ${KpiGroup.getKpisCall.statusCode(
                                          (_model.moreKpisResp?.jsonBody ?? ''),
                                        )?.toString()}',
                                message: valueOrDefault<String>(
                                  KpiGroup.getKpisCall
                                      .message(
                                        (_model.moreKpisResp?.jsonBody ?? ''),
                                      )
                                      .toString(),
                                  'Ocurrió un error con el servidor.',
                                ),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      }
                    }

                    await widget.toggleIsLoading?.call();

                    navigate();
                    if (shouldSetState) setState(() {});
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
