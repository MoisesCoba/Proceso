import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:collection/collection.dart';

import 'package:flutter/widgets.dart';
import 'package:proceso_cobro/controllers/detalle_listacontacto_controler.dart';
import 'package:proceso_cobro/controllers/lista_contacto_controller.dart';
import 'package:proceso_cobro/provider/provider_costo.dart';
import 'package:provider/provider.dart';

import '../controllers/contacto_controller.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});
  final ProvCosto ProCosto = ProvCosto();
  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final ProvCosto ProCosto = ProvCosto();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new ProvCosto(),
      child: Scaffold(body: HomeContenedor()),
    );
  }
}

class HomeContenedor extends StatefulWidget {
  @override
  _HomeContenedorState createState() => _HomeContenedorState();
}

class _HomeContenedorState extends State<HomeContenedor> {
  @override
  void initState() {
    super.initState();
    _refreshListaContactos();
    _refreshContactos();
    _refreshListaDetalles();
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'Venta');
              },
              icon: const Icon(Icons.navigate_next)),
        ],
      ),
      body: ListView.builder(
        itemCount: _elementos.length,
        itemBuilder: (context, index) {
          List<Map<String, dynamic>> detalles = _detalles
              .where((detalle) =>
                  detalle['lista_contacto_id'] == _elementos[index]['id'])
              .toList();
          List<Map<String, dynamic>> contactos = [];

          for (Map<String, dynamic> detalle in detalles) {
            Map<String, dynamic>? contacto = _contactos.firstWhereOrNull(
                (contacto) => contacto['id'] == detalle['contacto_id']);
            if (contacto != null) {
              contactos.add(contacto);
            }
          }

          List<Widget> chipsList = [];

          if (contactos.isNotEmpty) {
            chipsList = contactos
                .map((contacto) => Chip(
                      backgroundColor: Color.fromARGB(255, 141, 219, 255),
                      elevation: 2,
                      label: Row(
                        children: [
                          Icon(Icons.account_circle),
                          SizedBox(
                              width: 8), // Espacio entre el icono y el texto
                          Text(contacto['nombre_completo'],
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.035)),
                        ],
                      ),
                    ))
                .toList();
          } else {
            chipsList.add(Text('No hay contactos para esta lista'));
          }

          return ExpansionTile(
            leading: Icon(Icons.list),
            title: Text(
              _elementos[index]['nombre'],
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            children: <Widget>[
              Column(
                verticalDirection: VerticalDirection.up,
                children: chipsList,
              )
            ],
          );
        },
      ),
    );
  }
}
