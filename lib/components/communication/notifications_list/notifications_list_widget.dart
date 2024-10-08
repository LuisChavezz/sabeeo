import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/ui/alert_message/alert_message_widget.dart';
import '/components/ui/confirm_action/confirm_action_widget.dart';
import '/components/ui/empty_list/empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'notifications_list_model.dart';
export 'notifications_list_model.dart';

class NotificationsListWidget extends StatefulWidget {
  const NotificationsListWidget({
    super.key,
    required this.notificationsArray,
    required this.notificationsTotalRows,
    required this.toggleIsLoading,
    String? readValue,
    required this.setNotificationsTotal,
  }) : readValue = readValue ?? 'false';

  final List<dynamic>? notificationsArray;
  final int? notificationsTotalRows;
  final Future Function()? toggleIsLoading;
  final String readValue;
  final Future Function(int totalRows)? setNotificationsTotal;

  @override
  State<NotificationsListWidget> createState() =>
      _NotificationsListWidgetState();
}

class _NotificationsListWidgetState extends State<NotificationsListWidget> {
  late NotificationsListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationsListModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!((widget.readValue == _model.readCS) ||
          functions.stringIsNull(_model.readCS))) {
        _model.moreNotificationsPerPage = 10;
        safeSetState(() {});
      }
      _model.readCS = widget.readValue;
      safeSetState(() {});
    });
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
        _model.refreshNotificationsResp =
            await NotificationsGroup.getNotificationsCall.call(
          token: currentAuthenticationToken,
          perPage: _model.moreNotificationsPerPage,
          read: widget.readValue,
        );

        if ((_model.refreshNotificationsResp?.succeeded ?? true)) {
          FFAppState().notificationsArray =
              NotificationsGroup.getNotificationsCall
                  .rows(
                    (_model.refreshNotificationsResp?.jsonBody ?? ''),
                  )!
                  .toList()
                  .cast<dynamic>();
          _model.updatePage(() {});
          await widget.setNotificationsTotal?.call(
            NotificationsGroup.getNotificationsCall.totalRows(
              (_model.refreshNotificationsResp?.jsonBody ?? ''),
            )!,
          );
        } else {
          if ((_model.refreshNotificationsResp?.statusCode ?? 200) == 401) {
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
                          'Error: ${(_model.refreshNotificationsResp?.statusCode ?? 200).toString()}',
                      message: valueOrDefault<String>(
                        NotificationsGroup.getNotificationsCall
                            .message(
                              (_model.refreshNotificationsResp?.jsonBody ?? ''),
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
                final notificationsItem = widget.notificationsArray!.toList();
                if (notificationsItem.isEmpty) {
                  return const EmptyListWidget(
                    title: 'Sin Notificaciones',
                    text: 'No hay notificaciones, intenta de nuevo más tarde.',
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: notificationsItem.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16.0),
                  itemBuilder: (context, notificationsItemIndex) {
                    final notificationsItemItem =
                        notificationsItem[notificationsItemIndex];
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (!getJsonField(
                          notificationsItemItem,
                          r'''$.read''',
                        )) {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            barrierColor:
                                FlutterFlowTheme.of(context).barrierColor,
                            isDismissible: false,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return WebViewAware(
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: SizedBox(
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.3,
                                    child: ConfirmActionWidget(
                                      confirmButtonText: 'Marcar como leída',
                                      cancelButtonText: 'Cancelar',
                                      mainAction: (textValue) async {
                                        var shouldSetState = false;
                                        navigate() {}
                                        _model.readNotiResp =
                                            await NotificationsGroup
                                                .readNotificactionCall
                                                .call(
                                          token: currentAuthenticationToken,
                                          id: getJsonField(
                                            notificationsItemItem,
                                            r'''$.id''',
                                          ).toString(),
                                        );

                                        shouldSetState = true;
                                        if (!(_model.readNotiResp?.succeeded ??
                                            true)) {
                                          if ((_model.readNotiResp
                                                      ?.statusCode ??
                                                  200) ==
                                              401) {}
                                        }
                                        Navigator.pop(context);
                                        await widget.toggleIsLoading?.call();
                                        _model.readNotificationsResp =
                                            await NotificationsGroup
                                                .getNotificationsCall
                                                .call(
                                          token: currentAuthenticationToken,
                                          perPage:
                                              _model.moreNotificationsPerPage,
                                          read: 'false',
                                        );

                                        shouldSetState = true;
                                        if ((_model.readNotificationsResp
                                                ?.succeeded ??
                                            true)) {
                                          FFAppState().notificationsArray =
                                              NotificationsGroup
                                                  .getNotificationsCall
                                                  .rows(
                                                    (_model.readNotificationsResp
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!
                                                  .toList()
                                                  .cast<dynamic>();
                                          _model.updatePage(() {});
                                          await widget.setNotificationsTotal
                                              ?.call(
                                            NotificationsGroup
                                                .getNotificationsCall
                                                .totalRows(
                                              (_model.readNotificationsResp
                                                      ?.jsonBody ??
                                                  ''),
                                            )!,
                                          );
                                        } else {
                                          if ((_model.readNotificationsResp
                                                      ?.statusCode ??
                                                  200) ==
                                              401) {
                                            return;
                                          }
                                        }

                                        await widget.toggleIsLoading?.call();
                                      },
                                      setPageState: (intValue) async {},
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        }

                        safeSetState(() {});
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24.0),
                            child: Image.network(
                              'https://appmenita-test.s3.us-east-1.amazonaws.com/assets/logo-menita.jpeg',
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        getJsonField(
                                          notificationsItemItem,
                                          r'''$.subject''',
                                        ).toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        getJsonField(
                                          notificationsItemItem,
                                          r'''$.content''',
                                        ).toString(),
                                        textAlign: TextAlign.justify,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      getJsonField(
                                        notificationsItemItem,
                                        r'''$.createdAt''',
                                      ).toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ].divide(const SizedBox(width: 4.0)),
                                ),
                              ].divide(const SizedBox(height: 8.0)),
                            ),
                          ),
                        ].divide(const SizedBox(width: 16.0)),
                      ),
                    );
                  },
                );
              },
            ),
            if (FFAppState().notificationsArray.length <
                widget.notificationsTotalRows!)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    var shouldSetState = false;
                    Function() navigate = () {};
                    await widget.toggleIsLoading?.call();
                    _model.moreNotificationsPerPage =
                        _model.moreNotificationsPerPage! + 10;
                    safeSetState(() {});
                    _model.moreNotificationsResp =
                        await NotificationsGroup.getNotificationsCall.call(
                      token: currentAuthenticationToken,
                      perPage: _model.moreNotificationsPerPage,
                      read: widget.readValue,
                    );

                    shouldSetState = true;
                    if ((_model.moreNotificationsResp?.succeeded ?? true)) {
                      FFAppState().notificationsArray =
                          NotificationsGroup.getNotificationsCall
                              .rows(
                                (_model.moreNotificationsResp?.jsonBody ?? ''),
                              )!
                              .toList()
                              .cast<dynamic>();
                      _model.updatePage(() {});
                      await widget.setNotificationsTotal?.call(
                        NotificationsGroup.getNotificationsCall.totalRows(
                          (_model.moreNotificationsResp?.jsonBody ?? ''),
                        )!,
                      );
                    } else {
                      if ((_model.moreNotificationsResp?.statusCode ?? 200) ==
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
                                      'Error: ${(_model.moreNotificationsResp?.statusCode ?? 200).toString()}',
                                  message: valueOrDefault<String>(
                                    NotificationsGroup.getNotificationsCall
                                        .message(
                                          (_model.moreNotificationsResp
                                                  ?.jsonBody ??
                                              ''),
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
