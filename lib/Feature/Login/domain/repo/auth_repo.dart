abstract class AuthRepo {
  Future<(bool, String)> login(String password);
}