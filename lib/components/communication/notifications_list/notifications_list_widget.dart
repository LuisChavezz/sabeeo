import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/ui/confirm_action/confirm_action_widget.dart';
import '/components/ui/empty_list/empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifications_list_model.dart';
export 'notifications_list_model.dart';

class NotificationsListWidget extends StatefulWidget {
  const NotificationsListWidget({
    super.key,
    required this.notificationsArray,
    required this.notificationsTotalRows,
    required this.toggleIsLoading,
  });

  final List<dynamic>? notificationsArray;
  final int? notificationsTotalRows;
  final Future Function()? toggleIsLoading;

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
        } else {
          if ((_model.refreshNotificationsResp?.statusCode ?? 200) == 401) {
            GoRouter.of(context).prepareAuthEvent();
            await authManager.signOut();
            GoRouter.of(context).clearRedirectLocation();

            navigate = () => context.goNamedAuth('Login', context.mounted);

            navigate();
            return;
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
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          isDismissible: false,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.3,
                                child: ConfirmActionWidget(
                                  confirmButtonText: 'Marcar como leída',
                                  cancelButtonText: 'Cancelar',
                                  mainAction: () async {
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
                                      if ((_model.readNotiResp?.statusCode ??
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
                                      perPage: _model.moreNotificationsPerPage,
                                    );

                                    shouldSetState = true;
                                    if ((_model
                                            .readNotificationsResp?.succeeded ??
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
                                ),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));

                        setState(() {});
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24.0),
                            child: Image.network(
                              'https://media.licdn.com/dms/image/D560BAQHf1XTJ50sbtw/company-logo_200_200/0/1704916187819/menita_comercial_logo?e=1725494400&v=beta&t=bDiZ3v07npwy2eCL-SRZHvaeoH0f_w-XRfVLhYqClzM',
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
                    setState(() {});
                    _model.moreNotificationsResp =
                        await NotificationsGroup.getNotificationsCall.call(
                      token: currentAuthenticationToken,
                      perPage: _model.moreNotificationsPerPage,
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
                    } else {
                      if ((_model.moreNotificationsResp?.statusCode ?? 200) ==
                          401) {
                        GoRouter.of(context).prepareAuthEvent();
                        await authManager.signOut();
                        GoRouter.of(context).clearRedirectLocation();

                        navigate =
                            () => context.goNamedAuth('Login', context.mounted);

                        navigate();
                        if (shouldSetState) setState(() {});
                        return;
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
