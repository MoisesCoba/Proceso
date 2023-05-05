import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proceso_cobro/controllers/documento_credito_controller.dart';
import 'package:provider/provider.dart';

import '../Dialogs/dialog_pago.dart';
import '../controllers/forma_pago_controller.dart';
import '../provider/provider_costo.dart';

class VentaView extends StatefulWidget {
  VentaView({super.key});
  @override
  State<VentaView> createState() => _VentaState();
}

class _VentaState extends State<VentaView> {
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
  Future<void> _lista() async {
    // Aquí se debe implementar la lógica para actualizar los datos de la lista
  }
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
    List<Container> Containers = TituloCards.map(
      (container) => Container(
        //elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  container,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'gg',
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
                                      child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    child: GestureDetector(
                                      child: Wrap(
                                        children: Containers,
                                      ),
                                    ),
                                  )),
                                  Divider(thickness: 2),
                                  Expanded(
                                    child: Container(
                                      child: ListView.builder(
                                        itemCount: _documento.length,
                                        itemBuilder: (context, index) {
                                          final item = _documento[index];

                                          return Column(
                                            children: [
                                              //WIDGET PARA LA LISTA
                                              Container(
                                                  child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                child: GestureDetector(
                                                  child: Wrap(
                                                    children: [
                                                      Container(
                                                        //elevation: 0,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(14),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                child: Text(
                                                                  _documento[
                                                                          index]
                                                                      [
                                                                      'factura'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.04,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        //elevation: 0,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(14),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                child: Text(
                                                                  _documento[
                                                                          index]
                                                                      [
                                                                      'impuesto'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.04,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        //elevation: 0,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(14),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                child: Text(
                                                                  'bonificacion',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.04,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        //elevation: 0,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(14),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                child: Text(
                                                                  _documento[
                                                                          index]
                                                                      [
                                                                      'pagado'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.04,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        //elevation: 0,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(14),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                child: Text(
                                                                  _documento[
                                                                          index]
                                                                      ['saldo'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.04,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        //elevation: 0,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(14),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                child: Text(
                                                                  _documento[
                                                                          index]
                                                                      [
                                                                      'vencimiento'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.04,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                              Divider(thickness: 2),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
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
