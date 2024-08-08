import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import 'package:flutter/material.dart';
import 'dev_model.dart';
export 'dev_model.dart';

class DevWidget extends StatefulWidget {
  const DevWidget({super.key});

  @override
  State<DevWidget> createState() => _DevWidgetState();
}

class _DevWidgetState extends State<DevWidget> {
  late DevModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DevModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Visibility(
                visible: responsiveVisibility(
                  context: context,
                  phone: false,
                  tablet: false,
                ),
                child: FlutterFlowWebView(
                  content:
                      'https://app.powerbi.com/view?r=eyJrIjoiODEwZjdjOTUtMzUwNS00MDBlLWIzODUtNTdjOGFmNzUyNWNhIiwidCI6IjY2NTM4ZGU4LWVjNzEtNDA5My04NzMyLWM3MWVhNGVhNTE0NyIsImMiOjR9',
                  bypass: false,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  verticalScroll: false,
                  horizontalScroll: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
