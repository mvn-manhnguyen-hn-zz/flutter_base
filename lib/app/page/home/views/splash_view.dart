import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/home/home_controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:get/get.dart';

class Splash extends View {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends ViewState<Splash, HomeController> {

  @override
  void initState() {
    controller.nextToHome(
      callback: () => Get.offNamed(Routes.HOME)
    );
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Scaffold(
      body: Image(
        image: AssetImage('assets/logo.jpg'),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
