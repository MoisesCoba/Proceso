import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  final int Indice;

  const ImpresoraDialog(
      {required this.ProCosto, required this.Close, required this.Indice});
  @override
  _ImpresoraDialogState createState() => _ImpresoraDialogState();
}

class _ImpresoraDialogState extends State<ImpresoraDialog> {
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    PermissionStatus statusConnect =
        await Permission.bluetoothConnect.request();
    PermissionStatus statusScan = await Permission.bluetoothScan.request();
    PermissionStatus statusLocation =
        await Permission.locationWhenInUse.request();

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
    printerManager.startScan(const Duration(seconds: 3));
  }

  void _stopScanDevices() {
    printerManager.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _devices.length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: InkWell(
                        //onTap: () => _testPrint(_devices[index]),
                        onTap: () {
                          _stopScanDevices();
                          widget.ProCosto.devices = _devices[index];
                          Navigator.pop(context);
                          widget.Close();
                          print(widget.ProCosto.devices!.name);
                        },
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(_devices[index].name ?? ''),
                                        Row(
                                          children: [
                                            Text(_devices[index].address!),
                                            Text(
                                                ' - Tipo: ${_devices[index].type.toString()}'),
                                          ],
                                        ),
                                        Text(
                                          'Seleccione alguna impresora',
                                          style: TextStyle(
                                              color: Colors.grey[700]),
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
                      ));
                }),
          ),
          StreamBuilder<bool>(
            stream: printerManager.isScanningStream,
            initialData: false,
            builder: (c, snapshot) {
              if (snapshot.data!) {
                return FloatingActionButton(
                  onPressed: _stopScanDevices,
                  elevation: 3,
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.stop),
                );
              } else {
                return FloatingActionButton(
                  onPressed: _startScanDevices,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.search),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
