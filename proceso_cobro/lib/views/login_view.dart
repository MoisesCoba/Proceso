import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';

import '../controllers/cagero_controller.dart';
import '../themes/decoracion_curve.dart';
import '../widgets/efecto_widget.dart';

//Screens

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //DECLARAMOS LOS CONTROLADORES QUE VALIDARAN LOS DATOS
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<Map<String, dynamic>> _cajeros = [];
  late Database _database;
  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

//ABRIMOS LA BASE DE DATOS (CAJEROS)
  Future<void> _initDatabase() async {}

  @override
  Widget build(BuildContext context) {
    Future<void> _loginUser() async {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      if (email.isEmpty || password.isEmpty) {
        final snackBar = SnackBar(
          /// necesita establecer las siguientes propiedades para obtener el mejor efecto de awesome_snackbar_content
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Por favor',
            message: 'De rellenar los campos con sus datos!',

            /// cambie contentType a ContentType.success, ContentType.warning o ContentType.help para las variantes
            contentType: ContentType.help,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        return;
      }
      //EN ESTE APARTADO AHCE LA CONSULTA Y VALIDACION
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, 'app_pos_cajeros.db');
      _database = await openDatabase(path, version: 1);
      print('la direccion${_database}');
      final result = await _database.rawQuery(
          'SELECT * FROM cajeros WHERE user = ? AND password = ?',
          [email, password]);
      print(result);

      print(email);
      print(password);
      if (result.isNotEmpty) {
        //SI SE VALIDA SUS DATOS TE DARA LA BIENVENIDA
        print('Bienvenido ${result.first['user']}');
        Navigator.pushNamed(context, 'home');
      } else {
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Lo sentimos',
            message: 'Los datos ingresados no son validados!',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }

    void _showSnackBar(String message) {
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      );
    }

//modal emergente
    void _refresCajeros() async {
      final data = await SQLHelperCajeros.getItemsCajero();
      _cajeros = data;
      // setState(() {
      //   //_refresCajeros();
      // });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Scaffold(
        body: Stack(
          children: [
            ClipPath(
              clipper: ShapeClarification(),
              child: Container(
                height: 500,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Colors.blueAccent, Colors.lightBlue])),
              ),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "\n\nPulse aqui para sincronizar!",
                      style: TextStyle(
                          color: Color.fromRGBO(107, 107, 107, 1),
                          fontWeight: FontWeight.bold),
                    ),
                    SynchronizeButton(),
                    SizedBox(height: 10),
                    const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 119, 212, 255),
                      radius: 85,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('assets/logo_name.png'),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 45, right: 45, top: 10),
                      child: Card(
                        elevation: 15,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(50),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Ingrese el correo electrónico',
                                  filled: true,
                                  fillColor: Colors.blueGrey[50],
                                  labelStyle: TextStyle(fontSize: 12),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 40),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  hintText: 'Contraseña',
                                  counterText: 'Forgot password?',
                                  suffixIcon: Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.blueGrey[50],
                                  labelStyle: TextStyle(fontSize: 12),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 40),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: _loginUser,
                                  child: Text("Iniciar sesión")),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Text(
                                    'Crear una cuenta...',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  )))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
