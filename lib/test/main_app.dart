// import 'package:final_project/test/login/presentation/pages/login_page.dart';
import 'package:final_project/test/form_product/presentation/pages/form_product_page.dart';
import 'package:final_project/test/home/presentation/pages/home_page.dart';
import 'package:final_project/test/login/presentation/pages/login_page.dart';
import 'package:final_project/test/signup/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(path: "/", builder: (_, _) => HomePage(), name: "login"),
        // GoRoute(path: "/", builder: (_, _) => LoginPage(), name: "login"),
        GoRoute(
          path: "/sign-up",
          builder: (_, _) => SignUpPage(),
          name: "signup",
        ),
        GoRoute(path: "/home", builder: (_, _) => HomePage(), name: "home"),
        GoRoute(path: "/form-product", builder: (_, _) => FormProductPage(), name: "form-product"),
      ],
    );
    return MaterialApp.router(routerConfig: router);
  }
}
