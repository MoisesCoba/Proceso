import 'package:flutter/material.dart';
import 'package:proceso_cobro/views/venta_view.dart';
import '../models/modelo.dart';
import '../views/home_view.dart';
import '../views/vistas.dart';

class AppRoutes {
  static const rutaInicial = 'Venta';

  static final menuOpciones = <MenuOpcion>[
    MenuOpcion(ruta: 'login', nombre: 'Vista_Login', vista: LoginView()),
    MenuOpcion(ruta: 'Home', nombre: 'Vista_Casa', vista: HomeView()),
    MenuOpcion(ruta: 'Venta', nombre: 'Vista_Venta', vista: VentaView()),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRutas() {
    Map<String, Widget Function(BuildContext)> appRutas = {};

    for (var opcion in menuOpciones) {
      appRutas.addAll({opcion.ruta: (BuildContext context) => opcion.vista});
    }
    return appRutas;
  }
}
