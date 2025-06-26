import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_scan/config/config.dart';
import 'package:smart_scan/ui/shared/shared.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<List<FileSystemEntity>> _loadRecentPdfFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    final files = dir.listSync()..retainWhere((f) => f.path.endsWith('.pdf'));

    files
        .sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));

    return files.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () => context.push(RouteConstants.scanScreen),
                  icon: const Icon(FluentIcons.scan_text_24_filled),
                  label: Text(
                    "Scan document",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: ColorTheme.white,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
            AppSpacing.lg,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Latest scans",
                style: context.textTheme.titleMedium,
              ),
            ),
            AppSpacing.md,
            Expanded(
              flex: 3,
              child: FutureBuilder<List<FileSystemEntity>>(
                future: _loadRecentPdfFiles(),
                builder: (context, asyncSnapshot) {
                  if (!asyncSnapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  final files = asyncSnapshot.data!;
                  if (files.isEmpty) {
                    return const Center(
                      child: Text('There are no recent scans yet.'),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      final file = files[index];
                      final fileName = file.path.split('/').last;
                      final modified = file.statSync().modified;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Icon(
                            FluentIcons.document_pdf_24_filled,
                            size: context.dp(2.5),
                          ),
                          title: Text(fileName),
                          subtitle: Text("${modified.toLocal()}"),
                          trailing: IconButton(
                            onPressed: () {
                              SharePlus.instance.share(
                                ShareParams(
                                    files: [XFile(file.path)],
                                    text: 'Compartido desde SmartScan'),
                              );
                            },
                            icon: Icon(
                              FluentIcons.share_24_filled,
                              size: context.dp(2.5),
                            ),
                          ),
                          onTap: () {
                            context.push(
                              RouteConstants.pdfViewerScreen,
                              extra: file.path,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
