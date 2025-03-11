import 'dart:async';

import 'package:final_project/test/di/dependency_injection.dart';
import 'package:final_project/test/login/presentation/bloc/login_bloc.dart';
import 'package:final_project/test/login/presentation/bloc/login_events.dart';
import 'package:final_project/test/login/presentation/bloc/login_state.dart';
import 'package:final_project/test/login/presentation/pages/login_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<LoginBloc>(),
      child: Scaffold(
        // Para que cuando aparezca el teclado, no desplace el contenido, sino
        // que el teclado quede arriba del contenido
        // Para que la vista no se ajuste al teclado cuando se muestre
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            HeaderLoginWidget(),
            BodyLoginWidget(),
            FooterLoginWidget(),
          ],
        ),
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
    final bloc = context.read<LoginBloc>();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case LoginSuccessState():
            GoRouter.of(context).pushReplacementNamed("home");
            break;
          case LoginErrorState():
            print("Error al iniciar sesión");
            showDialog(
              context: context,
              builder:
                  (BuildContext context) => AlertDialog(
                    title: const Text('AlertDialog Title'),
                    content: Text(state.message),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Aceptar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
            );
            break;
          // default:
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final bool isValidForm =
              validateEmail(state.model.email) == null &&
              validatePassword(state.model.password) == null;

          if (state is LoginSuccessState) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              GoRouter.of(context).pushReplacementNamed("home");
            });
          }

          return Expanded(
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 32.0),
              margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 80.0),
              child: Form(
                key: keyForm,
                child: Column(
                  children: [
                    // Text(state.model.email),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged:
                          (value) => setState(() {
                            bloc.add(EmailChangedEvent(email: value));
                          }),
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
                      onChanged:
                          (value) => setState(() {
                            bloc.add(PasswordChangedEvent(password: value));
                          }),
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
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FilledButton(
                      // onPressed: () => {keyForm.currentState?.validate()},
                      onPressed:
                          isValidForm
                              ? () => {
                                bloc.add(SubmitEvent()),
                                // print("esta haciendo login");
                              }
                              : null,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Iniciar Sesión",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
