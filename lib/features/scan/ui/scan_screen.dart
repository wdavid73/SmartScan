import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_scan/config/config.dart';
import 'package:smart_scan/config/router/routes_constants.dart';
import 'package:smart_scan/ui/widgets/widgets.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  CameraController? _controller;
  late List<CameraDescription> _cameras;
  bool _isInitialized = false;
  bool _isTakingPicture = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();

    final rearCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back);

    _controller = CameraController(rearCamera, ResolutionPreset.high);
    await _controller!.initialize();

    setState(() {
      _isInitialized = true;
    });
  }

  Future<void> _captureImage() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isTakingPicture) {
      return;
    }

    try {
      setState(() => _isTakingPicture = true);
      final XFile file = await _controller!.takePicture();
      final directory = await getTemporaryDirectory();
      final targetPath =
          "${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
      final imageFile = await File(file.path).copy(targetPath);
      if (!mounted) return;

      context.push(RouteConstants.previewScreen, extra: imageFile.path);
    } catch (e) {
      debugPrint("Error capture image: $e");
    } finally {
      setState(() => _isTakingPicture = false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      child: Stack(
        children: [
          if (_isInitialized)
            CameraPreview(_controller!)
          else
            const Center(child: CircularProgressIndicator()),
          _buildOverlay(),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: _captureImage,
                child: Icon(
                  FluentIcons.camera_24_filled,
                  size: context.dp(3),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(
                FluentIcons.dismiss_24_filled,
                size: context.dp(3),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildOverlay() {
  return LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth * 0.8;
      final height = width * 1.414; // A4 aspect ratio (≈ 1:√2)

      return Center(
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              // Border
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),

              // Corner indicators
              Positioned(top: 0, left: 0, child: _corner()),
              Positioned(top: 0, right: 0, child: _corner(mirrorX: true)),
              Positioned(bottom: 0, left: 0, child: _corner(mirrorY: true)),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: _corner(mirrorX: true, mirrorY: true)),
            ],
          ),
        ),
      );
    },
  );
}

Widget _corner({bool mirrorX = false, bool mirrorY = false}) {
  const size = 24.0;
  return Transform(
    alignment: Alignment.center,
    transform: Matrix4.identity()
      ..scale(mirrorX ? -1.0 : 1.0, mirrorY ? -1.0 : 1.0),
    child: CustomPaint(
      size: const Size(size, size),
      painter: _CornerPainter(),
    ),
  );
}

class _CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, size.height), Offset(0, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
