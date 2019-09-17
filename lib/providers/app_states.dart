import 'package:flutter/material.dart';

enum Screen{DASH, PRODUCTS, CATEGORIES, BRANDS, ORDERS}

class AppState with ChangeNotifier{
  Screen selectedScreen = Screen.DASH;

  changeScreen(Screen screen){
    selectedScreen = screen;
    notifyListeners();
  }

}