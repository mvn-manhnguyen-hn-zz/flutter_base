import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/view.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class HomeView extends ViewStateLess<HomeController> {
  @override
  Future<bool> willPopCallBack() {
    // TODO: implement willPopCallBack
    return super.willPopCallBack();
  }

  @override
  Widget buildPage(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.linearToSrgbGamma(),
          image: NetworkImage(
              "https://images.pexels.com/photos/3902882/pexels-photo-3902882.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Corona Virus"),
          backgroundColor: Colors.white10,
          elevation: 0,
          centerTitle: true,
        ),
        body: Center(
          child: Obx(
            () {
              final status = controller.status.value;
              if (status == Status.loading) return CircularProgressIndicator();
              if (status == Status.error) return Text('Error on connection :(');
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    "Total Confirmed",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    '${controller.cases.value.global.totalConfirmed}',
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Total Deaths",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    '${controller.cases.value.global.totalDeaths}',
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
