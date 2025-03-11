import 'package:final_project/test/login/data/repository/login_repository_impl.dart';
import 'package:final_project/test/login/domain/repository/login_repository.dart';
import 'package:final_project/test/login/domain/use_case/login_use_case.dart';
import 'package:final_project/test/login/presentation/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

final class DependencyInjection {
  DependencyInjection._();
  static final serviceLocator = GetIt.instance;

  static setup() {
    serviceLocator.registerFactory<LoginRepository>(
      () => LoginRepositoryImpl(),
    );
    serviceLocator.registerFactory<LoginUseCase>(
      () => LoginUseCase(loginRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<LoginBloc>(
      () => LoginBloc(loginUseCase: serviceLocator.get()),
    );
  }
}
