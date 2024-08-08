import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/authorizations/authorization_pdf_list/authorization_pdf_list_widget.dart';
import '/components/ui/alert_message/alert_message_widget.dart';
import '/components/ui/confirm_action/confirm_action_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'authorization_details_model.dart';
export 'authorization_details_model.dart';

class AuthorizationDetailsWidget extends StatefulWidget {
  const AuthorizationDetailsWidget({
    super.key,
    required this.authorizationId,
  });

  final String? authorizationId;

  @override
  State<AuthorizationDetailsWidget> createState() =>
      _AuthorizationDetailsWidgetState();
}

class _AuthorizationDetailsWidgetState
    extends State<AuthorizationDetailsWidget> {
  late AuthorizationDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AuthorizationDetailsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.isLoading = true;
      setState(() {});
      _model.authorizationResp =
          await AuthorizationsGroup.authorizationDetailsCall.call(
        token: currentAuthenticationToken,
        id: widget.authorizationId,
      );

      if ((_model.authorizationResp?.succeeded ?? true)) {
        _model.authorizationStatusValue =
            AuthorizationsGroup.authorizationDetailsCall.statusValue(
          (_model.authorizationResp?.jsonBody ?? ''),
        );
        _model.authorizationStatusLabel =
            AuthorizationsGroup.authorizationDetailsCall.statusLabel(
          (_model.authorizationResp?.jsonBody ?? ''),
        );
        setState(() {});
      } else {
        if ((_model.authorizationResp?.statusCode ?? 200) == 401) {
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
            }
          } else {
            GoRouter.of(context).prepareAuthEvent();
            await authManager.signOut();
            GoRouter.of(context).clearRedirectLocation();
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
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: AlertMessageWidget(
                      buttonText: 'Aceptar',
                      title:
                          'Error: ${(_model.authorizationResp?.statusCode ?? 200).toString()}',
                      message: valueOrDefault<String>(
                        AuthorizationsGroup.authorizationDetailsCall.message(
                          (_model.authorizationResp?.jsonBody ?? ''),
                        ),
                        'Ocurrió un error en el servidor.',
                      ),
                    ),
                  ),
                ),
              );
            },
          ).then((value) => safeSetState(() {}));

          context.safePop();
          return;
        }
      }

      _model.isLoading = false;
      setState(() {});
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
                if (_model.wasUpdated) {
                  context.goNamed('Authorizations');
                } else {
                  context.safePop();
                }
              },
            ),
            title: Visibility(
              visible: !_model.isLoading,
              child: Text(
                valueOrDefault<String>(
                  AuthorizationsGroup.authorizationDetailsCall
                      .id(
                        (_model.authorizationResp?.jsonBody ?? ''),
                      )
                      ?.toString(),
                  'Detalles de la Autorización',
                ),
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
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
                    if (_model.isLoading)
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 24.0),
                          child: Lottie.asset(
                            'assets/lottie_animations/Animation_-_1716841230423.json',
                            width: MediaQuery.sizeOf(context).width * 0.5,
                            height: MediaQuery.sizeOf(context).height * 0.25,
                            fit: BoxFit.contain,
                            animate: true,
                          ),
                        ),
                      ),
                    if (!_model.isLoading)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 8.0, 24.0, 24.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 8.0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          AuthorizationsGroup
                                              .authorizationDetailsCall
                                              .subject(
                                            (_model.authorizationResp
                                                    ?.jsonBody ??
                                                ''),
                                          ),
                                          'Detalles de la Autorización',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                          AuthorizationsGroup
                                              .authorizationDetailsCall
                                              .emitterProfilePic(
                                            (_model.authorizationResp
                                                    ?.jsonBody ??
                                                ''),
                                          )!,
                                          width: 35.0,
                                          height: 35.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Solicitante',
                                        style: FlutterFlowTheme.of(context)
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
                                          AuthorizationsGroup
                                              .authorizationDetailsCall
                                              .authorizerProfilePic(
                                            (_model.authorizationResp
                                                    ?.jsonBody ??
                                                ''),
                                          )!,
                                          width: 35.0,
                                          height: 35.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Autorizador',
                                        style: FlutterFlowTheme.of(context)
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
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 4.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
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
                                            valueOrDefault<String>(
                                              AuthorizationsGroup
                                                  .authorizationDetailsCall
                                                  .date(
                                                (_model.authorizationResp
                                                        ?.jsonBody ??
                                                    ''),
                                              ),
                                              '(sin fecha)',
                                            ),
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
                                    Container(
                                      decoration: BoxDecoration(
                                        color: () {
                                          if (_model.authorizationStatusValue ==
                                              'pendant') {
                                            return FlutterFlowTheme.of(context)
                                                .pendant;
                                          } else if (_model
                                                  .authorizationStatusValue ==
                                              'approved') {
                                            return FlutterFlowTheme.of(context)
                                                .approved;
                                          } else if (_model
                                                  .authorizationStatusValue ==
                                              'rejected') {
                                            return FlutterFlowTheme.of(context)
                                                .rejected;
                                          } else {
                                            return const Color(0x00000000);
                                          }
                                        }(),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 4.0, 16.0, 4.0),
                                            child: Text(
                                              functions.toCapitalize(_model
                                                  .authorizationStatusLabel!),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 24.0, 0.0, 0.0),
                                child: Html(
                                  data: AuthorizationsGroup
                                      .authorizationDetailsCall
                                      .body(
                                    (_model.authorizationResp?.jsonBody ?? ''),
                                  )!,
                                  onLinkTap: (url, _, __) => launchURL(url!),
                                ),
                              ),
                              if (AuthorizationsGroup.authorizationDetailsCall
                                          .pdfResource(
                                        (_model.authorizationResp?.jsonBody ??
                                            ''),
                                      ) !=
                                      null &&
                                  (AuthorizationsGroup.authorizationDetailsCall
                                          .pdfResource(
                                    (_model.authorizationResp?.jsonBody ?? ''),
                                  ))!
                                      .isNotEmpty)
                                wrapWithModel(
                                  model: _model.authorizationPdfListModel,
                                  updateCallback: () => setState(() {}),
                                  child: AuthorizationPdfListWidget(
                                    pdfArray: AuthorizationsGroup
                                        .authorizationDetailsCall
                                        .pdfResource(
                                      (_model.authorizationResp?.jsonBody ??
                                          ''),
                                    )!,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                if (!_model.isLoading &&
                    (_model.authorizationStatusValue == 'pendant') &&
                    AuthorizationsGroup.authorizationDetailsCall.isAuthorizer(
                      (_model.authorizationResp?.jsonBody ?? ''),
                    )!)
                  Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  barrierColor:
                                      FlutterFlowTheme.of(context).barrierColor,
                                  context: context,
                                  builder: (context) {
                                    return WebViewAware(
                                      child: GestureDetector(
                                        onTap: () =>
                                            FocusScope.of(context).unfocus(),
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: SizedBox(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.3,
                                            child: ConfirmActionWidget(
                                              confirmButtonText: 'Rechazar',
                                              cancelButtonText: 'Cancelar',
                                              mainAction: () async {
                                                var shouldSetState = false;
                                                navigate() {}
                                                _model.isLoading = true;
                                                setState(() {});
                                                _model.rejectedAuthoResp =
                                                    await AuthorizationsGroup
                                                        .responseAuthorizationCall
                                                        .call(
                                                  token:
                                                      currentAuthenticationToken,
                                                  id: widget.authorizationId,
                                                  status: 'rejected',
                                                );

                                                shouldSetState = true;
                                                if ((_model.rejectedAuthoResp
                                                        ?.succeeded ??
                                                    true)) {
                                                  _model.authorizationStatusValue =
                                                      'rejected';
                                                  _model.authorizationStatusLabel =
                                                      'rechazada';
                                                  setState(() {});
                                                } else {
                                                  if ((_model.rejectedAuthoResp
                                                              ?.statusCode ??
                                                          200) ==
                                                      401) {
                                                    if (FFAppState()
                                                        .rememberMe) {
                                                      _model.refreshTokenResp2 =
                                                          await AuthenticateGroup
                                                              .refreshTokenCall
                                                              .call(
                                                        token:
                                                            currentAuthenticationToken,
                                                      );

                                                      shouldSetState = true;
                                                      if ((_model
                                                              .refreshTokenResp2
                                                              ?.succeeded ??
                                                          true)) {
                                                        setState(() {});
                                                      }
                                                    }
                                                    return;
                                                  } else {
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      barrierColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .barrierColor,
                                                      context: context,
                                                      builder: (context) {
                                                        return WebViewAware(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () =>
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus(),
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child:
                                                                  AlertMessageWidget(
                                                                buttonText:
                                                                    'Aceptar',
                                                                title:
                                                                    'Error: ${(_model.rejectedAuthoResp?.statusCode ?? 200).toString()}',
                                                                message:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  AuthorizationsGroup
                                                                      .responseAuthorizationCall
                                                                      .message(
                                                                    (_model.rejectedAuthoResp
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  ),
                                                                  'Ocurrió un error en el servidor.',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        safeSetState(() {}));
                                                  }
                                                }

                                                _model.isLoading = false;
                                                _model.wasUpdated = true;
                                                setState(() {});
                                                Navigator.pop(context);
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  barrierColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .barrierColor,
                                                  context: context,
                                                  builder: (context) {
                                                    return WebViewAware(
                                                      child: GestureDetector(
                                                        onTap: () =>
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus(),
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child: SizedBox(
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.35,
                                                            child:
                                                                const AlertMessageWidget(
                                                              title:
                                                                  'Rechazada',
                                                              message:
                                                                  'La autorización ha sido rechazada con éxito.',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));

                                setState(() {});
                              },
                              text: 'Rechazar',
                              icon: const Icon(
                                Icons.cancel_outlined,
                                size: 20.0,
                              ),
                              options: FFButtonOptions(
                                height: 36.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    6.0, 0.0, 6.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).error,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                elevation: 2.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  barrierColor:
                                      FlutterFlowTheme.of(context).barrierColor,
                                  context: context,
                                  builder: (context) {
                                    return WebViewAware(
                                      child: GestureDetector(
                                        onTap: () =>
                                            FocusScope.of(context).unfocus(),
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: SizedBox(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.3,
                                            child: ConfirmActionWidget(
                                              confirmButtonText: 'Aprobar',
                                              cancelButtonText: 'Cancelar',
                                              mainAction: () async {
                                                var shouldSetState = false;
                                                navigate() {}
                                                _model.isLoading = true;
                                                setState(() {});
                                                _model.approvedAuthResp =
                                                    await AuthorizationsGroup
                                                        .responseAuthorizationCall
                                                        .call(
                                                  token:
                                                      currentAuthenticationToken,
                                                  id: widget.authorizationId,
                                                  status: 'approved',
                                                );

                                                shouldSetState = true;
                                                if ((_model.approvedAuthResp
                                                        ?.succeeded ??
                                                    true)) {
                                                  _model.authorizationStatusValue =
                                                      'approved';
                                                  _model.authorizationStatusLabel =
                                                      'aprobada';
                                                  setState(() {});
                                                } else {
                                                  if ((_model.approvedAuthResp
                                                              ?.statusCode ??
                                                          200) ==
                                                      401) {
                                                    if (FFAppState()
                                                        .rememberMe) {
                                                      _model.refreshTokenResp3 =
                                                          await AuthenticateGroup
                                                              .refreshTokenCall
                                                              .call(
                                                        token:
                                                            currentAuthenticationToken,
                                                      );

                                                      shouldSetState = true;
                                                      if ((_model
                                                              .refreshTokenResp3
                                                              ?.succeeded ??
                                                          true)) {
                                                        setState(() {});
                                                      }
                                                    }
                                                    return;
                                                  } else {
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      barrierColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .barrierColor,
                                                      context: context,
                                                      builder: (context) {
                                                        return WebViewAware(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () =>
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus(),
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child:
                                                                  AlertMessageWidget(
                                                                buttonText:
                                                                    'Aceptar',
                                                                title:
                                                                    'Error: ${(_model.approvedAuthResp?.statusCode ?? 200).toString()}',
                                                                message:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  AuthorizationsGroup
                                                                      .responseAuthorizationCall
                                                                      .message(
                                                                    (_model.approvedAuthResp
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  ),
                                                                  'Ocurrió un error en el servidor.',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        safeSetState(() {}));
                                                  }
                                                }

                                                _model.isLoading = false;
                                                _model.wasUpdated = true;
                                                setState(() {});
                                                Navigator.pop(context);
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  barrierColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .barrierColor,
                                                  context: context,
                                                  builder: (context) {
                                                    return WebViewAware(
                                                      child: GestureDetector(
                                                        onTap: () =>
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus(),
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child: SizedBox(
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.35,
                                                            child:
                                                                const AlertMessageWidget(
                                                              title: 'Aprobada',
                                                              message:
                                                                  'La autorización ha sido aprobada con éxito.',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));

                                setState(() {});
                              },
                              text: 'Aprobar',
                              icon: const Icon(
                                Icons.check_circle_outline_rounded,
                                size: 20.0,
                              ),
                              options: FFButtonOptions(
                                height: 36.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    6.0, 0.0, 6.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).success,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                elevation: 2.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ].divide(const SizedBox(width: 16.0)),
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
