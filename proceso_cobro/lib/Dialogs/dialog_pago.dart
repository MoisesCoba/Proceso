import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../provider/provider_costo.dart';

class PagoDialog extends StatefulWidget {
  final ProvCosto ProCosto;

  PagoDialog(
      {required this.ProCosto});
  @override
  _PagoDialogState createState() => _PagoDialogState();
}
class _PagoDialogState extends State<PagoDialog> {
  @override
    String? _selectedPago = "Tarjeta";
  List<String> _pagoMetodo = ["Tarjeta", "Efectivo", "Bono"];
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(8),
            child: Text(
              'Saldo Actual \$',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: _selectedPago,
                items: _pagoMetodo.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
