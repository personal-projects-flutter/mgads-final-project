import 'package:final_project/test/core/domain/repository/session_repository.dart';

final class LogoutUseCase {
  final SessionRepository sessionRepository;

  LogoutUseCase({required this.sessionRepository});

  Future<bool> invoke() {
    return sessionRepository.logout();
  }
}
