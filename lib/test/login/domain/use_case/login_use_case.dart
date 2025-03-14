import 'package:final_project/test/login/domain/entity/login_entity.dart';
import 'package:final_project/test/login/domain/repository/login_repository.dart';
import 'package:final_project/test/login/presentation/model/login_form_model.dart';

class LoginUseCase {
  late final LoginRepository loginRepository;
  LoginUseCase({required this.loginRepository});

  Future<bool> invoke(LoginFormModel loginFormModel) {
    final LoginEntity data = loginFormModel.toEntity();
    return loginRepository.login(data);
  }
}
