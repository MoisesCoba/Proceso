import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    //_refreshProductos();
  }
  List<Map<String, dynamic>> _pagos = [];
  void _Pagos() async {
    final data = await SQLHelperFormaPago.getItems();
    setState(() {
      _pagos = data;
    });
  }

  List<String> TituloCards = [
    "Factura",
    "Importe",
    "Bonificacion",
    "Pago",
    "Saldo",
    "Vencimiento"
  ];

  String? _selectedPago = "Tarjeta";
  List<String> _pagoMetodo = ["Tarjeta", "Efectivo", "Bono"];
  Widget build(BuildContext context) {
    void _mostrarBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 200,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Saldo Actual \$',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      value: _selectedPago,
                      items: _pagoMetodo.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    }

    final ProvCosto ProCosto = ProvCosto();
    List<Card> Cards = TituloCards.map((card) => Card(
          elevation: 2,
          child: GestureDetector(
            onTap: () {
              _mostrarBottomSheet(context);
            },
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
        )).toList();

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
                /*showBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forma de pago',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          DropdownButton<String>(
                            value: 'Tarjeta de crédito',
                            items: <String>[
                              'Tarjeta de crédito',
                              'Transferencia bancaria',
                              'PayPal',
                              'Bitcoin'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    );
                  },
                );*/
              },
            ),
          ),
        ));
  }
}
