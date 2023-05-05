import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proceso_cobro/controllers/documento_credito_controller.dart';
import 'package:provider/provider.dart';

import '../Dialogs/dialog_pago.dart';
import '../controllers/forma_pago_controller.dart';
import '../provider/provider_costo.dart';

class VentaView extends StatefulWidget {
  final ProvCosto ProCosto;
  VentaView({required this.ProCosto, Key? key}) : super(key: key);

  @override
  State<VentaView> createState() => _VentaState();
}

class _VentaState extends State<VentaView> {
  List<String> TituloCards = [
    "Factura",
    "Importe",
    "Bonificacion",
    "Pago",
    "Saldo",
    "vencimiento"
  ];
  @override
  void initState() {
    super.initState();
    _Pagos();
    _documentos();
  }

  List<Map<String, dynamic>> _documento = [];
  void _documentos() async {
    final data = await SQLHelperDocumentoCredito.getItems();
    setState(() {
      _documento =
          data.where((element) => element['contacto_id'] == 90).toList();
      print(_documento);
      print(_documento.length);
    });
  }

  List<String> _pagos_t = [];
  void _Pagos() async {
    final data = await SQLHelperFormaPago.getItems();
    setState(() {
      _pagos_t.clear();
      for (var i = 0; i < data.length; i++) {
        _pagos_t.add(data[i]['nombre']);
      }
      print(_pagos_t);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Usa widget.ProCosto en lugar de crear una nueva instancia de ProvCosto
    List<Card> Cards = TituloCards.map(
      (card) => Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  card,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
              ),
              Container(
                  height: (MediaQuery.of(context).size.height /
                          MediaQuery.of(context).size.width *
                          10) *
                      _documento.length,
                  width: MediaQuery.of(context).size.width * 0.3,
                  alignment: Alignment.bottomCenter,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _documento.length,
                      itemBuilder: (context, index) {
                        return Text(
                          _documento[index].toString(),
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: Colors.green,
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
    ).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.ProCosto.contactoId}',
            style: TextStyle(
              color: Colors.white, // Color del texto
              fontSize:
                  MediaQuery.of(context).size.width * 0.05, // Tamaño del texto
              fontWeight: FontWeight.bold, // Grosor del texto
            ),
          ),
          centerTitle: true,
          actions: [Icon(Icons.shopping_cart_outlined)],
        ),
        body: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: GestureDetector(
              child: Wrap(children: Cards),
              onTap: () {
                //_documentos();
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: AnimatedPadding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          //bottom: MediaQuery.of(context).viewInsets.left,
                        ),
                        duration: const Duration(milliseconds: 100),
                        child: PagoDialog(
                            ProCosto: widget.ProCosto, TipoPagos: _pagos_t),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ));
  }
}
