import 'package:flutter/material.dart';
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
    _Pagos();
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
    final ProCosto = Provider.of<ProvCosto>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ProCosto.ObjContacto['nombre_completo'].toString(),
          style: TextStyle(
            color: Colors.white, // Color del texto
            fontSize:
                MediaQuery.of(context).size.width * 0.05, // Tamaño del texto
            fontWeight: FontWeight.bold, // Grosor del texto
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.shopping_cart_outlined),
          )
        ],
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
                                    child: Container(
                                      child: ListView.builder(
                                        itemCount:
                                            ProCosto.documentacion.length,
                                        itemBuilder: (context, index) {
                                          final item =
                                              ProCosto.documentacion[index];

                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  print(index);
                                                  DateTime tiempo =
                                                      DateTime.now();
                                                  ProCosto.DialogFecha =
                                                      '${tiempo.day}/${tiempo.month}/${tiempo.year}';
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return SingleChildScrollView(
                                                        child: AnimatedPadding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom,
                                                            //bottom: MediaQuery.of(context).viewInsets.left,
                                                          ),
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      100),
                                                          child: PagoDialog(
                                                              indice: index,
                                                              ProCosto:
                                                                  ProCosto,
                                                              TipoPagos:
                                                                  _pagos_t),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Card(
                                                  elevation: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        left: BorderSide(
                                                            width: 5.0,
                                                            color: Colors.blue),
                                                      ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            14),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Text(
                                                            'Vencimiento: ${ProCosto.documentacion[index]['vencimiento']}',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.04,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 3,
                                                                        bottom:
                                                                            3),
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                child: Text(
                                                                  '${ProCosto.documentacion[index]['factura']}',
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
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child: Text(
                                                                  'Saldo: ${double.parse(ProCosto.DocSaldo[index]).toStringAsFixed(2)} MXN',
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
                                                            ),
                                                          ],
                                                        ),
                                                        Divider(thickness: 2),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                child: Text(
                                                                  'Bonificación',
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
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child: Text(
                                                                  'Pagado: ${double.parse(ProCosto.DocPago[index]).toStringAsFixed(2)} MXN',
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
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Text(
                                                            'Impuesto: ${double.parse(ProCosto.documentacion[index]['impuesto']).toStringAsFixed(2)} MXN',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: MediaQuery.of(
                                                                          context)
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
                                              )
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
