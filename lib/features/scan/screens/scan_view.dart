import 'package:business_card/data/models/card_model.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  late MobileScannerController? _controller;
  CardModel? _found;
  DateTime _lastWarn = DateTime.fromMicrosecondsSinceEpoch(0);

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  void _onDetict(BarcodeCapture capture) {}

  Future<void> showInvalidQrDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Not a card QR code'),
        content: const Text(
          "This QR code isn't a card made with this app. "
          'Ask the owner to share their card QR code and scan it again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(child: MobileScanner(controller: _controller)),
    );
  }
}
