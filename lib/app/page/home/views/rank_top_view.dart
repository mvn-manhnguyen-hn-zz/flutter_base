// ignore: implementation_imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/home/home_controller.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';

class RankTopView extends View {
  @override
  _RankTopViewState createState() => _RankTopViewState();
}

class _RankTopViewState extends ViewState<RankTopView, HomeController> {
  @override
  void initState() {
    controller.fetchRankTopData();
    super.initState();
  }
  @override
  Widget buildPage(BuildContext context) {
    return Obx(() => Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Xếp hạng'),
          ),
          body: ListView.builder(
              itemCount: controller.thisArg.length,
              itemBuilder: (context, index){
                return ListTile(
                  leading: textInformation((index + 1).toString()),
                  title: textInformation(
                      controller.thisArg[index].name.toString()
                  ),
                  subtitle: textInformation(controller.thisArg[index].total.toString()),
                );
              }
          ),
        ),
        loading(
            status: controller.status.value,
            context: context)
      ],
    ));
  }
}
