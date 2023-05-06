import 'package:flutter/material.dart';
import 'package:proceso_cobro/views/venta_view.dart';
import 'package:provider/provider.dart';
import '../models/modelo.dart';
import '../provider/provider_costo.dart';
import '../views/cobro_view.dart';

import '../views/contacto_view.dart';
import '../views/home2_view.dart';
import '../views/vistas.dart';

class AppRoutes {
  static const rutaInicial = 'Home';

  static final menuOpciones = <MenuOpcion>[
    MenuOpcion(ruta: 'login', nombre: 'Vista_Login', vista: LoginView()),
    MenuOpcion(ruta: 'Home', nombre: 'Vista_Casa', vista: HomeView()),
    MenuOpcion(ruta: 'Venta', nombre: 'Vista_Venta', vista: VentaView()),
    MenuOpcion(ruta: 'cobro', nombre: 'Vista_Venta', vista: CobroView()),
    MenuOpcion(ruta: 'contacto', nombre: 'Vista_Venta', vista: ContactoView()),
  ];
  static Map<String, Widget Function(BuildContext)> getAppRutas() {
    Map<String, Widget Function(BuildContext)> appRutas = {};

    for (var opcion in menuOpciones) {
      appRutas.addAll({opcion.ruta: (BuildContext context) => opcion.vista});
    }
    return appRutas;
  }
}
