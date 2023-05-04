import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proceso_cobro/controllers/detalle_listacontacto_controler.dart';
import 'package:proceso_cobro/controllers/lista_contacto_controller.dart';

import '../controllers/cajero_controller.dart';
import '../controllers/contacto_controller.dart';

class SynchronizeButton extends StatefulWidget {
  const SynchronizeButton({Key? key}) : super(key: key);

  @override
  _SynchronizeButtonState createState() => _SynchronizeButtonState();
}

class _SynchronizeButtonState extends State<SynchronizeButton> {
  bool _isSyncing = false;

  void _syncCajeros() async {
    setState(() {
      _isSyncing = true;
    });

    await SQLHelperCajeros.getApiCajeros();
    await SQLHelperListaContacto.getApiListaContacto();
    await SQLHelperDetalleListaContacto.getApiDetalleListaContacto();
    // await SQLHelperRazonSocial.getApiRazonSociale();
    // await SQLHelperMarcas.getApiMarcas();
    await SQLHelperContacto.getApiContactos();
    // await SQLHelperProductos.getApiProductos();
    setState(() {
      _isSyncing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isSyncing ? null : _syncCajeros,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(height: 10),
          Icon(
            Icons.sync,
            size: 28,
            color: Colors.deepPurple,
          ),
          if (_isSyncing)
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              strokeWidth: 2,
            ),
        ],
      ),
    );
  }
}
