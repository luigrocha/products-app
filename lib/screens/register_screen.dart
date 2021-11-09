import 'package:flutter/material.dart';
import 'package:login/providers/login_form_provider.dart';
import 'package:login/services/services.dart';
import 'package:login/ui/input_decorations.dart';
import 'package:login/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 250),
          CardContainer(
            child: Column(
              children: [
                SizedBox(height: 10),
                Text('Crear Cuenta',
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(
                  height: 30,
                ),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: _LoginForm(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
            style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                shape: MaterialStateProperty.all(StadiumBorder())),
            child: Text(
              '¿Ya tienes una cuenta?',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'example@gmail.com',
                    labelText: 'Correo',
                    prefixIcon: Icons.alternate_email_rounded),
                onChanged: (value) => loginForm.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'El valor no es un correo';
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '*******',
                    labelText: 'Contraseña',
                    prefixIcon: Icons.lock_outline),
                onChanged: (value) => loginForm.pass = value,
                validator: (value) {
                  return (value != null && value.length >= 6)
                      ? null
                      : 'El contraseña no tiene 6 caracteres';
                },
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final authService =
                            Provider.of<AuthService>(context, listen: false);
                        if (!loginForm.isvalid()) return;
                        loginForm.isLoading = true;

                        final String? errorMessage = await authService
                            .createUser(loginForm.email, loginForm.pass);

                        if (errorMessage == null) {
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          //TODO message
                          print(errorMessage);
                        }
                        loginForm.isLoading = false;
                      },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text(loginForm.isLoading ? 'Espere...' : 'Registrar',
                        style: TextStyle(color: Colors.white))),
              )
            ],
          )),
    );
  }
}