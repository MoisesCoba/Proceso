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

class ContactoView extends StatefulWidget {
  ContactoView({super.key});
  final ProvCosto ProCosto = ProvCosto();
  @override
  State<ContactoView> createState() => ContactoViewState();
}

class ContactoViewState extends State<ContactoView> {
  final ProvCosto ProCosto = ProvCosto();
  @override
  void initState() {
    super.initState();

    _refreshContactos();
    _refreshListaDetalles();
    // _refresRelacion();
  }

  List<Map<String, dynamic>> _contactos = [];
  List<Map<String, dynamic>> _detalles = [];
  List<Map<String, dynamic>> _relacion = [];

  void _refreshContactos() async {
    final data = await SQLHelperContacto.getItemsContacto();
    setState(() {
      _contactos = data;
    });
  }

  void _refreshListaDetalles() async {
    final data = await SQLHelperDetalleListaContacto.getItems();
    setState(() {
      _detalles = data;
    });
  }

  Future<void> _lista() async {
    // Aquí se debe implementar la lógica para actualizar los datos de la lista
    await Future.delayed(
        Duration(seconds: 1)); // Simula una operación asíncrona de 1 segundos
    setState(() {
      // Actualiza los datos de la listaid
      print("entro");
      _refreshListaDetalles();
      _refreshContactos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProCosto = Provider.of<ProvCosto>(context);

    List<Map<String, dynamic>> detalles = _detalles
        .where((detalle) =>
            detalle['lista_contacto_id'] == ProCosto.ListaContactoId)
        .toList();
    List<Map<String, dynamic>> contactos = [];

    for (Map<String, dynamic> detalle in detalles) {
      Map<String, dynamic>? contacto = _contactos.firstWhereOrNull(
          (contacto) => contacto['id'] == detalle['contacto_id']);
      if (contacto != null) {
        contactos.add(contacto);
      }
    }
    List<Widget> botonList = [];
    if (contactos.isNotEmpty) {
      botonList = contactos
          .map((contacto) => ElevatedButton(
                autofocus: true,
                onPressed: () async {
                  print(contacto['id']);
                  final data = await SQLHelperDocumentoCredito.getItems();
                  setState(() {
                    ProCosto.objContacto = contacto;
                    ProCosto.documentacion = data
                        .where((element) =>
                            element['contacto_id'] == contacto['id'])
                        .toList();
                  });

                  Navigator.pushNamed(context, 'cobro');
                },
                child: Row(
                  children: [
                    Icon(Icons.account_circle),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.035),
                    Text(contacto['nombre_completo'],
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.035)),
                  ],
                ),
              ))
          .toList();
    } else {
      botonList.add(Center(
          heightFactor: 30,
          child: Text('No hay contactos para esta lista',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05))));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Lista de contactos',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
            onRefresh: _lista,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: botonList,
                  ),
                )
              ],
            )));
  }
}
