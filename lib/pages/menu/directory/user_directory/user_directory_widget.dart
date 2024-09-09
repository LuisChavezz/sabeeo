import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/ui/alert_message/alert_message_widget.dart';
import '/components/users/users_directory_list/users_directory_list_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'user_directory_model.dart';
export 'user_directory_model.dart';

class UserDirectoryWidget extends StatefulWidget {
  const UserDirectoryWidget({super.key});

  @override
  State<UserDirectoryWidget> createState() => _UserDirectoryWidgetState();
}

class _UserDirectoryWidgetState extends State<UserDirectoryWidget> {
  late UserDirectoryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserDirectoryModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Function() navigate = () {};
      _model.isLoading = true;
      safeSetState(() {});
      _model.usersResp = await UsersGroup.directoryCall.call(
        token: currentAuthenticationToken,
        perPage: _model.usersPerPage,
      );

      if ((_model.usersResp?.succeeded ?? true)) {
        FFAppState().usersArray = UsersGroup.directoryCall
            .rows(
              (_model.usersResp?.jsonBody ?? ''),
            )!
            .toList()
            .cast<dynamic>();
        safeSetState(() {});
        _model.usersTotal = UsersGroup.directoryCall.totalRows(
          (_model.usersResp?.jsonBody ?? ''),
        );
        safeSetState(() {});
      } else {
        if ((_model.usersResp?.statusCode ?? 200) == 401) {
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
                          'Error: ${(_model.usersResp?.statusCode ?? 200).toString()}',
                      message: valueOrDefault<String>(
                        UsersGroup.directoryCall.message(
                          (_model.usersResp?.jsonBody ?? ''),
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
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
              onPressed: () async {
                context.pop();
              },
            ),
            title: Text(
              'Directorio',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Montserrat',
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
            actions: const [],
            centerTitle: false,
            elevation: 0.0,
          ),
          body: SafeArea(
            top: true,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 12.0, 24.0, 24.0),
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
                              _model.searchValue =
                                  _model.searchFieldTextController.text;
                              safeSetState(() {});
                              _model.searchUsersResp =
                                  await UsersGroup.directoryCall.call(
                                token: currentAuthenticationToken,
                                perPage: _model.usersPerPage,
                                searchValue:
                                    _model.searchFieldTextController.text,
                              );

                              shouldSetState = true;
                              if ((_model.searchUsersResp?.succeeded ?? true)) {
                                FFAppState().usersArray = UsersGroup
                                    .directoryCall
                                    .rows(
                                      (_model.searchUsersResp?.jsonBody ?? ''),
                                    )!
                                    .toList()
                                    .cast<dynamic>();
                                safeSetState(() {});
                                _model.usersTotal =
                                    UsersGroup.directoryCall.totalRows(
                                  (_model.searchUsersResp?.jsonBody ?? ''),
                                );
                                safeSetState(() {});
                              } else {
                                if ((_model.searchUsersResp?.statusCode ??
                                        200) ==
                                    401) {
                                  GoRouter.of(context).prepareAuthEvent();
                                  await authManager.signOut();
                                  GoRouter.of(context).clearRedirectLocation();

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
                                          onTap: () =>
                                              FocusScope.of(context).unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: AlertMessageWidget(
                                              buttonText: 'Aceptar',
                                              title:
                                                  'Error: ${(_model.searchUsersResp?.statusCode ?? 200).toString()}',
                                              message: UsersGroup.directoryCall
                                                  .message(
                                                (_model.searchUsersResp
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
                          if (_model.searchValue != null &&
                              _model.searchValue != '')
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                var shouldSetState = false;
                                Function() navigate = () {};
                                _model.isLoading = true;
                                _model.searchValue = null;
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
                                _model.clearSearchUsersResp =
                                    await UsersGroup.directoryCall.call(
                                  token: currentAuthenticationToken,
                                  perPage: _model.usersPerPage,
                                );

                                shouldSetState = true;
                                if ((_model.clearSearchUsersResp?.succeeded ??
                                    true)) {
                                  FFAppState().usersArray =
                                      UsersGroup.directoryCall
                                          .rows(
                                            (_model.clearSearchUsersResp
                                                    ?.jsonBody ??
                                                ''),
                                          )!
                                          .toList()
                                          .cast<dynamic>();
                                  safeSetState(() {});
                                  _model.usersTotal =
                                      UsersGroup.directoryCall.totalRows(
                                    (_model.clearSearchUsersResp?.jsonBody ??
                                        ''),
                                  );
                                  safeSetState(() {});
                                } else {
                                  if ((_model.clearSearchUsersResp
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
                                                    'Error: ${(_model.clearSearchUsersResp?.statusCode ?? 200).toString()}',
                                                message: UsersGroup
                                                    .directoryCall
                                                    .message(
                                                  (_model.clearSearchUsersResp
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
                          if (false)
                            Container(
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
                                    Icons.filter_list,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 36.0,
                                  ),
                                ],
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
                    if (!_model.isLoading)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 24.0),
                          child: wrapWithModel(
                            model: _model.usersDirectoryListModel,
                            updateCallback: () => safeSetState(() {}),
                            child: UsersDirectoryListWidget(
                              usersTotalRows: _model.usersTotal!,
                              searchValue: _model.searchValue != null &&
                                      _model.searchValue != ''
                                  ? _model.searchValue!
                                  : '',
                              usersArray: FFAppState().usersArray,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
