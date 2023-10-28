import 'package:flutter/material.dart';
import 'package:mediguard/shared/theme.dart';
import 'package:mediguard/widgets/qr_scanner_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key, required this.title, required this.onDetect});

  final String title;
  final void Function(String? value, MobileScannerController cameraController)
      onDetect;

  @override
  Widget build(BuildContext context) {
    final MobileScannerController cameraController = MobileScannerController();

    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              Barcode barcode = barcodes.first;
              // for (final barcode in barcodes) {
              //   debugPrint('Barcode found! ${barcode.rawValue}');
              // }
              onDetect(barcode.rawValue, cameraController);
            },
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      title,
                      style: whiteText.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      color: Colors.white,
                      icon: ValueListenableBuilder(
                        valueListenable: cameraController.torchState,
                        builder: (context, state, child) {
                          switch (state) {
                            case TorchState.off:
                              return const Icon(Icons.flash_off,
                                  color: Colors.grey);
                            case TorchState.on:
                              return const Icon(Icons.flash_on,
                                  color: Colors.yellow);
                          }
                        },
                      ),
                      onPressed: () => cameraController.toggleTorch(),
                    ),
                    IconButton(
                      color: Colors.white,
                      icon: ValueListenableBuilder(
                        valueListenable: cameraController.cameraFacingState,
                        builder: (context, state, child) {
                          switch (state) {
                            case CameraFacing.front:
                              return const Icon(Icons.camera_front);
                            case CameraFacing.back:
                              return const Icon(Icons.camera_rear);
                          }
                        },
                      ),
                      onPressed: () => cameraController.switchCamera(),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
