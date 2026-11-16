import 'package:business_card/features/main_layout/cubit/cards_cubit.dart';
import 'package:business_card/features/main_layout/cubit/main_layout_nav_cubit.dart';
import 'package:business_card/features/scan/cubit/scan_cubit.dart';
import 'package:business_card/features/scan/cubit/scan_status.dart';
import 'package:business_card/features/scan/widgets/invalid_qr_dialog.dart';
import 'package:business_card/features/scan/widgets/scan_found_sheet.dart';
import 'package:business_card/features/scan/widgets/scan_frame.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScanCubit(context.read<CardsCubit>()),
      child: const _ScanBody(),
    );
  }
}

class _ScanBody extends StatefulWidget {
  const _ScanBody();

  @override
  State<_ScanBody> createState() => _ScanBodyState();
}

class _ScanBodyState extends State<_ScanBody> {
  static const _scanTab = 1;

  final MobileScannerController _controller = MobileScannerController(
    autoStart: false,
    formats: [BarcodeFormat.qrCode],
    detectionTimeoutMs: 500,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (context.read<MainLayoutNavCubit>().state == _scanTab) _startCamera();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _startCamera() async {
    try {
      await _controller.start();
    } catch (_) {}
  }

  Future<void> _stopCamera() async {
    try {
      await _controller.stop();
    } catch (_) {}
  }

  void _onNavChanged(BuildContext context, int index) {
    final scanning =
        context.read<ScanCubit>().state.status == ScanStatus.scanning;
    if (index == _scanTab && scanning) {
      _startCamera();
    } else {
      _stopCamera();
    }
  }

  Future<void> _onScanChanged(BuildContext context, ScanState state) async {
    final cubit = context.read<ScanCubit>();
    switch (state.status) {
      case ScanStatus.found:
        {
          final card = state.card;
          if (card == null) return;
          _stopCamera();

          final save = await showCardFoundSheet(context, card);
          if (!mounted) return;

          if (save) {
            cubit.save();
          } else {
            cubit.scanAgain();
            _startCamera();
          }
        }
      case ScanStatus.invalid:
        await showInvalidQrDialog(context);
        await Future<void>.delayed(const Duration(seconds: 1));
        if (!mounted) return;
        cubit.scanAgain();
      case ScanStatus.saved:
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Saved to contacts')));
        cubit.scanAgain();
        _startCamera();
      case ScanStatus.failure:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not save the card')),
        );
        cubit.scanAgain();
        _startCamera();
      case ScanStatus.scanning:
      case ScanStatus.saving:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MainLayoutNavCubit, int>(listener: _onNavChanged),
        BlocListener<ScanCubit, ScanState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: _onScanChanged,
        ),
      ],
      child: ColoredBox(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            MobileScanner(
              controller: _controller,
              onDetect: (capture) => context.read<ScanCubit>().onDetect([
                for (final b in capture.barcodes) b.rawValue,
              ]),
            ),
            const Center(child: ScanFrame()),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      SizedBox(width: 44.w),
                      Expanded(
                        child: Text(
                          'Scan a card',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      _TorchButton(controller: _controller),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TorchButton extends StatelessWidget {
  const _TorchButton({required this.controller});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MobileScannerState>(
      valueListenable: controller,
      builder: (context, value, _) {
        final on = value.torchState == TorchState.on;
        return Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            tooltip: 'Flash',
            onPressed: () => controller.toggleTorch(),
            icon: Icon(
              on ? Iconsax.flash_slash : Iconsax.flash_1,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
        );
      },
    );
  }
}
