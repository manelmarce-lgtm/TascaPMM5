
import 'package:flutter/widgets.dart';

class UIProvider extends ChangeNotifier {
  int _selectedMenuOpt = 1;

  int get selectedMenuOpt => _selectedMenuOpt;

  set selectedMenuOpt(int opt) {
    _selectedMenuOpt = opt;
    notifyListeners(); // Notificar a todos los widgets que escuchen este provider
  }
}