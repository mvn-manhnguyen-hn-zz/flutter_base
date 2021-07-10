import 'package:flutter/widgets.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:get/get.dart';

import 'binding/main_binding.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MainBinding(),
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      smartManagement: SmartManagement.keepFactory,
    );
  }
}
