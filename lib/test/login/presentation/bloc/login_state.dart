import 'package:final_project/test/login/presentation/model/login_form_model.dart';

sealed class LoginState {
  LoginState({required this.model});

  final LoginFormModel model;
}

final class InitialState extends LoginState {
  InitialState() : super(model: LoginFormModel(email: "", password: ""));
}

final class DataUpdateState extends LoginState {
  DataUpdateState({required super.model});
}
