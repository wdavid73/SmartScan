import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_scan/ui/widgets/adaptive_scaffold.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final String filePath;

  const PdfViewerScreen({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AppBar(title: Text("Pdf Viewer")),
      child: SfPdfViewer.file(File(filePath)),
    );
  }
}
