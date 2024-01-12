import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:native_barcode_scanner/barcode_scanner.dart';
import 'package:prj_flutter/models/room.dart';
import 'package:prj_flutter/views/qr_content_screen.dart';
import 'package:uuid/uuid.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({Key? key});

  void _onBarcodeDetected(BuildContext context, Barcode barcode) {
    try {
      final qrCodeValue = barcode.value;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => QRCodeContentScreen(qrCodeValue: qrCodeValue),
        ),
      );
      print('qrCodeValue $qrCodeValue');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors du décodage du QR Code'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;
                final maxSize = width > height ? height : width;
                final containerSize = maxSize * 0.9;
                final barcodeContainerSize = maxSize * 0.85;
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(.25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.7),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  width: containerSize,
                  height: containerSize,
                  child: Center(
                    child: SizedBox(
                      width: barcodeContainerSize,
                      height: barcodeContainerSize,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BarcodeScannerWidget(
                          cameraSelector: CameraSelector.front,
                          stopScanOnBarcodeDetected: false,
                          onBarcodeDetected: (barcode) {
                            _onBarcodeDetected(context, barcode);
                          },
                          onError: (error) {
                            print('Barcode Error: $error');
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
