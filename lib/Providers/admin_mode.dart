import 'package:flutter/cupertino.dart';

class AdminMode extends ChangeNotifier {
  bool isAdmin = false;

  changeIsAdmin(bool isAdmin) {
    this.isAdmin = isAdmin;
    notifyListeners();
  }
}
