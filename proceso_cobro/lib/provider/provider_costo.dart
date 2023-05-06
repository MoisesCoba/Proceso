import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ProvCosto with ChangeNotifier {
  List<String> _pagos = [];
  Map<String, dynamic> _Contacto = {};
  List<Map<String, dynamic>> _documentacion = [];
  String _DialogFecha = "";

  String get DialogFecha => _DialogFecha;
  set DialogFecha(String valor) {
    _DialogFecha = valor;
    notifyListeners();
  }

  List<String> get pagos => _pagos;
  set pagos(List<String> valor) {
    _pagos = valor;
    notifyListeners();
  }

  Map<String, dynamic> get objContacto => _Contacto;
  set objContacto(Map<String, dynamic> valor) {
    _Contacto = valor;
    notifyListeners();
  }

  List<Map<String, dynamic>> get documentacion => _documentacion;
  set documentacion(List<Map<String, dynamic>> valor) {
    _documentacion = valor;
    notifyListeners();
  }
}
