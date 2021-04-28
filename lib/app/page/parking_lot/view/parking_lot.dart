import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/parking_lot/parking_lot_controller.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class ParkingLot extends View {

  @override
  _ParkingLotState createState() => _ParkingLotState();
}

class _ParkingLotState extends ViewState<ParkingLot, ParkingLotController> {

  @override
  void initState() {
    controller.idPL(Get.arguments);
    controller.getInformationPL();
    super.initState();
  }

  Widget dateTimeFieldRent(){
    return DateTimeField(
      format: controller.format.value,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(2015),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2025));
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime:
            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          controller.rentedTime(DateTimeField.combine(date, time));
          // rentedTime = DateTimeField.combine(date, time);
          // print(rentedTime);
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
    );
  }

  Widget dateTimeFieldReturn(){
    return DateTimeField(
      format: controller.format.value,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(2015),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2025));
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime:
            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          controller.returnTime(DateTimeField.combine(date, time));
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose your rental period'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Start time'),
                dateTimeFieldRent(),
                Text('End time'),
                dateTimeFieldReturn()
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              color: Colors.green,
              child: Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            RaisedButton(
              color: Colors.green,
              child: Text('Approve'),
              onPressed: () {
                controller.checkTimeChoose();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Obx(() => Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
                'Parking lot'
            ),
          ),
          body: controller.parkingLotInformation.value.isNullOrBlank ?
          Container() :
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    text(controller.parkingLotInformation.value.namePL),
                    text(controller.parkingLotInformation.value.address),
                    richText(
                        text1: 'Parking lot\'s phone number: ',
                        text2: '${controller.parkingLotInformation.value.numberPhone}'
                    ),
                    richText(
                        text1: 'Price per hour rental: ',
                        text2: '${controller.parkingLotInformation.value.price}k vnd'
                    ),
                    richText(
                        text1: 'Overdue penalty price: ',
                        text2: '${controller.parkingLotInformation.value.penalty}k vnd'
                    ),
                    richText(
                        text1: 'Booking price: ',
                        text2: '${controller.parkingLotInformation.value.price}k vnd'
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Center(
                        child: RaisedButton(
                          color: Colors.green,
                          onPressed: _showMyDialog,
                          child: Text(
                              'Choose the rental period'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        loading(
            status: controller.status.value,
            context: context
        ),
        controller.status.value == Status.error ? buttonError(
          callback: () => controller.getInformationPL()
        ) : Container()
      ],
    ));
  }
}

