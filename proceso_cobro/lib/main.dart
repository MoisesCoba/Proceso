import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import './themes/tema.dart';
import 'routes/rutas_app.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();
  runApp(const ProsCobro());
}

void setup() async {
  await Future.delayed(const Duration(milliseconds: 50));
  FlutterNativeSplash.remove();
}

class ProsCobro extends StatelessWidget {
  const ProsCobro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Proceso Cobro',
        theme: miTema,
        // theme: tema(
        //   //primarySwatch: Colors.blue,
        // ),
        initialRoute: AppRoutes.rutaInicial,
        routes: AppRoutes.getAppRutas());
  }
}
