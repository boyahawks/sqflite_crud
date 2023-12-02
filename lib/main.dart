import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakura_test_bayuh/helper/appdata.dart';
import 'package:sakura_test_bayuh/helper/local_storage.dart';
import 'package:sakura_test_bayuh/helper/routes.dart';
import 'package:sakura_test_bayuh/helper/utility.dart';
import 'package:sakura_test_bayuh/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage.prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'SAKURA-APP',
        theme: ThemeData(
          fontFamily: 'InterRegular',
        ),
        locale: Get.deviceLocale,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadingNextRoute();
    super.initState();
  }

  void loadingNextRoute() async {
    // CHECK DATABASE

    String usernameLogin = AppData.usernameLogin;

    if (usernameLogin.isEmpty) {
      await Future.delayed(const Duration(seconds: 3));
      Routes.routeOff(type: "login");
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Routes.routeOff(type: "student");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      type: "default",
      colorBackground: Utility.baseColor2,
      colorSafeArea: Utility.baseColor2,
      returnOnWillpop: false,
      content: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage('assets/bg_login.jpg'),
                  fit: BoxFit.fill),
            ),
          ),
          Column(
            children: [
              const Expanded(flex: 30, child: SizedBox()),
              Expanded(
                  flex: 40,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextLabel(
                          text: "Sakura System Solutions",
                          size: Utility.extraLarge,
                          color: Utility.maincolor1,
                        ),
                        SizedBox(
                          height: Utility.small,
                        ),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Utility.maincolor1,
                          ),
                        )
                      ],
                    ),
                  )),
              const Expanded(flex: 30, child: SizedBox())
            ],
          )
        ],
      ),
    );
  }
}
