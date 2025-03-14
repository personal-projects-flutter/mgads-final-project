import 'package:final_project/test/login/domain/entity/login_entity.dart';

abstract class LoginRepository {
  Future<bool> login(LoginEntity loginEntity);
}
