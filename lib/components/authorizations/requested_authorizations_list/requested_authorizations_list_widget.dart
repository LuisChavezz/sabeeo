import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/ui/alert_message/alert_message_widget.dart';
import '/components/ui/empty_list/empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'requested_authorizations_list_model.dart';
export 'requested_authorizations_list_model.dart';

class RequestedAuthorizationsListWidget extends StatefulWidget {
  const RequestedAuthorizationsListWidget({
    super.key,
    required this.authorizationsArray,
    required this.authorizationsTotalRows,
    required this.toggleIsLoading,
    required this.searchValue,
  });

  final List<dynamic>? authorizationsArray;
  final int? authorizationsTotalRows;
  final Future Function()? toggleIsLoading;
  final String? searchValue;

  @override
  State<RequestedAuthorizationsListWidget> createState() =>
      _RequestedAuthorizationsListWidgetState();
}

class _RequestedAuthorizationsListWidgetState
    extends State<RequestedAuthorizationsListWidget> {
  late RequestedAuthorizationsListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RequestedAuthorizationsListModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.moreAuthorizationsPerPage = 10;
      setState(() {});
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
        _model.refreshReqAuthsResp =
            await AuthorizationsGroup.getRequestedAuthsCall.call(
          token: currentAuthenticationToken,
          perPage: _model.moreAuthorizationsPerPage,
          searchValue: widget.searchValue,
          emitterId: currentUserUid,
        );

        if ((_model.refreshReqAuthsResp?.succeeded ?? true)) {
          FFAppState().reqAuthorizationsArray =
              AuthorizationsGroup.getRequestedAuthsCall
                  .rows(
                    (_model.refreshReqAuthsResp?.jsonBody ?? ''),
                  )!
                  .toList()
                  .cast<dynamic>();
          _model.updatePage(() {});
        } else {
          if ((_model.refreshReqAuthsResp?.statusCode ?? 200) == 401) {
            if (FFAppState().rememberMe) {
              _model.refreshTokenResp1 =
                  await AuthenticateGroup.refreshTokenCall.call(
                token: currentAuthenticationToken,
              );

              if ((_model.refreshTokenResp1?.succeeded ?? true)) {
                authManager.updateAuthUserData(
                  authenticationToken: AuthenticateGroup.refreshTokenCall.token(
                    (_model.refreshTokenResp1?.jsonBody ?? ''),
                  ),
                );

                setState(() {});
              } else {
                GoRouter.of(context).prepareAuthEvent();
                await authManager.signOut();
                GoRouter.of(context).clearRedirectLocation();

                navigate = () => context.goNamedAuth('Login', context.mounted);
              }
            } else {
              GoRouter.of(context).prepareAuthEvent();
              await authManager.signOut();
              GoRouter.of(context).clearRedirectLocation();

              navigate = () => context.goNamedAuth('Login', context.mounted);
            }

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
                          'Error: ${(_model.refreshReqAuthsResp?.statusCode ?? 200).toString()}',
                      message: valueOrDefault<String>(
                        AuthorizationsGroup.getRequestedAuthsCall
                            .message(
                              (_model.refreshReqAuthsResp?.jsonBody ?? ''),
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
                final authorizationsItem =
                    widget.authorizationsArray!.toList();
                if (authorizationsItem.isEmpty) {
                  return const EmptyListWidget(
                    title: 'Sin Autorizaciones',
                    text: 'No hay autorizaciones, intenta de nuevo más tarde.',
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: authorizationsItem.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16.0),
                  itemBuilder: (context, authorizationsItemIndex) {
                    final authorizationsItemItem =
                        authorizationsItem[authorizationsItemIndex];
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(
                          'Authorization_details',
                          queryParameters: {
                            'authorizationId': serializeParam(
                              getJsonField(
                                authorizationsItemItem,
                                r'''$.id''',
                              ).toString(),
                              ParamType.String,
                            ),
                          }.withoutNulls,
                        );
                      },
                      child: Container(
                        height: 130.0,
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
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.03,
                              height: MediaQuery.sizeOf(context).height * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).pendant,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(16.0),
                                  topRight: Radius.circular(0.0),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            getJsonField(
                                              authorizationsItemItem,
                                              r'''$.subject''',
                                            ).toString(),
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              child: Image.network(
                                                valueOrDefault<String>(
                                                  getJsonField(
                                                    authorizationsItemItem,
                                                    r'''$.emitter_profile_picture''',
                                                  )?.toString(),
                                                  'https://res.cloudinary.com/dshn8thfr/image/upload/v1694029660/blank-profile-picture-973460_1920_lc1bnn.png',
                                                ),
                                                width: 35.0,
                                                height: 35.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              'Solicitante',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                            ),
                                          ].divide(const SizedBox(width: 6.0)),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              child: Image.network(
                                                valueOrDefault<String>(
                                                  getJsonField(
                                                    authorizationsItemItem,
                                                    r'''$.originalAuthorizer_profile_picture''',
                                                  )?.toString(),
                                                  'https://res.cloudinary.com/dshn8thfr/image/upload/v1694029660/blank-profile-picture-973460_1920_lc1bnn.png',
                                                ),
                                                width: 35.0,
                                                height: 35.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              'Autorizador',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                            ),
                                          ].divide(const SizedBox(width: 6.0)),
                                        ),
                                      ].divide(const SizedBox(width: 16.0)),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 20.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 2.0, 0.0, 0.0),
                                          child: Text(
                                            getJsonField(
                                              authorizationsItemItem,
                                              r'''$.createdAt''',
                                            ).toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          ),
                                        ),
                                      ].divide(const SizedBox(width: 6.0)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            if (FFAppState().reqAuthorizationsArray.length <
                widget.authorizationsTotalRows!)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    var shouldSetState = false;
                    Function() navigate = () {};
                    await widget.toggleIsLoading?.call();
                    _model.moreAuthorizationsPerPage =
                        _model.moreAuthorizationsPerPage + 10;
                    setState(() {});
                    _model.moreAuthorizationsResp =
                        await AuthorizationsGroup.getRequestedAuthsCall.call(
                      token: currentAuthenticationToken,
                      perPage: _model.moreAuthorizationsPerPage,
                      searchValue: widget.searchValue,
                      emitterId: currentUserUid,
                    );

                    shouldSetState = true;
                    if ((_model.moreAuthorizationsResp?.succeeded ?? true)) {
                      FFAppState().reqAuthorizationsArray =
                          AuthorizationsGroup.getRequestedAuthsCall
                              .rows(
                                (_model.moreAuthorizationsResp?.jsonBody ?? ''),
                              )!
                              .toList()
                              .cast<dynamic>();
                      _model.updatePage(() {});
                    } else {
                      if ((_model.moreAuthorizationsResp?.statusCode ?? 200) ==
                          401) {
                        if (FFAppState().rememberMe) {
                          _model.refreshTokenResp2 =
                              await AuthenticateGroup.refreshTokenCall.call(
                            token: currentAuthenticationToken,
                          );

                          shouldSetState = true;
                          if ((_model.refreshTokenResp2?.succeeded ?? true)) {
                            authManager.updateAuthUserData(
                              authenticationToken:
                                  AuthenticateGroup.refreshTokenCall.token(
                                (_model.refreshTokenResp2?.jsonBody ?? ''),
                              ),
                            );

                            setState(() {});
                          } else {
                            GoRouter.of(context).prepareAuthEvent();
                            await authManager.signOut();
                            GoRouter.of(context).clearRedirectLocation();

                            navigate = () =>
                                context.goNamedAuth('Login', context.mounted);
                          }
                        } else {
                          GoRouter.of(context).prepareAuthEvent();
                          await authManager.signOut();
                          GoRouter.of(context).clearRedirectLocation();

                          navigate = () =>
                              context.goNamedAuth('Login', context.mounted);
                        }

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
                            return WebViewAware(
                              child: Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: AlertMessageWidget(
                                  buttonText: 'Aceptar',
                                  title:
                                      'Error: ${(_model.moreAuthorizationsResp?.statusCode ?? 200).toString()}',
                                  message: valueOrDefault<String>(
                                    AuthorizationsGroup.getRequestedAuthsCall
                                        .message(
                                          (_model.moreAuthorizationsResp
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
