import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code/screens/transaction_details_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRScreen extends StatefulWidget {
//   const QRScreen({super.key});
//
//   @override
//   State<StatefulWidget> createState() => _QRScreenState();
// }
//
// class _QRScreenState extends State<QRScreen> {
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//
//   void _onQRViewCreated(QRViewController controller) {
//     setState(() => this.controller = controller);
//     controller.scannedDataStream.listen((scanData) {
//       setState(() => result = scanData);
//     });
//   }
//
//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     } else if (Platform.isIOS) {
//       controller!.resumeCamera();
//     }
//   }
//
//   void readQr() async {
//     if (result != null) {
//       controller!.pauseCamera();
//       print(result!.code);
//       controller!.dispose();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     readQr();
//     return Scaffold(
//       body: QRView(
//         key: qrKey,
//         onQRViewCreated: _onQRViewCreated,
//         overlay: QrScannerOverlayShape(
//           borderColor: Colors.orange,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: 250,
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? qrController;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrController!.pauseCamera();
    } else if (Platform.isIOS) {
      qrController!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    print("Qr view gets created");
    setState(() {
      qrController = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TransactionDetailsScreen()));
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  @override
  void dispose() {
    super.dispose();
    print("Dispose Function Called");
    qrController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.orange,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 250,
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "Scan a code",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                // child: (result != null) ? Text('Barcode Type: ${(result!.format)}  Data: ${result!.code}') : const Text('Scan a code'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
