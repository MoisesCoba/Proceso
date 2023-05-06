import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Dialogs/dialog_pago.dart';
import '../controllers/forma_pago_controller.dart';
import '../provider/provider_costo.dart';

class FacturaWidget extends StatefulWidget {
  @override
  _FacturaWidget createState() => _FacturaWidget();
}

class _FacturaWidget extends State<FacturaWidget> {
  List<Map<String, dynamic>> _categorias = [];
  List<Map<String, dynamic>> _productos = [];
  List<Map<String, dynamic>> results = [];
  void initState() {
    super.initState();
    _Pagos();
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

  Widget build(BuildContext context) {
    final ProCosto = Provider.of<ProvCosto>(context);

    return ListView.builder(
      itemCount: ProCosto.documentacion.length,
      itemBuilder: (context, index) {
        final item = ProCosto.documentacion[index];

        return Column(
          children: [
            InkWell(
              onTap: () {
                DateTime tiempo = DateTime.now();
                ProCosto.DialogFecha =
                    '${tiempo.day}/${tiempo.month}/${tiempo.year}';
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
                            indice: index,
                            ProCosto: ProCosto,
                            TipoPagos: _pagos_t),
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
                      left: BorderSide(width: 5.0, color: Colors.blue),
                    ),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Vencimiento: ${ProCosto.documentacion[index]['vencimiento']}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(top: 3, bottom: 3),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '${ProCosto.documentacion[index]['factura']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Saldo: ${double.parse(ProCosto.documentacion[index]['saldo']).toStringAsFixed(2)} MXN',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
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
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Bonificación',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Pagado: ${double.parse(ProCosto.documentacion[index]['pagado']).toStringAsFixed(2)} MXN',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Impuesto: ${double.parse(ProCosto.documentacion[index]['impuesto']).toStringAsFixed(2)} MXN',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
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
    );
  }
}
