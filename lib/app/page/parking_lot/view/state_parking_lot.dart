import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/parking_lot/parking_lot_controller.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';

class StatePL extends View {
  @override
  _StatePLState createState() => _StatePLState();
}

class _StatePLState extends ViewState<StatePL, ParkingLotController> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget container({
    String content,
    int number
  }){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(
                width: 3,
                color: Colors.green
            )
        ),
        child: Column(
          children: [
            text(content),
            text(number.toString())
          ],
        ),
      ),
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('State parking lot'),
            leading: Container(),
          ),
          body: ListView(
            children: [
              container(
                  content: 'Total points are empty',
                  number: controller.parkingLotInformation.value.totalPoints - controller.pointsUsed.value
              ),
              container(
                  content: 'Total points are used',
                  number: controller.pointsUsed.value
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      color: Colors.green,
                      onPressed: () => Get.back(),
                      child: Text('Back'),
                    ),
                    SizedBox(width: 20),
                    RaisedButton(
                      color: Colors.green,
                      onPressed: () => controller.checkBooking(),
                      child: Text('Book'),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
