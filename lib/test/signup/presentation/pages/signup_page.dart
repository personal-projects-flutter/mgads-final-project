import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pagina de registro", style: TextStyle(fontSize: 30)),
            OutlinedButton(
              onPressed: () => GoRouter.of(context).pop(),
              child: Text("Registrate"),
            ),
          ],
        ),
      ),
    );
  }
}
