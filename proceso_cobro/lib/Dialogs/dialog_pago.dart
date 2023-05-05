import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../provider/provider_costo.dart';

class PagoDialog extends StatefulWidget {
  final ProvCosto ProCosto;
  List<String> TipoPagos;

  PagoDialog({required this.ProCosto, required this.TipoPagos});
  @override
  _PagoDialogState createState() => _PagoDialogState();
}

class _PagoDialogState extends State<PagoDialog> {
  @override
  String? _selectPago = "Efectivo";
  Widget build(BuildContext context) {
    print(widget.TipoPagos);
    DateTime fechaActual = DateTime.now();
    String _selectFecha =
        "${fechaActual.day}/${fechaActual.month}/${fechaActual.year}";
    return SizedBox(
      height: (MediaQuery.of(context).size.width /
              MediaQuery.of(context).size.height) *
          600,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(8),
            child: Text(
              'Saldo Actual \$',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    'Forma de pago: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  )),
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: false,
                  iconEnabledColor: Colors.blue,
                  itemHeight: null,
                  icon: Icon(Icons.payments),
                  value: _selectPago,
                  items: widget.TipoPagos.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectPago = value;
                    });
                  },
                ),
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                'Referencia: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: TextFormField(),
            ),
          ]),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                'Fecha: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
            ),
            Text(
              _selectFecha,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            IconButton(
              tooltip: "Selecccione la fecha actual",
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(fechaActual.year - 5),
                  lastDate: DateTime(fechaActual.year + 5),
                  cancelText: "Cancelar",
                  confirmText: "Confirmar",
                ).then((fechaSeleccionada) {
                  if (fechaSeleccionada != null) {
                    setState(() {
                      final formatoFecha = fechaSeleccionada;
                      _selectFecha =
                          "${formatoFecha.day}/${formatoFecha.month}/${formatoFecha.year}";
                    });
                    print(_selectFecha);
                  }
                });
              },
              icon: Icon(Icons.date_range,
                  size: MediaQuery.of(context).size.width * 0.07),
            ),
          ]),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                'Total: \$',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.local_print_shop,
                  size: MediaQuery.of(context).size.width * 0.09,
                ))
          ])
        ],
      ),
    );
  }
}
