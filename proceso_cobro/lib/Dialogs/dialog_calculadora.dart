import 'package:flutter/material.dart';
import 'package:proceso_cobro/provider/provider_costo.dart';
import 'package:provider/provider.dart';

class CalculadoraDialog extends StatefulWidget {
  final ProvCosto ProCosto;
  final int indice;
  final Function() Close;

  CalculadoraDialog(
      {required this.ProCosto, required this.indice, required this.Close});
  @override
  _CalculadoraDialogState createState() => _CalculadoraDialogState();
}

class _CalculadoraDialogState extends State<CalculadoraDialog> {
  String resultado = "0";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        resultado = "0";
        widget.ProCosto.numeroFormato = 0.0;
      } else if (buttonText == "OK") {
        widget.ProCosto.DocPago[widget.indice] = resultado;
        Navigator.pop(context);
        widget.Close();
      } else if (buttonText == "DEL") {
        // verificar si se presionó "borrar"
        resultado = resultado.substring(
            0, resultado.length - 1); // eliminar último carácter
        if (resultado.isEmpty)
          resultado = "0"; // si la cadena está vacía, establecer en "0"
        widget.ProCosto.numeroFormato = double.parse(resultado);
      } else if (buttonText == ".") {
        if (resultado.contains('.')) {
          print("La variable contiene al menos un punto.");
        } else {
          resultado += ".";
        }
      } else {
        resultado = (resultado == "0") ? buttonText : resultado + buttonText;
        widget.ProCosto.numeroFormato = double.parse(resultado);
      }
    });
  }

  List<String> _buttonTexts = [
    "AC",
    "DEL",
    "OK",
    "7",
    "8",
    "9",
    "4",
    "5",
    "6",
    "1",
    "2",
    "3",
  ];

  Widget _buildButton(String buttonText, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.005),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color ??
                Color.fromARGB(255, 63, 63,
                    63), // Cambia el color predeterminado a gris si no se proporciona un color
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            textStyle:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
                color: color == Colors.orange
                    ? Colors.white
                    : null), // Cambia el color del texto a blanco para el color naranja
          ),
          onPressed: () => _buttonPressed(buttonText),
        ),
      ),
    );
  }

  Widget _buildDoubleButton(String buttonText, {Color? color}) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.005),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color ??
                Color.fromARGB(255, 63, 63,
                    63), // Cambia el color predeterminado a gris si no se proporciona un color
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            textStyle:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
          ),
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => _buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < 4; i++) {
      List<Widget> rowChildren = [];

      for (int j = i * 3; j < i * 3 + 3; j++) {
        if (_buttonTexts[j] == "0") {
          rowChildren.add(_buildDoubleButton(_buttonTexts[j]));
        } else {
          rowChildren.add(_buildButton(_buttonTexts[j],
              color: j < 3 ? Colors.orange : null));
        }
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowChildren,
      ));
    }

    rows.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton("."),
        _buildDoubleButton("0"),
      ],
    ));

    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.width * 0.7,
            alignment: Alignment.centerRight,
            child: Text(
              widget.ProCosto.Formateado,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          ...rows,
        ],
      ),
    );
  }
}
