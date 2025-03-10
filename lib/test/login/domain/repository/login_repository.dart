import 'package:final_project/test/login/domain/entity/login_entity.dart';

abstract class LoginRepository {
  bool login(LoginEntity loginEntity);
}
