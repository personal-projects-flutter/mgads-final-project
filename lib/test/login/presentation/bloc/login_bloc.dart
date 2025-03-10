import 'package:final_project/test/login/domain/use_case/login_use_case.dart';
import 'package:final_project/test/login/presentation/bloc/login_events.dart';
import 'package:final_project/test/login/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late final LoginUseCase _loginUseCase;

  LoginBloc() : super(InitialState()) {
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<SubmitEvent>(_submitEvent);
    _loginUseCase = LoginUseCase();
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

  void _submitEvent(SubmitEvent event, Emitter<LoginState> emit) {
    final bool result = _loginUseCase.invoke(state.model);
    print(result);
  }
}
