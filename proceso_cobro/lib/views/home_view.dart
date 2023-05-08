import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:collection/collection.dart';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:proceso_cobro/controllers/detalle_listacontacto_controler.dart';
import 'package:proceso_cobro/controllers/lista_contacto_controller.dart';
import 'package:proceso_cobro/provider/provider_costo.dart';
import 'package:provider/provider.dart';

import '../controllers/contacto_controller.dart';
import '../controllers/documento_credito_controller.dart';
import 'venta_view.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});
  final ProvCosto ProCosto = ProvCosto();
  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final ProvCosto ProCosto = ProvCosto();
  @override
  void initState() {
    super.initState();
    _refreshListaContactos();

    // _refresRelacion();
  }

  List<Map<String, dynamic>> _elementos = [];
  List<Map<String, dynamic>> _contactos = [];
  List<Map<String, dynamic>> _detalles = [];
  List<Map<String, dynamic>> _relacion = [];
  void _refreshListaContactos() async {
    final data = await SQLHelperListaContacto.getItems();
    setState(() {
      _elementos = data;
    });
  }

  Future<void> _lista() async {
    // Aquí se debe implementar la lógica para actualizar los datos de la lista
    await Future.delayed(
        Duration(seconds: 1)); // Simula una operación asíncrona de 1 segundos
    setState(() {
      // Actualiza los datos de la listaid
      print("entro");
      _refreshListaContactos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProCosto = Provider.of<ProvCosto>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Rutas de contacto',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              SystemNavigator.pop();
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _lista,
          child: ListView.builder(
            itemCount: _elementos.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      ProCosto.ListaContacto = _elementos[index];

                      ///final data = await SQLHelperDocumentoCredito.getItems();
                      /*setState(() {
                             ProCosto.objContacto = contacto;
                              ProCosto.documentacion = data
                                  .where((element) =>
                                      element['contacto_id'] == contacto['id'])
                                  .toList();
                            });
                            ProCosto.DocSaldo.clear();
                            ProCosto.DocPago.clear();
                            for (var i = 0;
                                i < ProCosto.documentacion.length;
                                i++) {
                              ProCosto.DocSaldo.add(
                                  ProCosto.documentacion[i]['saldo']);
                              ProCosto.DocPago.add(
                                  ProCosto.documentacion[i]['pagado']);
                            }
                            print(ProCosto.DocSaldo);*/
                      setState(() {
                        Navigator.pushNamed(context, 'contacto');
                      });
                    },
                    leading: Icon(
                      Icons.list,
                      color: Colors.blue,
                    ),
                    title: Text(
                      _elementos[index]['nombre'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ),
                  Divider(thickness: 2),
                ],
              );
            },
          ),
        ));
  }
}
