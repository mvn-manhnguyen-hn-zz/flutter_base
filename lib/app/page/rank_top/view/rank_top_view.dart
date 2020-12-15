// ignore: implementation_imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/rank_top/rank_top_controller.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';

class RankTopView extends View {
  @override
  _RankTopViewState createState() => _RankTopViewState();
}

class _RankTopViewState extends ViewState<RankTopView, RankTopController> {
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
              itemCount: controller.thisArg.value.length,
              itemBuilder: (context, index){
                return ListTile(
                  leading: textInformation(index.toString()),
                  title: textInformation(
                      controller.thisArg.value[index].name.toString()
                  ),
                  subtitle: textInformation(controller.thisArg.value[index].total.toString()),
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
