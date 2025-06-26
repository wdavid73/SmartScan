import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_scan/config/router/routes_constants.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  late Directory _documentsDir;
  List<FileSystemEntity> _pdfFiles = [];

  @override
  void initState() {
    super.initState();
    _loadPdfFiles();
  }

  Future<void> _loadPdfFiles() async {
    _documentsDir = await getApplicationDocumentsDirectory();
    final files = _documentsDir.listSync()
      ..retainWhere(
        (f) => f.path.endsWith('.pdf'),
      );
    files
        .sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));

    setState(() {
      _pdfFiles = files;
    });
  }

  void _deleteFiles(FileSystemEntity file) async {
    await file.delete();
    _loadPdfFiles();
  }

  void _shareFile(FileSystemEntity file) {
    SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], text: "Share from SmartScan"));
  }

  void _openFile(FileSystemEntity file) {
    context.push(RouteConstants.pdfViewerScreen, extra: file.path);
  }

  @override
  Widget build(BuildContext context) {
    if (_pdfFiles.isEmpty) {
      return const Center(
        child: Text("Documents empty"),
      );
    }

    return ListView.builder(
      itemCount: _pdfFiles.length,
      itemBuilder: (context, index) {
        final file = _pdfFiles[index];
        final fileName = file.path.split('/').last;
        final modified = file.statSync().modified;

        return Card(
          child: ListTile(
            title: Text(fileName),
            subtitle: Text("${modified.toLocal()}"),
            leading: const Icon(Icons.picture_as_pdf_rounded),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'share') _shareFile(file);
                if (value == 'delete') _deleteFiles(file);
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'share',
                  child: Text("Share"),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text("Delete"),
                ),
              ],
            ),
            onTap: () => _openFile(file),
          ),
        );
      },
    );
  }
}
