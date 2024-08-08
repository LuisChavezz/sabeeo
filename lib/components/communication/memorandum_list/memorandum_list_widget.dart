import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/ui/alert_message/alert_message_widget.dart';
import '/components/ui/empty_list/empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'memorandum_list_model.dart';
export 'memorandum_list_model.dart';

class MemorandumListWidget extends StatefulWidget {
  const MemorandumListWidget({
    super.key,
    required this.memorandumsArray,
    required this.memorandumsTotalRows,
    required this.toggleIsLoading,
  });

  final List<dynamic>? memorandumsArray;
  final int? memorandumsTotalRows;
  final Future Function()? toggleIsLoading;

  @override
  State<MemorandumListWidget> createState() => _MemorandumListWidgetState();
}

class _MemorandumListWidgetState extends State<MemorandumListWidget> {
  late MemorandumListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MemorandumListModel());
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
        _model.refreshMemorandumsResp =
            await MemorandumGroup.getMemorandumsCall.call(
          token: currentAuthenticationToken,
          perPage: _model.moreMemorandumsPerPage,
        );

        if ((_model.refreshMemorandumsResp?.succeeded ?? true)) {
          FFAppState().memorandumsArray = MemorandumGroup.getMemorandumsCall
              .rows(
                (_model.refreshMemorandumsResp?.jsonBody ?? ''),
              )!
              .toList()
              .cast<dynamic>();
          _model.updatePage(() {});
        } else {
          if ((_model.refreshMemorandumsResp?.statusCode ?? 200) == 401) {
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
                          'Error: ${(_model.refreshMemorandumsResp?.statusCode ?? 200).toString()}',
                      message: valueOrDefault<String>(
                        MemorandumGroup.getMemorandumsCall.message(
                          (_model.refreshMemorandumsResp?.jsonBody ?? ''),
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
                final memorandumsItem = widget.memorandumsArray!.toList();
                if (memorandumsItem.isEmpty) {
                  return const EmptyListWidget(
                    title: 'Sin Memorandums',
                    text: 'No hay memorandums, intenta de nuevo más tarde.',
                  );
                }

                return MasonryGridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: () {
                      if (MediaQuery.sizeOf(context).width <= 480.0) {
                        return 2;
                      } else if (MediaQuery.sizeOf(context).width <= 840.0) {
                        return 3;
                      } else if (MediaQuery.sizeOf(context).width <= 1280.0) {
                        return 4;
                      } else {
                        return 5;
                      }
                    }(),
                  ),
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  itemCount: memorandumsItem.length,
                  shrinkWrap: true,
                  itemBuilder: (context, memorandumsItemIndex) {
                    final memorandumsItemItem =
                        memorandumsItem[memorandumsItemIndex];
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(
                          'Memorandum',
                          queryParameters: {
                            'id': serializeParam(
                              getJsonField(
                                memorandumsItemItem,
                                r'''$.id''',
                              ).toString(),
                              ParamType.String,
                            ),
                            'status': serializeParam(
                              getJsonField(
                                memorandumsItemItem,
                                r'''$.status''',
                              ).toString(),
                              ParamType.String,
                            ),
                            'imageUrl': serializeParam(
                              getJsonField(
                                memorandumsItemItem,
                                r'''$.url''',
                              ).toString(),
                              ParamType.String,
                            ),
                            'perPage': serializeParam(
                              _model.moreMemorandumsPerPage,
                              ParamType.int,
                            ),
                            'isImagePath': serializeParam(
                              functions.isImagePath(getJsonField(
                                memorandumsItemItem,
                                r'''$.url''',
                              ).toString()),
                              ParamType.bool,
                            ),
                          }.withoutNulls,
                        );
                      },
                      child: Container(
                        height: 170.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(
                              valueOrDefault<String>(
                                functions.isImagePath(getJsonField(
                                  memorandumsItemItem,
                                  r'''$.url''',
                                ).toString())
                                    ? getJsonField(
                                        memorandumsItemItem,
                                        r'''$.url''',
                                      ).toString()
                                    : 'https://res.cloudinary.com/dshn8thfr/image/upload/v1722968542/placeholder_rmzce5.png',
                                'https://res.cloudinary.com/dshn8thfr/image/upload/v1722968542/placeholder_rmzce5.png',
                              ),
                            ).image,
                          ),
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
                      ),
                    );
                  },
                );
              },
            ),
            if (FFAppState().memorandumsArray.length <
                widget.memorandumsTotalRows!)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    var shouldSetState = false;
                    Function() navigate = () {};
                    await widget.toggleIsLoading?.call();
                    _model.moreMemorandumsPerPage =
                        _model.moreMemorandumsPerPage + 10;
                    setState(() {});
                    _model.moreMemorandumResp =
                        await MemorandumGroup.getMemorandumsCall.call(
                      token: currentAuthenticationToken,
                      perPage: _model.moreMemorandumsPerPage,
                    );

                    shouldSetState = true;
                    if ((_model.moreMemorandumResp?.succeeded ?? true)) {
                      FFAppState().memorandumsArray =
                          MemorandumGroup.getMemorandumsCall
                              .rows(
                                (_model.moreMemorandumResp?.jsonBody ?? ''),
                              )!
                              .toList()
                              .cast<dynamic>();
                      _model.updatePage(() {});
                    } else {
                      if ((_model.moreMemorandumResp?.statusCode ?? 200) ==
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
                                      'Error: ${(_model.moreMemorandumResp?.statusCode ?? 200).toString()}',
                                  message: valueOrDefault<String>(
                                    MemorandumGroup.getMemorandumsCall.message(
                                      (_model.moreMemorandumResp?.jsonBody ??
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
