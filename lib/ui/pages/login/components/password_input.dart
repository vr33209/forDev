import 'package:flutter/material.dart';
import 'package:fordev/ui/pages/login/login.dart';
import 'package:provider/provider.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<String>(
        stream: presenter.passowordErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: 'Senha',
              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
              icon:
                  Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
            ),
            obscureText: true,
            onChanged: presenter.validatePassword,
          );
        });
  }
}
