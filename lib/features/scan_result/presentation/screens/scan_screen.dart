import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tickify_task/core/base/base_state.dart';
import 'package:tickify_task/core/navigation/app_routes.dart';
import 'package:tickify_task/core/theme/app_colors.dart';
import 'package:tickify_task/core/widgets/shared_button.dart';
import 'package:tickify_task/features/scan_result/domain/entities/scan_result.dart';
import 'package:tickify_task/features/scan_result/presentation/widgets/scanner_corners.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openResult(BuildContext context, ScanResultType type) {
    context.push(AppRoutes.scanResult, extra: type);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Scan ticket'),
        backgroundColor: backgroundColor,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Scan a ticket QR code',
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Place the QR code inside the frame',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 0.85,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                MobileScanner(controller: _controller),

                                const IgnorePointer(child: ScannerCorners()),

                                Center(
                                  child: SizedBox(
                                    width: 240,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AppButton(
                                          title: 'Valid',
                                          state: const ButtonEnabledState(),
                                          backgroundColor: AppColors.success,
                                          onPressed: () => _openResult(
                                            context,
                                            ScanResultType.valid,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        AppButton(
                                          title: 'Already Used',
                                          state: const ButtonEnabledState(),
                                          backgroundColor: AppColors.warning,
                                          onPressed: () => _openResult(
                                            context,
                                            ScanResultType.alreadyUsed,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        AppButton(
                                          title: 'Invalid',
                                          state: const ButtonEnabledState(),
                                          backgroundColor: AppColors.error,
                                          onPressed: () => _openResult(
                                            context,
                                            ScanResultType.invalid,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
