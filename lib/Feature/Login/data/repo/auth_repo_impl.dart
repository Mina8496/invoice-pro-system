import 'package:invoicepro/Feature/Login/data/database/auth_local_data_source.dart';

import '../../domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthLocalDataSource local;

  AuthRepoImpl(this.local);

  @override
  Future<(bool, String)> login(String password) {
    return local.login(password);
  }
}