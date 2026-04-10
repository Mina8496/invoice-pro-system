import 'package:get/get.dart';
import 'package:invoicepro/Feature/Login/data/database/auth_local_data_source.dart';
import 'package:invoicepro/Feature/Login/data/repo/auth_repo_impl.dart';
import 'package:invoicepro/Feature/Login/domain/repo/auth_repo.dart';
import 'package:invoicepro/Feature/Login/domain/usecase/login_usecase.dart';
import 'package:invoicepro/Feature/Login/presentation/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthLocalDataSource>(() => AuthLocalDataSource());

    Get.lazyPut<AuthRepo>(() => AuthRepoImpl(Get.find<AuthLocalDataSource>()));

    Get.lazyPut<LoginUseCase>(() => LoginUseCase(Get.find<AuthRepo>()));

    Get.lazyPut<LoginController>(
      () => LoginController(Get.find<LoginUseCase>()),
    );
  }
}
