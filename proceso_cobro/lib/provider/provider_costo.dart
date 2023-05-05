import 'package:flutter/widgets.dart';

class ProvCosto with ChangeNotifier {
  List<String> _pagos = [];
  int? _contacto_id = 0;
  List<String> get pagos => _pagos;

  set contacto_id(int? valor) {
    _contacto_id = valor;
    notifyListeners();
  }

  set pagos(List<String> valor) {
    _pagos = valor;
    notifyListeners();
  }
}
