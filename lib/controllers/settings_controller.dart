import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxBool isDark = false.obs;
  RxBool autoScan = true.obs;

  void changeTheme() {
    if (isDark.value == true) {
      isDark.value = false;
    } else {
      isDark.value = true;
    }
  }

  void changeAutoScan() {
    if (autoScan.value == true) {
      autoScan.value = false;
    } else {
      autoScan.value = true;
    }
  }
}
