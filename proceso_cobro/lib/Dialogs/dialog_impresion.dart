import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:proceso_cobro/Dialogs/test_bluethot.dart';
import 'package:proceso_cobro/provider/provider_costo.dart';

class AlertDialogImpresion extends StatefulWidget {
  final ProvCosto ProCosto;
  final Function() Close;
  final int indice;

  const AlertDialogImpresion(
      {required this.ProCosto, required this.Close, required this.indice});
  @override
  _AlertDialogState createState() => _AlertDialogState();
}

class _AlertDialogState extends State<AlertDialogImpresion> {
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  static int maxLineas = 15;

  void _testPrint(PrinterBluetooth printer) async {
    printerManager.selectPrinter(printer);

    //Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm58;
    final CapabilityProfile profile = await CapabilityProfile.load();

    final PosPrintResult res = await printerManager
        .printTicket(await demoReceipt(paper, profile), queueSleepTimeMs: 100);

    showToast(res.msg);
  }

  Future<List<int>> demoReceipt(
      PaperSize paper, CapabilityProfile profile) async {
    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];
    double totalPagado = 0;
    for (var i = 0; i < widget.ProCosto.DocPago.length; i++) {
      totalPagado += double.parse(widget.ProCosto.DocPago[i]);
    }

    // Print image
    /*
  final ByteData data = await rootBundle.load('assets/logo.png');
  final Uint8List imageBytes = data.buffer.asUint8List();
  final Image image = decodeImage(imageBytes)!;
  bytes += ticket.image(image);
  */

    bytes += ticket.text(
      'Soferp\nS.A. de C.V.',
      styles: const PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );
    bytes += ticket.text(
      '(RFC)',
      styles: const PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );
    bytes += ticket.text(
      '(Regimen fiscal)',
      styles: const PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );
    bytes += ticket.text(
      '(Direccion)',
      styles: const PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );
    bytes += ticket.feed(2);
    bytes += ticket.text(
      'Fecha: ${widget.ProCosto.DialogFecha}',
      styles: const PosStyles(align: PosAlign.left),
    );
    bytes += ticket.text(
      'Cliente: ${widget.ProCosto.ObjContacto['nombre_completo']}',
      styles: const PosStyles(align: PosAlign.left),
    );

    bytes += ticket.hr();

    bytes += ticket.row([
      PosColumn(
          text: 'Factura N${widget.indice.toString()}',
          width: 12,
          styles: const PosStyles(
            align: PosAlign.left,
            height: PosTextSize.size2,
          )),
    ]);
    bytes += ticket.row([
      PosColumn(text: 'Importe:', width: 6),
      PosColumn(
          text:
              '${double.parse(widget.ProCosto.documentacion[widget.indice]['impuesto']).toStringAsFixed(2)} MXN',
          width: 6,
          styles: const PosStyles(align: PosAlign.right)),
    ]);
    bytes += ticket.row([
      PosColumn(text: 'Pago:', width: 6),
      PosColumn(
          text:
              '${double.parse(widget.ProCosto.DocPago[widget.indice]).toStringAsFixed(2)} MXN',
          width: 6,
          styles: const PosStyles(align: PosAlign.right)),
    ]);
    bytes += ticket.row([
      PosColumn(text: 'Saldo:', width: 6),
      PosColumn(
          text:
              '${double.parse(widget.ProCosto.DocSaldo[widget.indice]).toStringAsFixed(2)} MXN',
          width: 6,
          styles: const PosStyles(align: PosAlign.right)),
    ]);
    bytes += ticket.hr();

    bytes += ticket.row([
      PosColumn(
          text: 'Total pagado:',
          width: 6,
          styles: const PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
      PosColumn(
        text: '\$${totalPagado.toStringAsFixed(2)}',
        width: 6,
        styles: const PosStyles(
          align: PosAlign.right,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      ),
    ]);
    bytes += ticket.row([
      PosColumn(
          text: 'Form. pago:',
          width: 6,
          styles: const PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
      PosColumn(
        text: '\$${totalPagado.toStringAsFixed(2)}',
        width: 6,
        styles: const PosStyles(
          align: PosAlign.right,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      ),
    ]);
    bytes += ticket.row([
      PosColumn(
          text: 'Ref. pago:',
          width: 6,
          styles: const PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
      PosColumn(
        text: '\$${totalPagado.toStringAsFixed(2)}',
        width: 6,
        styles: const PosStyles(
          align: PosAlign.right,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      ),
    ]);

    bytes += ticket.feed(2);
    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);
    bytes += ticket.text(
      timestamp,
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += ticket.hr(ch: '=', linesAfter: 1);
    bytes += ticket.text(
      'Cajero: 001',
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += ticket.text('Este comprobante no tiene efectos fiscales',
        styles: const PosStyles(align: PosAlign.center), linesAfter: 3);
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    const int maxTitleLength = 20;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 15),
        const Text(
          'Impresion',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            '¿Desea imprimir el ticket?',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        const Divider(
          height: 1,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: InkWell(
            highlightColor: Colors.grey[200],
            onTap: () => _testPrint(widget.ProCosto.devices!),
            child: Center(
              child: Text(
                'Aceptar',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const Divider(
          height: 1,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: InkWell(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
            highlightColor: Colors.grey[200],
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Center(
              child: Text(
                'Cancelar',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
