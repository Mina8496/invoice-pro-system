import 'package:invoicepro/core/database/database_helper.dart';
import 'package:invoicepro/Feature/Invoice/presentation/manger/getDeviceId.dart';

class AuthLocalDataSource {
  static const String mainPassword = "12345678";
  static const String trialPassword = "123456";

  Future<(bool, String)> login(String password) async {
    if (password.isEmpty) {
      return (false, "ادخل كلمة المرور");
    }

    if (password == mainPassword) {
      return (true, "");
    }

    if (password == trialPassword) {
      return await _handleTrial();
    }

    return (false, "كلمة المرور غير صحيحة");
  }

  Future<(bool, String)> _handleTrial() async {
    await DatabaseHelper.ensureTrialTable();

    final deviceId = await getDeviceId();
    final trial = await DatabaseHelper.getTrial();

    if (trial == null) {
      await DatabaseHelper.insertTrial(
        deviceId,
        DateTime.now().toIso8601String(),
      );
      return (true, "تم تفعيل");
    }

    final savedDeviceId = trial['device_id'];
    final startDate = DateTime.parse(trial['start_date']);

    if (savedDeviceId != deviceId) {
      return (false, "غير مسموح على جهاز آخر");
    }

    if (DateTime.now().isBefore(startDate)) {
      return (false, "تم التلاعب بتاريخ الجهاز");
    }

    final daysPassed = DateTime.now().difference(startDate).inDays;

    if (daysPassed < 30) {
      return (true, "");
    }

    return (false, "انتهت التجربة بحاجة الى طلب استخدام مساحة");
  }
}
