import '/components/ui/empty_list/empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'authorization_pdf_list_model.dart';
export 'authorization_pdf_list_model.dart';

class AuthorizationPdfListWidget extends StatefulWidget {
  const AuthorizationPdfListWidget({
    super.key,
    required this.pdfArray,
  });

  final List<dynamic>? pdfArray;

  @override
  State<AuthorizationPdfListWidget> createState() =>
      _AuthorizationPdfListWidgetState();
}

class _AuthorizationPdfListWidgetState
    extends State<AuthorizationPdfListWidget> {
  late AuthorizationPdfListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AuthorizationPdfListModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final authorizationsItem = widget.pdfArray!.toList();
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
            return Container(
              height: 110.0,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).primaryText,
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: SvgPicture.network(
                        'https://upload.wikimedia.org/wikipedia/commons/8/87/PDF_file_icon.svg',
                        height: 60.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (false)
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  'PDF_viewer',
                                  queryParameters: {
                                    'pdfUrl': serializeParam(
                                      getJsonField(
                                        authorizationsItemItem,
                                        r'''$.content''',
                                      ).toString(),
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  Text(
                                    'Ver PDF',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await launchURL(getJsonField(
                                authorizationsItemItem,
                                r'''$.content''',
                              ).toString());
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.browser_updated_outlined,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  'Abrir PDF',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ].divide(const SizedBox(width: 12.0)),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
