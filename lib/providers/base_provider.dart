import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  Size _size = Size(0, 0);
  get size => this._size;

  set size(value) {
    this._size = value;
    notifyListeners();
  }
}
