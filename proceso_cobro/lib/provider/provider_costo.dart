import 'package:flutter/widgets.dart';

class ProvCosto with ChangeNotifier {
  List<String> _pagos = [];
  int _idContacto = 0;

  List<String> get pagos => _pagos;
  set pagos(List<String> valor) {
    _pagos = valor;
    notifyListeners();
  }

  int get idContacto => _idContacto;
  set idContacto(int valor) {
    _idContacto = valor;
    notifyListeners();
  }
}
