import 'package:flutter/material.dart';
import 'package:login/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 250,
          ),
          CardContainer(
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 30,
                ),
                _LoginForm()
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text('Crear una nueva cuenta')
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //TODO mantener la referencia al Key
      child: Form(
          child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
                hintText: 'example@gmail.com',
                labelText: 'Correo',
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.alternate_email_sharp,
                  color: Colors.deepPurple,
                )),
          )
        ],
      )),
    );
  }
}
