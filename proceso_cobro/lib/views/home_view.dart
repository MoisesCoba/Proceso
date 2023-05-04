import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:proceso_cobro/provider/provider_costo.dart';
import 'package:provider/provider.dart';

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
  List<String> elementos = ['Elemento 1', 'Elemento 2', 'Elemento 3'];
  List<String> chips = ['yucatan', 'merida', 'espita', 'tizimin', 'temozon'];
  @override
  Widget build(BuildContext context) {
    final ProCosto = Provider.of<ProvCosto>(context);

    List<Chip> chipsList = chips
        .map((chip) => Chip(
              backgroundColor: Color.fromARGB(255, 141, 219, 255),
              elevation: 2,
              label: Text(chip,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035)),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rutas de contacto',
          style: TextStyle(
            color: Colors.white, // Color del texto
            fontSize:
                MediaQuery.of(context).size.width * 0.05, // Tamaño del texto
            fontWeight: FontWeight.bold, // Grosor del texto
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            // Código para cerrar la aplicación
            SystemNavigator.pop();
          },
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: elementos.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              elementos[index],
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            children: <Widget>[
              SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: MediaQuery.of(context).size.width * 0.01,
                  children: chipsList,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
