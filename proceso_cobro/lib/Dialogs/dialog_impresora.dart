import 'dart:io';

import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../provider/provider_costo.dart';

class ImpresoraDialog extends StatefulWidget {
  final ProvCosto ProCosto;
  final Function() Close;

  const ImpresoraDialog({required this.ProCosto, required this.Close});
  @override
  _ImpresoraDialogState createState() => _ImpresoraDialogState();
}

class _ImpresoraDialogState extends State<ImpresoraDialog> {
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    // Solicitar permisos de Bluetooth
    PermissionStatus statusConnect =
        await Permission.bluetoothConnect.request();
    PermissionStatus statusScan = await Permission.bluetoothScan.request();

    // Solicitar permisos de ubicación
    PermissionStatus statusLocation =
        await Permission.locationWhenInUse.request();

    // Comprobar los resultados de la solicitud de permisos
    if (statusConnect == PermissionStatus.granted &&
        statusScan == PermissionStatus.granted &&
        statusLocation == PermissionStatus.granted) {
      print('Todo bien');
    } else {
        print('alguno mal Todo bien');// Al menos un permiso ha sido denegado, proporcionar una explicación clara al usuario
    }
  }
  /*Future<void> _requestPermissions() async {
    PermissionStatus statusConnect =
        await Permission.bluetoothConnect.request();
    PermissionStatus statusScan = await Permission.bluetoothScan.request();
    PermissionStatus statusLocation = await Permission.locationWhenInUse.request();

    /*if (Platform.isAndroid) {
      if (statusLocation.isDenied) {
        await [
          Permission.location,
        ].request();
      }
    }*/

    if (statusLocation.isGranted &&
        statusScan.isGranted &&
        statusConnect.isGranted) {
      debugPrint('all granted');

      // do scan bluetooth device function

      printerManager.scanResults.listen((devices) async {
        debugPrint('UI: Devices found ${devices.length}');
        setState(() {
          _devices = devices;
        });
      });

      _startScanDevices();
    } else {
      debugPrint('Not all permissions granted');
    }
  }*/

  void _startScanDevices() {
    setState(() {
      _devices = [];
    });
    printerManager.startScan(const Duration(seconds: 5));
  }

  void _stopScanDevices() {
    printerManager.stopScan();
  }

  void _testPrint(PrinterBluetooth printer) async {
    printerManager.selectPrinter(printer);

    //Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm58;
    final CapabilityProfile profile = await CapabilityProfile.load();

    // TEST PRINT

    //final PosPrintResult res =
    //    await printerManager.printTicket(await testTicket(paper, profile), queueSleepTimeMs: 100);

    // DEMO RECEIPT

    final PosPrintResult res = await printerManager
        .printTicket(await demoReceipt(paper, profile), queueSleepTimeMs: 100);

    showToast(res.msg);
  }

  void _sendPrint(List<PrinterBluetooth> devices, String bluetoothPrinter) {
    if (devices.isNotEmpty) {
      for (var device in devices) {
        if (device.name == bluetoothPrinter) {
          _testPrint(device);
        }
      }
    }
  }

  Future<List<int>> demoReceipt(
      PaperSize paper, CapabilityProfile profile) async {
    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];

    // Print image
    /*
  final ByteData data = await rootBundle.load('assets/logo.png');
  final Uint8List imageBytes = data.buffer.asUint8List();
  final Image image = decodeImage(imageBytes)!;
  bytes += ticket.image(image);
  */

    bytes += ticket.text('GROCERYLY',
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    bytes += ticket.text('889  Watson Lane',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('New Braunfels, TX',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('Tel: 830-221-1234',
        styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text('Web: www.example.com',
        styles: const PosStyles(align: PosAlign.center), linesAfter: 1);

    bytes += ticket.hr();
    /*bytes += ticket.row([
      PosColumn(text: 'Qty', width: 1),
      PosColumn(text: 'Item', width: 7),
      PosColumn(
          text: 'Price',
          width: 2,
          styles: const PosStyles(align: PosAlign.right)),
      PosColumn(
          text: 'Total',
          width: 2,
          styles: const PosStyles(align: PosAlign.right)),
    ]);*/

    /*bytes += ticket.row([
      PosColumn(text: '2', width: 1),
      PosColumn(text: 'ONION RINGS', width: 7),
      PosColumn(
        text: '0.99',
        width: 2,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
      PosColumn(
        text: '1.98',
        width: 2,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
    ]);
    bytes += ticket.row([
      PosColumn(text: '1', width: 1),
      PosColumn(text: 'PIZZA', width: 7),
      PosColumn(
          text: '3.45', width: 2, styles: const PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '3.45', width: 2, styles: const PosStyles(align: PosAlign.right)),
    ]);
    bytes += ticket.row([
      PosColumn(text: '1', width: 1),
      PosColumn(text: 'SPRING ROLLS', width: 7),
      PosColumn(
          text: '2.99', width: 2, styles: const PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '2.99', width: 2, styles: const PosStyles(align: PosAlign.right)),
    ]);
    bytes += ticket.row([
      PosColumn(text: '3', width: 1),
      PosColumn(text: 'CRUNCHY STICKS WITH A SPECIAL TREATMENT FOR A SPECIFIC CLIENT', width: 7),
      PosColumn(
          text: '0.85', width: 2, styles: const PosStyles(align: PosAlign.right)),
      PosColumn(
          text: '2.55', width: 2, styles: const PosStyles(align: PosAlign.right)),
    ]);
    bytes += ticket.hr();

    bytes += ticket.row([
      PosColumn(
          text: 'TOTAL',
          width: 6,
          styles: const PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
      PosColumn(
        text: '\$10.97',
        width: 6,
        styles: const PosStyles(
          align: PosAlign.right,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      ),
    ]);

    bytes += ticket.hr(ch: '=', linesAfter: 1);

    bytes += ticket.row([
      PosColumn(
        text: 'Cash',
        width: 7,
        styles: const PosStyles(
          align: PosAlign.right,
          width: PosTextSize.size2,
        ),
      ),
      PosColumn(
        text: '\$15.00',
        width: 5,
        styles: const PosStyles(
          align: PosAlign.right,
          width: PosTextSize.size2,
        ),
      ),
    ]);
    bytes += ticket.row([
      PosColumn(
        text: 'Change',
        width: 7,
        styles: const PosStyles(
          align: PosAlign.right,
          width: PosTextSize.size2,
        ),
      ),
      PosColumn(
        text: '\$4.03',
        width: 5,
        styles: const PosStyles(
          align: PosAlign.right,
          width: PosTextSize.size2,
        ),
      ),
    ]);*/

    bytes += ticket.feed(2);
    bytes += ticket.text('Thank you! :3',
        styles: const PosStyles(align: PosAlign.center, bold: true));

    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);
    bytes += ticket.text(
      timestamp,
      styles: const PosStyles(align: PosAlign.center),
      linesAfter: 2,
    );

    // Print QR Code from image
    // try {
    //   const String qrData = 'example.com';
    //   const double qrSize = 200;
    //   final uiImg = await QrPainter(
    //     data: qrData,
    //     version: QrVersions.auto,
    //     gapless: false,
    //   ).toImageData(qrSize);
    //   final dir = await getTemporaryDirectory();
    //   final pathName = '${dir.path}/qr_tmp.png';
    //   final qrFile = File(pathName);
    //   final imgFile = await qrFile.writeAsBytes(uiImg.buffer.asUint8List());
    //   final img = decodeImage(imgFile.readAsBytesSync());

    //   bytes += ticket.image(img);
    // } catch (e) {
    //   print(e);
    // }

    // Print QR Code using native function
    bytes += ticket.qrcode('www.example.com');
    ticket.feed(10);
    ticket.cut();
    return bytes;
  }

  Future<List<int>> testTicket(
      PaperSize paper, CapabilityProfile profile) async {
    final Generator generator = Generator(paper, profile);
    List<int> bytes = [];

    bytes += generator.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ'); //Works fine
    //bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
    //     styles: PosStyles(codeTable: PosCodeTable.westEur)); //Not tested yet POS-5802DD
    //bytes += generator.text('Special 2: blåbærgrød',
    //     styles: PosStyles(codeTable: PosCodeTable.westEur)); //Not tested yey on POS-5802DD

    bytes += generator.text('Bold text',
        styles: const PosStyles(bold: true)); //Works sometimes
    //bytes += generator.text('Reverse text', styles: const PosStyles(reverse: true)); //Do not work on POS-5802DD
    //bytes += generator.text('Underlined text', styles: const PosStyles(underline: true)); //Do not work on POS-5802DD

    bytes += generator.text('Align left',
        styles: const PosStyles(align: PosAlign.left)); //Works fine
    bytes += generator.text('Align center',
        styles: const PosStyles(align: PosAlign.center)); //Works fine
    bytes += generator.text('Align right',
        styles: const PosStyles(align: PosAlign.right)); //Works fine

    bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: const PosStyles(align: PosAlign.center),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center),
      ),
    ]); //Works fine

    bytes += generator.text('Text size 200%',
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    // Print image
    /*
  final ByteData data = await rootBundle.load('assets/logo.png');
  final Uint8List buf = data.buffer.asUint8List();
  final Image image = decodeImage(buf)!;
  bytes += generator.image(image);
  */
    //Do not works fine on POS-5802DD

    // Print image using alternative commands
    //bytes += generator.imageRaster(image);
    // bytes += generator.imageRaster(image, imageFn: PosImageFn.graphics);

    // Print barcode
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.upcA(barData)); //Works fine

    // Print mixed (chinese + latin) text. Only for printers supporting Kanji mode
    // bytes += generator.text(
    //   'hello ! 中文字 # world @ éphémère &',
    //   styles: PosStyles(codeTable: PosCodeTable.westEur),
    //   containsChinese: true,
    // );

    bytes += generator.feed(1);
    bytes += generator.cut();
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .5,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _devices.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => _testPrint(_devices[index]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.print),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(_devices[index].name ?? ''),
                                    Text(_devices[index].address!),
                                    Text(
                                      'Click para imprimir el test',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
    /*floatingActionButton: StreamBuilder<bool>(
        stream: printerManager.isScanningStream,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              onPressed: _stopScanDevices,
              backgroundColor: Colors.red,
              child: const Icon(Icons.stop),
            );
          } else {
            return FloatingActionButton(
              onPressed: _startScanDevices,
              child: const Icon(Icons.search),
            );
          }
        },
      ),
    );*/
  }
}
