import 'package:flutter/material.dart';

class IMCProvider extends ChangeNotifier {
  GlobalKey<FormState> formIMCKey = new GlobalKey<FormState>();

  double altura = 0.0;
  double peso = 0;
  double imcresultado = 0;
  //bool isLoading;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formIMCKey.currentState?.validate());

    return formIMCKey.currentState?.validate() ?? false;
  }
}
