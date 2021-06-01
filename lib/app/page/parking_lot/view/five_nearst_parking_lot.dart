import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/parking_lot/parking_lot_controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/data/model/parking_lot_model.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class FiveNearestPL extends View {
  @override
  _FiveNearestPLState createState() => _FiveNearestPLState();
}

class _FiveNearestPLState extends ViewState<FiveNearestPL, ParkingLotController> {
  List<ParkingLotJson> listPLArranged;

  @override
  void initState() {
    listPLArranged = Get.arguments;
    super.initState();
  }

  Widget text(String text, double size, Color color) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color),
    );
  }

  Widget listView() {
    return ListView.builder(
        itemCount: listPLArranged.isEmpty ? 0 : 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: new InkWell(
              onTap: () => Get.toNamed(
                  Routes.PARKINGLOT,
                  arguments: listPLArranged[index].id),
              child: Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    border: Border.all(
                        width: 3,
                        color: listPLArranged[index].statePL ? Colors.green : Colors.red
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      text(listPLArranged[index].namePL, 21, Colors.black),
                      text(listPLArranged[index].address, 16, Colors.grey),
                      text('Distance: ${listPLArranged[index].distance} km', 16, Colors.grey)
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '5 nearest parking lots'
        ),
      ),
      body: listView(),
    );
  }
}
