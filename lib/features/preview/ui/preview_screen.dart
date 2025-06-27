import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_scan/app/dependency_injection.dart';
import 'package:smart_scan/features/home/cubits/cubits.dart';
import 'package:smart_scan/ui/shared/styles/app_spacing.dart';
import 'package:smart_scan/ui/widgets/widgets.dart';
import 'package:smart_scan/utils/ocr_languages.dart';

class PreviewScreen extends StatefulWidget {
  final String imagePath;
  const PreviewScreen({super.key, required this.imagePath});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late File _imageFile;
  String _recognizedText = '';
  bool _processing = false;

  @override
  void initState() {
    super.initState();
    final cubit = getIt.get<SettingsCubit>();
    _imageFile = File(widget.imagePath);
    if (cubit.state.ocrEnabled) {
      _performOCR();
    }
  }

  Future<void> _performOCR() async {
    setState(() => _processing = true);

    final inputImage = InputImage.fromFile(_imageFile);
    final script = getScriptForLanguage();

    if (script == null) {
      CustomSnackBar.showSnackBar(
        context,
        message: "The selected OCR language is not available in this app.",
      );
      return;
    }
    final textRecognizer = TextRecognizer(script: script);
    final recognizedText = await textRecognizer.processImage(inputImage);
    textRecognizer.close();

    setState(() {
      _recognizedText = recognizedText.text;
      _processing = false;
    });

    if (recognizedText.text.trim().isEmpty) {
      if (!mounted) return;

      CustomSnackBar.showSnackBar(
        context,
        message:
            "No text was detected in the image with the selected language.",
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<File> _applyGrayScaleFilter(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final originalImage = img.decodeImage(bytes)!;
    final grayScale = img.grayscale(originalImage);
    final filteredPath = "${(await getTemporaryDirectory()).path}/filtered.jpg";
    final filteredFile = File(filteredPath)
      ..writeAsBytesSync(img.encodeJpg(grayScale));
    return filteredFile;
  }

  Future<void> _exportAsPDF() async {
    final pdf = pw.Document();
    final imageBytes = await _imageFile.readAsBytes();

    final image = pw.MemoryImage(imageBytes);
    pdf.addPage(pw.Page(build: (context) => pw.Center(child: pw.Image(image))));

    final outPutDir = await getApplicationDocumentsDirectory();
    final filePath =
        '${outPutDir.path}/smartscan_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final pdfFile = File(filePath);
    await pdfFile.writeAsBytes(await pdf.save());
    if (mounted) {
      await SharePlus.instance.share(
        ShareParams(
          text: "Document Scanned",
          files: [XFile(pdfFile.path)],
          sharePositionOrigin: (context.findRenderObject() as RenderBox)
                  .localToGlobal(Offset.zero) &
              (context.findRenderObject() as RenderBox).size,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = getIt.get<SettingsCubit>();
    return AdaptiveScaffold(
      appBar: AppBar(
        title: Text("Preview"),
        actions: [
          IconButton(
            onPressed: _exportAsPDF,
            icon: Icon(
              FluentIcons.document_pdf_24_filled,
            ),
          ),
          IconButton(
            onPressed: _exportAsPDF,
            icon: Icon(
              FluentIcons.share_24_filled,
            ),
          ),
        ],
      ),
      child: _processing
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.file(_imageFile),
                  AppSpacing.md,
                  ElevatedButton.icon(
                    icon: const Icon(FluentIcons.photo_filter_24_filled),
                    label: Text("Apply filter BW"),
                    onPressed: () async {
                      final filtered = await _applyGrayScaleFilter(_imageFile);
                      setState(() {
                        _imageFile = filtered;
                      });
                    },
                  ),
                  AppSpacing.md,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Text detected"),
                  ),
                  AppSpacing.md,
                  SelectableText(
                    _recognizedText.isNotEmpty
                        ? _recognizedText
                        : 'Text no detected',
                  ),
                  if (!cubit.state.ocrEnabled && _recognizedText.isEmpty) ...[
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.text_snippet_outlined),
                      label: const Text("Execute OCR manually"),
                      onPressed: _performOCR,
                    ),
                  ]
                ],
              ),
            ),
    );
  }
}
