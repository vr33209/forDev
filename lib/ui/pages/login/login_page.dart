// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fordev/ui/pages/pages.dart';

import '../../components/components.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter? presenter;

  const LoginPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const LoginHeader(),
          const Headline1(text: 'Login'),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email,
                        color: Theme.of(context).primaryColorLight),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: presenter?.validateEmail,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 32),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      icon: Icon(Icons.lock,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    obscureText: true,
                    onChanged: presenter?.validatePassword,
                  ),
                ),
                RaisedButton(
                  onPressed: null,
                  child: Text('Entrar'.toUpperCase()),
                ),
                FlatButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person),
                    label: const Text('Criar conta'))
              ],
            )),
          )
        ],
      ),
    );
  }
}
