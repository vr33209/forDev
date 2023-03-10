// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ui/pages/login/components/components.dart';
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
            showErrorMessage(context, error);
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
                child: Provider(
                  create: (context) => widget.presenter,
                  child: Form(
                      child: Column(
                    children: [
                      const EmailInput(),
                      const Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 32),
                        child: PasswordInput(),
                      ),
                      const SubmitButton(),
                      FlatButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.person),
                          label: const Text('Criar conta'))
                    ],
                  )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
