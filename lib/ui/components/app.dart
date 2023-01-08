import 'package:flutter/material.dart';
import '../../ui/pages/pages.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const LoginPage(),
    );
  }
}
