import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'memorandum_model.dart';
export 'memorandum_model.dart';

class MemorandumWidget extends StatefulWidget {
  const MemorandumWidget({
    super.key,
    required this.id,
    required this.status,
    required this.imageUrl,
    required this.perPage,
    bool? isImagePath,
    required this.viewedValue,
  }) : isImagePath = isImagePath ?? false;

  final String? id;
  final String? status;
  final String? imageUrl;
  final int? perPage;
  final bool isImagePath;
  final String? viewedValue;

  @override
  State<MemorandumWidget> createState() => _MemorandumWidgetState();
}

class _MemorandumWidgetState extends State<MemorandumWidget> {
  late MemorandumModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MemorandumModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.status == 'UNVIEWED') {
        _model.confirmMemoResp =
            await MemorandumGroup.confirmMemorandumCall.call(
          token: currentAuthenticationToken,
          id: widget.id,
        );

        if ((_model.confirmMemoResp?.succeeded ?? true)) {
          _model.memorandumsResp =
              await MemorandumGroup.getMemorandumsCall.call(
            token: currentAuthenticationToken,
            perPage: widget.perPage,
            status: widget.viewedValue,
          );

          if ((_model.memorandumsResp?.succeeded ?? true)) {
            FFAppState().memorandumsArray = MemorandumGroup.getMemorandumsCall
                .rows(
                  (_model.memorandumsResp?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
            FFAppState().tempIntValue =
                MemorandumGroup.getMemorandumsCall.totalRows(
              (_model.memorandumsResp?.jsonBody ?? ''),
            )!;
            safeSetState(() {});
            _model.isLoading = false;
            safeSetState(() {});
            return;
          } else {
            if ((_model.memorandumsResp?.statusCode ?? 200) == 401) {
              GoRouter.of(context).prepareAuthEvent();
              await authManager.signOut();
              GoRouter.of(context).clearRedirectLocation();

              context.goNamedAuth('Login', context.mounted);

              return;
            } else {
              return;
            }
          }
        } else {
          if ((_model.confirmMemoResp?.statusCode ?? 200) == 401) {
            GoRouter.of(context).prepareAuthEvent();
            await authManager.signOut();
            GoRouter.of(context).clearRedirectLocation();

            context.goNamedAuth('Login', context.mounted);

            return;
          } else {
            return;
          }
        }
      } else {
        return;
      }

      context.goNamedAuth('Login', context.mounted);
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
              context.safePop();
            },
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (widget.isImagePath)
                InkWell(
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
                            widget.imageUrl!,
                            fit: BoxFit.contain,
                          ),
                          allowRotation: false,
                          tag: widget.imageUrl!,
                          useHeroAnimation: true,
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: widget.imageUrl!,
                    transitionOnUserGestures: true,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: Image.network(
                        widget.imageUrl!,
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              if (!widget.isImagePath)
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.airplay,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 72.0,
                      ),
                      Text(
                        'No disponible',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'La visualización de este comunicado no está disponible por el momento.',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ].divide(const SizedBox(height: 4.0)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
