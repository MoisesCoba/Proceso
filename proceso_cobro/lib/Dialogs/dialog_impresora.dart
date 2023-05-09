import 'dart:io';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:proceso_cobro/Dialogs/test_bluethot.dart';

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
  late TextEditingController _bluetoothPrinter;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    PermissionStatus statusConnect =
        await Permission.bluetoothConnect.request();
    PermissionStatus statusScan = await Permission.bluetoothScan.request();
    PermissionStatus statusLocation = await Permission.locationWhenInUse.request();

    if (Platform.isAndroid) {
      if (statusLocation.isDenied) {
        await [
          Permission.location,
        ].request();
      }
    }

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
  }

  void _startScanDevices() {
    setState(() {
      _devices = [];
    });
    printerManager.startScan(const Duration(seconds: 4));
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
