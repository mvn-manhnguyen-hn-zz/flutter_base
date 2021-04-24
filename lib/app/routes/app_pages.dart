import 'package:flutter_base/app/binding/get_password/get_password_binding.dart';
import 'package:flutter_base/app/binding/home/home_binding.dart';
import 'package:flutter_base/app/binding/login/login_binding.dart';
import 'package:flutter_base/app/binding/register/register_binding.dart';
import 'package:flutter_base/app/page/get_password/views/get_password_view.dart';
import 'package:flutter_base/app/page/home/views/home_view.dart';
import 'package:flutter_base/app/page/home/views/splash_view.dart';
import 'package:flutter_base/app/page/login/view/login.dart';
import 'package:flutter_base/app/page/register/views/register_view.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => Login(),
      binding: LoginBinding()
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding()
    ),
    GetPage(
        name: Routes.GETPASSWORD,
        page: () => GetPassword(),
        binding: GetPasswordBinding()
    ),
    GetPage(
        name: Routes.SPLASH,
        page: () => Splash(),
        binding: HomeBinding()
    ),
  ];
}
