import 'dart:async';

import 'package:final_project/test/login/presentation/pages/login_mixin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Para que cuando aparezca el teclado, no desplace el contenido, sino
      // que el teclado quede arriba del contenido
      // Para que la vista no se ajuste al teclado cuando se muestre
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [HeaderLoginWidget(), BodyLoginWidget(), FooterLoginWidget()],
      ),
    );
  }
}

class FooterLoginWidget extends StatelessWidget {
  const FooterLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: Column(
        children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Aún no tiene cuenta?"),
              SizedBox(width: 32.0),
              GestureDetector(
                onTap: () => {GoRouter.of(context).pushNamed("signup")},
                child: Text(
                  "Registrate Aquí",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.purple,
                    color: Colors.purple,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BodyLoginWidget extends StatefulWidget {
  BodyLoginWidget({super.key});

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> with LoginMixin {
  bool _showPassword = false;
  Timer? _autoShowTimer;
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 32.0),
        margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 80.0),
        child: Form(
          key: keyForm,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // initialValue: "Usuario",
                validator: validateEmail,
                decoration: InputDecoration(
                  labelText: "Email",
                  icon: Icon(Icons.person),
                  hintText: "Ingrese su usuario",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validatePassword,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  icon: Icon(Icons.lock),
                  hintText: "Ingrese su contraseña",
                  // suffixIcon: GestureDetector(
                  suffixIcon: InkWell(
                    onTap: () {
                      // En caso de que no sea nulo, cancelamos el timer (primera vez)
                      // Igual, cancelamos el timer
                      _autoShowTimer?.cancel();

                      if (!_showPassword) {
                        _autoShowTimer = Timer(Duration(seconds: 3), () {
                          setState(() {
                            _showPassword = false;
                          });
                        });
                      }

                      setState(() {
                        _showPassword = !_showPassword;
                        //   Future.delayed(
                        //     Duration(seconds: 3),
                        //     () => {
                        //       setState(() {
                        //         _showPassword = false;
                        //       }),
                        //     },
                        //   );
                        // }),
                      }); // setState
                    },
                    child: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              FilledButton(
                onPressed: () => {keyForm.currentState?.validate()},
                child: SizedBox(
                  width: double.infinity,
                  child: Text("Iniciar Sesión", textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 550.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.fill,
            'http://t0.gstatic.com/licensed-image?q=tbn:ANd9GcQYzNRvQ0rLqKSV7nJQ9WO0KhQisB-LiM3Wo6Q8oVDETQSBZu2MtjGr17ZNBOUzup9owz-G3oIG87PPzGsSr7s',
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              "Iniciar Sesión 2",
              style: TextStyle(fontSize: 30.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
