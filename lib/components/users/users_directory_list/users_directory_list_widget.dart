import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/ui/alert_message/alert_message_widget.dart';
import '/components/ui/empty_list/empty_list_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'users_directory_list_model.dart';
export 'users_directory_list_model.dart';

class UsersDirectoryListWidget extends StatefulWidget {
  const UsersDirectoryListWidget({
    super.key,
    required this.usersArray,
    required this.usersTotalRows,
    required this.toggleIsLoading,
    String? searchValue,
  }) : searchValue = searchValue ?? 'aep';

  final List<dynamic>? usersArray;
  final int? usersTotalRows;
  final Future Function()? toggleIsLoading;
  final String searchValue;

  @override
  State<UsersDirectoryListWidget> createState() =>
      _UsersDirectoryListWidgetState();
}

class _UsersDirectoryListWidgetState extends State<UsersDirectoryListWidget> {
  late UsersDirectoryListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UsersDirectoryListModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!((widget.searchValue == _model.searchValueCS) ||
          functions.stringIsNull(_model.searchValueCS))) {
        _model.moreUsersPerPage = 10;
        safeSetState(() {});
      }
      _model.searchValueCS = widget.searchValue;
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
        _model.refreshUsersResp = await UsersGroup.directoryCall.call(
          token: currentAuthenticationToken,
          perPage: _model.moreUsersPerPage,
          searchValue: widget.searchValue,
        );

        if ((_model.refreshUsersResp?.succeeded ?? true)) {
          FFAppState().usersArray = UsersGroup.directoryCall
              .rows(
                (_model.refreshUsersResp?.jsonBody ?? ''),
              )!
              .toList()
              .cast<dynamic>();
          _model.updatePage(() {});
        } else {
          if ((_model.refreshUsersResp?.statusCode ?? 200) == 401) {
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
                          'Error: ${(_model.refreshUsersResp?.statusCode ?? 200).toString()}',
                      message: valueOrDefault<String>(
                        UsersGroup.directoryCall.message(
                          (_model.refreshUsersResp?.jsonBody ?? ''),
                        ),
                        'Ocurrió un erro en el servidor',
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
                final userItem = widget.usersArray!.toList();
                if (userItem.isEmpty) {
                  return const EmptyListWidget(
                    title: 'Sin Usuarios',
                    text:
                        'No hay usuarios en el directorio, intenta de nuevo más tarde.',
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: userItem.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16.0),
                  itemBuilder: (context, userItemIndex) {
                    final userItemItem = userItem[userItemIndex];
                    return Container(
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
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 70.0,
                                  height: 70.0,
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            child: FlutterFlowExpandedImageView(
                                              image: Image.network(
                                                valueOrDefault<String>(
                                                  functions.isImagePath(
                                                          getJsonField(
                                                    userItemItem,
                                                    r'''$.profile_picture''',
                                                  ).toString())
                                                      ? getJsonField(
                                                          userItemItem,
                                                          r'''$.profile_picture''',
                                                        ).toString()
                                                      : 'https://res.cloudinary.com/dshn8thfr/image/upload/v1694029660/blank-profile-picture-973460_1920_lc1bnn.png',
                                                  'https://res.cloudinary.com/dshn8thfr/image/upload/v1694029660/blank-profile-picture-973460_1920_lc1bnn.png',
                                                ),
                                                fit: BoxFit.contain,
                                              ),
                                              allowRotation: false,
                                              tag: valueOrDefault<String>(
                                                functions.isImagePath(
                                                        getJsonField(
                                                  userItemItem,
                                                  r'''$.profile_picture''',
                                                ).toString())
                                                    ? getJsonField(
                                                        userItemItem,
                                                        r'''$.profile_picture''',
                                                      ).toString()
                                                    : 'https://res.cloudinary.com/dshn8thfr/image/upload/v1694029660/blank-profile-picture-973460_1920_lc1bnn.png',
                                                'https://res.cloudinary.com/dshn8thfr/image/upload/v1694029660/blank-profile-picture-973460_1920_lc1bnn.png' '$userItemIndex',
                                              ),
                                              useHeroAnimation: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: valueOrDefault<String>(
                                          functions.isImagePath(getJsonField(
                                            userItemItem,
                                            r'''$.profile_picture''',
                                          ).toString())
                                              ? getJsonField(
                                                  userItemItem,
                                                  r'''$.profile_picture''',
                                                ).toString()
                                              : 'https://res.cloudinary.com/dshn8thfr/image/upload/v1694029660/blank-profile-picture-973460_1920_lc1bnn.png',
                                          'https://res.cloudinary.com/dshn8thfr/image/upload/v1694029660/blank-profile-picture-973460_1920_lc1bnn.png' '$userItemIndex',
                                        ),
                                        transitionOnUserGestures: true,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            valueOrDefault<String>(
                                              functions
                                                      .isImagePath(getJsonField(
                                                userItemItem,
                                                r'''$.profile_picture''',
                                              ).toString())
                                                  ? getJsonField(
                                                      userItemItem,
                                                      r'''$.profile_picture''',
                                                    ).toString()
                                                  : 'https://res.cloudinary.com/dshn8thfr/image/upload/v1694029660/blank-profile-picture-973460_1920_lc1bnn.png',
                                              'https://res.cloudinary.com/dshn8thfr/image/upload/v1694029660/blank-profile-picture-973460_1920_lc1bnn.png',
                                            ),
                                            width: 100.0,
                                            height: 100.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${getJsonField(
                                                  userItemItem,
                                                  r'''$.firstname''',
                                                ).toString()} ${getJsonField(
                                                  userItemItem,
                                                  r'''$.lastname''',
                                                ).toString()}',
                                                maxLines: 2,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 4.0, 0.0, 0.0),
                                          child: Text(
                                            getJsonField(
                                              userItemItem,
                                              r'''$.position.name''',
                                            ).toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 4.0, 0.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await launchUrl(Uri(
                                                scheme: 'tel',
                                                path: '+52${getJsonField(
                                                  userItemItem,
                                                  r'''$.phone''',
                                                ).toString()}',
                                              ));
                                            },
                                            child: Text(
                                              '+52 ${getJsonField(
                                                userItemItem,
                                                r'''$.phone''',
                                              ).toString()}',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            if (FFAppState().usersArray.length < widget.usersTotalRows!)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    var shouldSetState = false;
                    Function() navigate = () {};
                    await widget.toggleIsLoading?.call();
                    _model.moreUsersPerPage = _model.moreUsersPerPage + 10;
                    safeSetState(() {});
                    _model.moreUsersResp = await UsersGroup.directoryCall.call(
                      token: currentAuthenticationToken,
                      perPage: _model.moreUsersPerPage,
                      searchValue: widget.searchValue,
                    );

                    shouldSetState = true;
                    if ((_model.moreUsersResp?.succeeded ?? true)) {
                      FFAppState().usersArray = UsersGroup.directoryCall
                          .rows(
                            (_model.moreUsersResp?.jsonBody ?? ''),
                          )!
                          .toList()
                          .cast<dynamic>();
                      _model.updatePage(() {});
                    } else {
                      if ((_model.moreUsersResp?.statusCode ?? 200) == 401) {
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
                                      (_model.moreUsersResp?.statusCode ?? 200)
                                          .toString(),
                                  message: valueOrDefault<String>(
                                    UsersGroup.directoryCall.message(
                                      (_model.moreUsersResp?.jsonBody ?? ''),
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
