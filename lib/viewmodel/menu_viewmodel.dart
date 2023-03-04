import 'package:flutter/material.dart';

class MenuController with ChangeNotifier {
  int _selectedIndexMenu = -1;
  set indexMenu(int value) {
    _selectedIndexMenu = value;
    notifyListeners();
  }
  int get indexMenu => _selectedIndexMenu;
}
