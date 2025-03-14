import 'package:final_project/test/login/domain/use_case/login_use_case.dart';
import 'package:final_project/test/login/presentation/bloc/login_events.dart';
import 'package:final_project/test/login/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(InitialState()) {
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<SubmitEvent>(_submitEvent);
  }

  void _emailChangedEvent(EmailChangedEvent event, Emitter<LoginState> emit) {
    final newState = DataUpdateState(
      model: state.model.copyWith(email: event.email),
    );
    emit(newState);
  }

  void _passwordChangedEvent(
    PasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(password: event.password),
    );
    emit(newState);
  }

  void _submitEvent(SubmitEvent event, Emitter<LoginState> emit) async {
    final bool result = await loginUseCase.invoke(state.model);
    late final LoginState newState;
    if (result) {
      newState = LoginSuccessState(model: state.model);
    } else {
      newState = LoginErrorState(
        model: state.model,
        message: "Error al iniciar sesión",
      );
    }
    emit(newState);
  }
}
