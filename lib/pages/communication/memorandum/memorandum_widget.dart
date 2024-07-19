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
  });

  final String? id;
  final String? status;
  final String? imageUrl;
  final int? perPage;

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
          );

          if ((_model.memorandumsResp?.succeeded ?? true)) {
            FFAppState().memorandumsArray = MemorandumGroup.getMemorandumsCall
                .rows(
                  (_model.memorandumsResp?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
            setState(() {});
            _model.isLoading = false;
            setState(() {});
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
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
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
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
