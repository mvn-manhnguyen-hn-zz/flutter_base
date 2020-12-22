import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/home/home_controller.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';

class HomeView extends View {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  @override
  void initState() {
    super.initState();
    controller.fetchListShop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget buildPage(context) {
    return Obx(() => Stack(
          children: [
            Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text('Title tu sua nhe'),
                ),
                body: ListView.builder(
                    itemCount: controller.listShop.length,
                    itemBuilder: (context, index) {
                      return Text(controller.listShop[index].name);
                    })),
            loading(
                status: controller.status.value,
                context: context)
          ],
        ));
  }
}
