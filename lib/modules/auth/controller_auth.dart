part of "./auth.dart";

class AuthController extends GetxController {
  var username = TextEditingController().obs;
  var password = TextEditingController(text: "spisy10mobile").obs;
  var passwordConfirm = TextEditingController().obs;

  RxBool showPassword = false.obs;

  Future<void> validasiLogin() async {
    if (password.value.text != "spisy10mobile") {
      UtilsAlert.showToast("Password Salah");
    } else {
      AppData.usernameLogin = username.value.text;
      Routes.routeOff(type: "student");
    }
  }
}
