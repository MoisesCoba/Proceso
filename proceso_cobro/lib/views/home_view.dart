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

  Future<void> _lista() async {
    // Aquí se debe implementar la lógica para actualizar los datos de la lista
    await Future.delayed(
        Duration(seconds: 1)); // Simula una operación asíncrona de 1 segundos
    setState(() {
      // Actualiza los datos de la listaid
      print("entro");
      _refreshListaDetalles();
      _refreshContactos();
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context,'Venta');
              },
              icon: const Icon(Icons.navigate_next)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _lista,
        child: ListView.builder(
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
            List<Widget> botonList = [];
            if (contactos.isNotEmpty) {
              botonList = contactos
                  .map((contacto) => ElevatedButton(
                        autofocus: true,
                        onPressed: () {
                          ProCosto.idContacto = contacto['id'];
                          print(ProCosto.idContacto);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.account_circle),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.035),
                            Text(contacto['nombre_completo'],
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035)),
                          ],
                        ),
                      ))
                  .toList();
            } else {
              botonList.add(Text('No hay contactos para esta lista'));
            }
            return ExpansionTile(
              leading: Icon(Icons.list),
              title: Text(
                _elementos[index]['nombre'],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
              backgroundColor: Colors.grey[50],
              children: <Widget>[
                Column(
                  children: botonList,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
