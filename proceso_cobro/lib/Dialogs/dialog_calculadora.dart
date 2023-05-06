import 'package:flutter/material.dart';
import 'package:proceso_cobro/provider/provider_costo.dart';
import 'package:provider/provider.dart';

class CalculadoraDialog extends StatefulWidget {
  final ProvCosto ProNavegacion;
  final int indice;
  final Function() close;

  CalculadoraDialog(
      {required this.ProNavegacion, required this.indice, required this.close});
  @override
  _CalculadoraDialogState createState() => _CalculadoraDialogState();
}

class _CalculadoraDialogState extends State<CalculadoraDialog> {
  String resultado = "0";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        resultado = "0";
        //widget.ProNavegacion.numeroFormato = 0.0;
      } else if (buttonText == "OK") {
        //widget.ProNavegacion.importe[widget.indice] =
            //widget.ProNavegacion.numeroFormato;
        //widget.ProNavegacion.abono = 0;
        //for (var i = 0; i < widget.ProNavegacion.importe.length; i++) {
          //widget.ProNavegacion.abono += widget.ProNavegacion.importe[i];
        //}
        //widget.ProNavegacion.cambio =
            //widget.ProNavegacion.abono - widget.ProNavegacion.total;

        Navigator.pop(context);
        widget.close();
      } else if (buttonText == "DEL") {
        // verificar si se presionó "borrar"
        resultado = resultado.substring(
            0, resultado.length - 1); // eliminar último carácter
        if (resultado.isEmpty)
          resultado = "0"; // si la cadena está vacía, establecer en "0"
        //widget.ProNavegacion.numeroFormato = double.parse(resultado);
      } else if (buttonText == ".") {
        if (resultado.contains('.')) {
          print("La variable contiene al menos un punto.");
        } else {
          resultado += ".";
        }
      } else {
        resultado = (resultado == "0") ? buttonText : resultado + buttonText;
        //widget.ProNavegacion.numeroFormato = double.parse(resultado);
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
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.002),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color ??
                Color.fromARGB(255, 63, 63,
                    63), // Cambia el color predeterminado a gris si no se proporciona un color
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            textStyle:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.015),
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
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.002),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color ??
                Color.fromARGB(255, 63, 63,
                    63), // Cambia el color predeterminado a gris si no se proporciona un color
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            textStyle:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.015),
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
            width: MediaQuery.of(context).size.width * 0.3,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: MediaQuery.of(context).size.width * 0.005),
            child: Text(
              '0',
              //widget.ProNavegacion.Formateado,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
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
