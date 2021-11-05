import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String email = '';
  String pass = '';

  bool isvalid() {
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }
}
