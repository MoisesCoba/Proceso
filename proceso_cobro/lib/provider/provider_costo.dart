import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ProvCosto with ChangeNotifier {
  List<String> _pagos = [];
  int? _contacto_id = null;
  List<String> get pagos => _pagos;

  int? get contactoId => this._contacto_id;
  set contactoId(int? valor) {
    _contacto_id = valor;
    notifyListeners();
  }

  set pagos(List<String> valor) {
    _pagos = valor;
    notifyListeners();
  }
}
