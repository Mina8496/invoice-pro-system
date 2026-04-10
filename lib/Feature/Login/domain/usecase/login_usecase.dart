import '../repo/auth_repo.dart';

class LoginUseCase {
  final AuthRepo repo;

  LoginUseCase(this.repo);

  Future<(bool, String)> call(String password) {
    return repo.login(password);
  }
}