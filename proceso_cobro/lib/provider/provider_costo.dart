import 'package:flutter/widgets.dart';

class ProvCosto with ChangeNotifier {
  List<String> _pagos = [];

  List<String> get pagos => _pagos;
  set pagos(List<String> valor) {
    _pagos = valor;
    notifyListeners();
  }
}
