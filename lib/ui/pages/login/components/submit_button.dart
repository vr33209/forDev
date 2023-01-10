import 'package:flutter/material.dart';
import 'package:fordev/ui/pages/login/login.dart';

import 'package:provider/provider.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<bool>(
        stream: presenter.isFormErrorStream,
        builder: (context, snapshot) {
          return RaisedButton(
            onPressed: snapshot.data == true ? presenter!.auth : null,
            child: Text('Entrar'.toUpperCase()),
          );
        });
  }
}
