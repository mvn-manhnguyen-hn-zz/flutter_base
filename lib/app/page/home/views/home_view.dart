import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/home/home_controller.dart';

import 'package:flutter_base/app/page/home/views/store_view.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';

class HomeView extends View {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  @override
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    StoreView(),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
    ),
    Text(
      'Index 3: School',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget buildPage(context) {
    return Obx(() => Stack(
          children: [
            Scaffold(
              body: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.store,
                    ),
                    label: 'Cửa hàng',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt),
                    label: 'Đơn hàng',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.stars),
                    label: 'Xếp hạng',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Cá nhân',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Color(0xff7C4DFF),
                unselectedItemColor: Color(0xff9b9999),
                onTap: _onItemTapped,
              ),
            ),
            loading(status: controller.status.value, context: context)
          ],
        ));
  }
}
