import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/rent/rent_controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';

class RentDetails extends View {
  @override
  _RentDetailsState createState() => _RentDetailsState();
}

class _RentDetailsState extends ViewState<RentDetails, RentController> {

  @override
  // ignore: must_call_super
  void initState() {
    controller.idRentState(Get.arguments);
    controller.getInformationStateRent();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Rental details'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () => Get.until((route) => Get.currentRoute == Routes.HOME),
                ),
              )
            ],
          ),
          body: controller.userStateInformation.value.isNullOrBlank ? Container() :
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    text('Name customer: ${controller.userStateInformation.value.nameUser}'),
                    text('Name parking lot: ${controller.userStateInformation.value.namePL}'),
                    text(controller.userStateInformation.value.addressPL),
                    text('Phone numbers of PL: ${controller.userStateInformation.value.phoneNumbersPL.toString()}'),
                    text('From: ${controller.rentedTime.value}'),
                    text('To: ${controller.returnTime.value}'),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            onPressed: () => controller.getBill(),
                            child: text('Get Bill'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              color: Colors.green,
                              onPressed: () => controller.checkAddTime(context),
                              child: text('Add time'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        loading(
            status: controller.status.value,
            context: context
        ),
        controller.status.value == Status.error ? buttonError(
            callback: () => controller.getInformationStateRent()
        ) : Container()
      ],
    ));
  }
}
