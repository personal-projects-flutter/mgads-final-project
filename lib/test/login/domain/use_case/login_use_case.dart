import 'package:final_project/test/login/data/repository/login_repository_impl.dart';
import 'package:final_project/test/login/domain/entity/login_entity.dart';
import 'package:final_project/test/login/domain/repository/login_repository.dart';
import 'package:final_project/test/login/presentation/model/login_form_model.dart';

class LoginUseCase {
  late final LoginRepository _loginRepository;
  LoginUseCase() {
    _loginRepository = LoginRepositoryImpl();
  }

  bool invoke(LoginFormModel loginFormModel) {
    final LoginEntity data = loginFormModel.toEntity();
    return _loginRepository.login(data);
  }
}
