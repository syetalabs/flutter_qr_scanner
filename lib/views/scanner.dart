import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/services.dart';

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class Scanner extends StatefulWidget {
  Scanner({Key key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  Barcode result;
  var flashState = flashOn;
  var cameraState = frontCamera;
  QRViewController controller;
  Offset position = Offset(15, 40);

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Color _color = Colors.white;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.green,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: size.width * 0.75,
            ),
          ),
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Draggable(
              feedback: Container(
                width: 100,
                height: 100,
                child: FloatingActionButton(
                  backgroundColor: Colors.green[100],
                  onPressed: () {},
                ),
              ),
              child: Container(
                width: 75,
                height: 75,
                child: FloatingActionButton(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.flash_on,
                    color: _color,
                  ),
                  onPressed: () {
                    controller?.toggleFlash();
                    setState(() {
                      _color = _color == Colors.yellow
                          ? Colors.white
                          : Colors.yellow;
                    });
                  },
                ),
              ),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                setState(() {
                  position = details.offset;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Scan Result'),
          content: Text(scanData.code),
          actions: [
            FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              onPressed: () {
                Navigator.pop(context);
                controller.resumeCamera();
              },
              child: Text('CANCEL'),
            ),
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () {
                Clipboard.setData(new ClipboardData(text: scanData.code));
                Navigator.pop(context);
                controller.resumeCamera();
              },
              child: Text('COPY TO CLIPBOAD'),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
