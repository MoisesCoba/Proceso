import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Dialogs/dialog_pago.dart';
import '../controllers/forma_pago_controller.dart';
import '../provider/provider_costo.dart';

class VentaView extends StatefulWidget {
  VentaView({super.key});
  final ProvCosto ProCosto = ProvCosto();
  @override
  State<VentaView> createState() => _VentaState();
}

class _VentaState extends State<VentaView> {
  @override
  void initState() {
    super.initState();
    _Pagos();
  }

  List<String> TituloCards = [
    "Factura",
    "Importe",
    "Bonificacion",
    "Pago",
    "Saldo",
    "Vencimiento"
  ];
  Widget build(BuildContext context) {
    final ProvCosto ProCosto = ProvCosto();
    List<Map<String, dynamic>> _pagos = [];
    void _Pagos() async {
      final data = await SQLHelperFormaPago.getItems();
      setState(() {
        _pagos = data;
        for (var i = 0; i < _pagos.length; i++){
          ProCosto.pagos =};
        print(_pagos);
      });
    }

    List<Card> Cards = TituloCards.map(
      (card) => Card(
        elevation: 2,
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
              SizedBox(height: 8),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '\$5000',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: Colors.green,
                    ),
                  ))
            ],
          ),
        ),
      ),
    ).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Diego',
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
            child: GestureDetector(
              child: Wrap(children: Cards),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return PagoDialog(ProCosto: ProCosto);
                  },
                );
              },
            ),
          ),
        ));
  }
}
