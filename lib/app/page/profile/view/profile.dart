import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/profile/profile_controller.dart';
import 'package:flutter_base/app/page/profile/view/email.dart';
import 'package:flutter_base/app/page/profile/view/information.dart';
import 'package:flutter_base/app/page/profile/view/password.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';

class Profile extends View {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends ViewState<Profile, ProfileController> {

  @override
  void initState() {
    controller.getUserInformation();
    super.initState();
  }

  final List<Widget> widgetOption = <Widget>[
    Information(),
    Password(),
    Email(),
  ];

  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Obx(() => Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: widgetOption.elementAt(controller.selectedIndex.value),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Information'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.lock_outline),
                  label: 'Password'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.email),
                  label: 'Email'
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: Colors.red,
            onTap: (index) => controller.onItemTapped(index),
            backgroundColor: Colors.blue,
            type: BottomNavigationBarType.fixed,
          ),
        ),
        loading(
            status: controller.status.value,
            context: context
        ),
        controller.status.value == Status.error ? buttonError(
            callback: () => controller.getUserInformation()
        ) : Container()
      ],
    ));
  }
}
