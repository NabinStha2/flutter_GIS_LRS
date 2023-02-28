import 'package:flutter/material.dart';

class MapProvider extends ChangeNotifier {
  int tileLayerIndex = 0;

  changeTileLayerIndex(int value) {
    tileLayerIndex = value;
    notifyListeners();
  }
}
