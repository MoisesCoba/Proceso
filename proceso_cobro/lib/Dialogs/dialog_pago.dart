import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../provider/provider_costo.dart';

class PagoDialog extends StatefulWidget {
  final ProvCosto ProCosto;
  List<String> TipoPagos;
  final int indice;

  PagoDialog(
      {super.key,
      required this.indice,
      required this.ProCosto,
      required this.TipoPagos});
  @override
  _PagoDialogState createState() => _PagoDialogState();
}

class _PagoDialogState extends State<PagoDialog> {
  @override
  String? _selectPago = "Por definir";
  DateTime tiempo = DateTime.now();
  Widget build(BuildContext context) {
    print(widget.indice);
    return SizedBox(
      height: (MediaQuery.of(context).size.width /
              MediaQuery.of(context).size.height) *
          700,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(8),
            child: Text(
              'Saldo Actual \$${widget.ProCosto.documentacion[widget.indice]['saldo']}',
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
                  padding: EdgeInsets.all(10),
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
                  icon: Icon(Icons.payments,
                      size: MediaQuery.of(context).size.width * 0.07),
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
              padding: EdgeInsets.all(10),
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
                child: TextFormField(
                    decoration: InputDecoration(
                        hintText:
                            '${widget.ProCosto.documentacion[widget.indice]['factura']}'),
                    onEditingComplete: () {})),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Fecha: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
            ),
            Text(
              widget.ProCosto.DialogFecha,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: IconButton(
                tooltip: "Seleccione la fecha actual",
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(tiempo.year - 5),
                    lastDate: DateTime(tiempo.year + 5),
                    cancelText: "Cancelar",
                    confirmText: "Confirmar",
                  ).then((fechaSeleccionada) {
                    if (fechaSeleccionada != null) {
                      setState(() {
                        final formatoFecha = fechaSeleccionada;
                        widget.ProCosto.DialogFecha =
                            "${formatoFecha.day}/${formatoFecha.month}/${formatoFecha.year}";
                      });
                      print(widget.ProCosto.DialogFecha);
                    }
                  });
                },
                icon: Icon(Icons.date_range,
                    size: MediaQuery.of(context).size.width * 0.07,
                    color: Colors.blue),
              ),
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Total: \$',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () {},
                  tooltip: 'Pagar',
                  icon: Icon(
                    Icons.payments_outlined,
                    size: MediaQuery.of(context).size.width * 0.07,
                    color: Colors.blue,
                  )),
            )
          ]),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: IconButton(
                onPressed: () {},
                tooltip: 'Imprimir ticket',
                icon: Icon(
                  Icons.print,
                  size: MediaQuery.of(context).size.width * 0.09,
                )),
          )
        ],
      ),
    );
  }
}
