import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ProvCosto with ChangeNotifier {
  List<String> _pagos = [];
  Map<String, dynamic> _Contacto = {};
  List<Map<String, dynamic>> _documentacion = [];
  String _DialogFecha = "";
  int? _listaContactoId = null;

  int? get ListaContactoId => _listaContactoId;
  set ListaContactoId(int? valor) {
    _listaContactoId = valor;
    notifyListeners();
  }
  String _DialogFecha = "";
  double _numeroFomato = 0;
  String _Formateado = '';
  List<String> _DocSaldo = [];
  List<String> _DocPago = [];

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

  String get DialogFecha => _DialogFecha;
  set DialogFecha(String valor) {
    _DialogFecha = valor;
    notifyListeners();
  }

  double get numeroFormato => _numeroFomato;
  String get Formateado => _Formateado;
  set numeroFormato(double valor) {
    _numeroFomato = valor;
    _Formateado = NumberFormat('#,##0.##').format(_numeroFomato);
    notifyListeners();
  }

  List<String> get DocSaldo => _DocSaldo;
  set DocSaldo(List<String> valor) {
    _DocSaldo = valor;
    notifyListeners();
  }

  List<String> get DocPago => _DocPago;
  set DocPago(List<String> valor) {
    _DocPago = valor;
    notifyListeners();
  }
}
