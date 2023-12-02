import 'package:sakura_test_bayuh/helper/local_storage.dart';

class AppData {
  static set usernameLogin(String value) =>
      LocalStorage.saveToDisk('usernameLogin', value);

  static String get usernameLogin {
    if (LocalStorage.getFromDisk('usernameLogin') != null) {
      return LocalStorage.getFromDisk('usernameLogin');
    }
    return "";
  }

  // CLEAR ALL DATA

  static void clearAllData() =>
      LocalStorage.removeFromDisk(null, clearAll: true);
}
