import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:proceso_cobro/controllers/documento_credito_controller.dart';
import 'package:proceso_cobro/widgets/factura_widget.dart';
import 'package:provider/provider.dart';

import '../Dialogs/dialog_pago.dart';
import '../controllers/forma_pago_controller.dart';
import '../provider/provider_costo.dart';

class CobroView extends StatefulWidget {
  CobroView({super.key});
  @override
  State<CobroView> createState() => _CobroState();
}

class _CobroState extends State<CobroView> {
  List<String> TituloCards = [
    "Factura",
    "Importe",
    "Bonificación",
    "Pagado",
    "Saldo",
    "vencimiento"
  ];
  @override
  void initState() {
    super.initState();

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

  Future<void> _lista() async {
    // Aquí se debe implementar la lógica para actualizar los datos de la lista
  }

  @override
  Widget build(BuildContext context) {
    // Usa widget.ProCosto en lugar de crear una nueva instancia de ProvCosto
    final ProCosto = Provider.of<ProvCosto>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ProCosto.objContacto['nombre_completo'].toString(),
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
      body: RefreshIndicator(
          onRefresh: _lista,
          child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  //LISTA DE COMPRAS
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 5, top: 10, bottom: 10),
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'Facturas',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(child: FacturaWidget()),
                                  ),
                                ],
                              ),
                            ),

                            //EXPANDED DONDE ESTA LAS CATEGORIAS Y LA VISTA DE LOS PRODUCTOS
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              ))),
    );
  }
}
