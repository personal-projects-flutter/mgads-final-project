// import 'package:final_project/test/login/presentation/pages/login_page.dart';
import 'package:final_project/test/form_product/presentation/pages/form_product_page.dart';
import 'package:final_project/test/home/presentation/pages/home_page.dart';
import 'package:final_project/test/login/presentation/pages/login_page.dart';
import 'package:final_project/test/signup/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: "/login",
          builder: (_, _) => LoginPage(),
          name: "login",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticated = prefs.getBool("login") ?? false;
            if (authenticated) {
              return "/home";
            }
            return null;
          },
        ),
        GoRoute(
          path: "/",
          builder: (_, _) => HomePage(),
          name: "home",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticated = prefs.getBool("login") ?? false;
            if (!authenticated) {
              return "/login";
            }
            return null;
          },
        ),
        GoRoute(
          path: "/sign-up",
          builder: (_, _) => SignUpPage(),
          name: "signup",
        ),
        // GoRoute(path: "/home", builder: (_, _) => HomePage(), name: "home"),
        GoRoute(
          path: "/form-product",
          builder: (_, _) => FormProductPage(),
          name: "form-product",
        ),
        GoRoute(
          path: "/form-product/:id",
          builder:
              (_, state) => FormProductPage(id: state.pathParameters["id"]),
          name: "form-product-u",
        ),
      ],
    );
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
