import 'package:flutter_base/app/binding/bill/bill_binding.dart';
import 'package:flutter_base/app/binding/book/book_binding.dart';
import 'package:flutter_base/app/binding/get_password/get_password_binding.dart';
import 'package:flutter_base/app/binding/home/home_binding.dart';
import 'package:flutter_base/app/binding/login/login_binding.dart';
import 'package:flutter_base/app/binding/parking_lot/parking_lot_binding.dart';
import 'package:flutter_base/app/binding/profile/profile_binding.dart';
import 'package:flutter_base/app/binding/register/register_binding.dart';
import 'package:flutter_base/app/binding/rent/rent_binding.dart';
import 'package:flutter_base/app/page/bill/view/bill_details.dart';
import 'package:flutter_base/app/page/bill/view/list_bills.dart';
import 'package:flutter_base/app/page/book/view/book_details.dart';
import 'package:flutter_base/app/page/book/view/list_books.dart';
import 'package:flutter_base/app/page/get_password/views/get_password_view.dart';
import 'package:flutter_base/app/page/home/views/home_view.dart';
import 'package:flutter_base/app/page/home/views/splash_view.dart';
import 'package:flutter_base/app/page/login/view/login.dart';
import 'package:flutter_base/app/page/parking_lot/view/five_nearst_parking_lot.dart';
import 'package:flutter_base/app/page/parking_lot/view/parking_lot.dart';
import 'package:flutter_base/app/page/parking_lot/view/state_parking_lot.dart';
import 'package:flutter_base/app/page/profile/view/profile.dart';
import 'package:flutter_base/app/page/register/views/register_view.dart';
import 'package:flutter_base/app/page/rent/view/list_rent.dart';
import 'package:flutter_base/app/page/rent/view/rent_details.dart';
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
    GetPage(
        name: Routes.PARKINGLOT,
        page: () => ParkingLot(),
        binding: ParkingLotBinding()
    ),
    GetPage(
        name: Routes.FIVENEARESTPARKINGLOTS,
        page: () => FiveNearestPL(),
        binding: ParkingLotBinding()
    ),
    GetPage(
        name: Routes.STATEPL,
        page: () => StatePL(),
        binding: ParkingLotBinding()
    ),
    GetPage(
        name: Routes.RENTDETAILS,
        page: () => RentDetails(),
        binding: RentBinding()
    ),
    GetPage(
        name: Routes.LISTRENTS,
        page: () => ListRents(),
        binding: RentBinding()
    ),
    GetPage(
        name: Routes.BOOKDETAILS,
        page: () => BookDetails(),
        binding: BookBinding()
    ),
    GetPage(
        name: Routes.LISTBOOKS,
        page: () => ListBooks(),
        binding: BookBinding()
    ),
    GetPage(
        name: Routes.BILLDETAILS,
        page: () => BillDetails(),
        binding: BillBinding()
    ),
    GetPage(
        name: Routes.LISTBILLS,
        page: () => ListBills(),
        binding: BillBinding()
    ),
    GetPage(
        name: Routes.PROFILE,
        page: () => Profile(),
        binding: ProfileBinding()
    ),
  ];
}
