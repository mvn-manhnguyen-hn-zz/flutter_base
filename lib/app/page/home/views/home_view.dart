import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/home/home_controller.dart';
import 'package:flutter_base/app/page/home/views/invoice_view.dart';
import 'package:flutter_base/app/page/home/views/profile_view.dart';
import 'package:flutter_base/app/page/home/views/rank_top_view.dart';
import 'package:flutter_base/app/page/home/views/shop_view.dart';
import 'package:flutter_base/app/widgets/colors.dart';
import 'package:get/get.dart';

class HomeView extends View {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  final List<Widget> _widgetOptions = <Widget>[
    ShopView(),
    InvoiceView(),
    RankTopView(),
    ProfileView()
  ];

  @override
  Widget buildPage(context) {
    return Obx(() => Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(controller.selectIndex.value),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Cửa hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment_outlined),
            label: 'Xếp hạng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Cá nhân',
          ),
        ],
        currentIndex: controller.selectIndex.value,
        selectedItemColor: butterscotch,
        onTap: (index){
          controller.onItemTapped(index);
        },
        type: BottomNavigationBarType.fixed,
      ),
    ));
  }
}
