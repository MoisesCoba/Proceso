import 'package:flutter/material.dart';

final miTema = ThemeData(
  // Colores principales
  primaryColor: Colors.blue,
  primaryColorDark: Colors.blue[700],
  primaryColorLight: Colors.blue[200],
// Colores de fondo
  backgroundColor: Colors.grey[200],
  scaffoldBackgroundColor: Colors.grey[200],

// Colores de texto
  textTheme: TextTheme(
    headline1: TextStyle(color: Colors.black87),
    headline2: TextStyle(color: Colors.black87),
    headline3: TextStyle(color: Colors.black87),
    headline4: TextStyle(color: Colors.black87),
    headline5: TextStyle(color: Colors.black87),
    headline6: TextStyle(color: Colors.black87),
    subtitle1: TextStyle(color: Colors.black54),
    subtitle2: TextStyle(color: Colors.black54),
    bodyText1: TextStyle(color: Colors.black87),
    bodyText2: TextStyle(color: Colors.black87),
    button: TextStyle(color: Colors.white),
  ),

// Colores de estado
  errorColor: Colors.red,
  disabledColor: Colors.grey[400],
  accentColor: Colors.red,
  hoverColor: Colors.blue[100],
  focusColor: Colors.blue[200],

  // Agrega más propiedades de tema personalizadas aquí si es necesario
);
