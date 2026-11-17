import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:business_card/core/helpers/storage_paths.dart';
import 'package:flutter/painting.dart';
import 'package:qr_flutter/qr_flutter.dart';

enum QrSaveStatus { ok, noPermission, failed }

class QrSaveResult {
  const QrSaveResult(this.status, [this.path]);
  final QrSaveStatus status;
  final String? path;
}

class QrImageService {
  QrImageService._();

  static const _ink = Color(0xFF15171A);

  static Future<Uint8List?> render(String data, {double size = 1200}) async {
    final pad = size * 0.10;
    final qrSize = size - pad * 2;

    final painter = QrPainter(
      data: data,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.M,
      gapless: true,
      eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: _ink),
      dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: _ink,
      ),
    );

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size, size),
        Radius.circular(size * 0.10),
      ),
      Paint()..color = const Color(0xFFFFFFFF),
    );

    canvas.save();
    canvas.translate(pad, pad);
    painter.paint(canvas, Size(qrSize, qrSize));
    canvas.restore();

    final image = await recorder.endRecording().toImage(
      size.toInt(),
      size.toInt(),
    );
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    return bytes?.buffer.asUint8List();
  }

  static Future<QrSaveResult> save(String data, String name) async {
    if (!await StoragePaths.ensurePermission()) {
      return const QrSaveResult(QrSaveStatus.noPermission);
    }
    try {
      final bytes = await render(data);
      if (bytes == null) return const QrSaveResult(QrSaveStatus.failed);
      final dir = await StoragePaths.dir(StoragePaths.myCards);
      final file = File('${dir.path}/${_fileName(name)}');
      await file.writeAsBytes(bytes, flush: true);
      return QrSaveResult(QrSaveStatus.ok, file.path);
    } catch (_) {
      return const QrSaveResult(QrSaveStatus.failed);
    }
  }

  static String fileName(String name) => _fileName(name);

  static String _fileName(String name) {
    final clean = name
        .replaceAll(RegExp(r'[\\/:*?"<>|]'), '')
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ');
    final base = clean.isEmpty ? 'card' : clean;
    return '$base QR.png';
  }
}
