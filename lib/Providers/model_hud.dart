import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier {
// prop ...
  bool isLoading = false;

  changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
