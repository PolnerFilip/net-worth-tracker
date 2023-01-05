import 'package:flutter/cupertino.dart';

class ShowNotifier extends ChangeNotifier {
  static final ShowNotifier _singleton = ShowNotifier._internal();
  static bool _show = true;

  bool get show => _show;

  set show(bool value) {
    _show = value;
    notifyListeners();
  }

  factory ShowNotifier() {
    return _singleton;
  }

  ShowNotifier._internal();
}