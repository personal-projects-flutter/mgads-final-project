import 'dart:math';

import 'package:final_project/test/login/domain/entity/login_entity.dart';
import 'package:final_project/test/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  bool login(LoginEntity loginEntity) {
    return Random().nextBool();
  }
}
