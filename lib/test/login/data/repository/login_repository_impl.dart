import 'dart:math';

import 'package:final_project/test/login/domain/entity/login_entity.dart';
import 'package:final_project/test/login/domain/repository/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<bool> login(LoginEntity loginEntity) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("login", true);
    return true;
  }
}
