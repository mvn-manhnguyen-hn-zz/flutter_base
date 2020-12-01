
import 'package:flutter_base/app/binding/home_binding.dart';
import 'package:flutter_base/app/page/home/views/country_view.dart';
import 'package:flutter_base/app/page/home/views/details_view.dart';
import 'package:flutter_base/app/page/home/views/home_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.COUNTRY,
      page: () => CountryView(),
    ),
    GetPage(
      name: Routes.DETAILS,
      page: () => DetailsView(),
    ),
  ];
}
