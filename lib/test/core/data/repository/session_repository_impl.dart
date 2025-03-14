import 'package:final_project/test/core/domain/repository/session_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SessionRepositoryImpl implements SessionRepository {
  @override
  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove('login');
  }
}
