// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fordev/ui/pages/pages.dart';

import '../../components/components.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter? presenter;

  const LoginPage(this.presenter, {super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        widget.presenter?.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        widget.presenter?.mainErrorStream.listen((error) {
          if (error.isNotEmpty) {
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red[900],
              content: Text(
                error,
                textAlign: TextAlign.center,
              ),
            ));
          }
        });
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
                    StreamBuilder<String>(
                        stream: widget.presenter?.emailErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              errorText: snapshot.data?.isEmpty == true
                                  ? null
                                  : snapshot.data,
                              icon: Icon(Icons.email,
                                  color: Theme.of(context).primaryColorLight),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: widget.presenter?.validateEmail,
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: StreamBuilder<String>(
                          stream: widget.presenter?.passowordErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                errorText: snapshot.data?.isEmpty == true
                                    ? null
                                    : snapshot.data,
                                icon: Icon(Icons.lock,
                                    color: Theme.of(context).primaryColorLight),
                              ),
                              obscureText: true,
                              onChanged: widget.presenter?.validatePassword,
                            );
                          }),
                    ),
                    StreamBuilder<bool>(
                        stream: widget.presenter?.isFormErrorStream,
                        builder: (context, snapshot) {
                          return RaisedButton(
                            onPressed: snapshot.data == true
                                ? widget.presenter!.auth
                                : null,
                            child: Text('Entrar'.toUpperCase()),
                          );
                        }),
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
      },
    );
  }
}
