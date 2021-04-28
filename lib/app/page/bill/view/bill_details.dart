import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/bill/bill_controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';

class BillDetails extends View {
  @override
  _BillDetailsState createState() => _BillDetailsState();
}

class _BillDetailsState extends ViewState<BillDetails, BillController> {

  @override
  void initState() {
    controller.idBill(Get.arguments);
    controller.getInformationBillDetails();
    super.initState();
  }

  Widget typeBill(int deposit, int price, int penalty, int timeUsed, int timeOverdue){
    if (deposit != null){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text('Note: You didn\'t rent this point'),
          text('Total payment amount: $deposit k vnd'),
        ],
      );
    } else {
      if (penalty != null){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text('Time Used: ${timeUsed ~/ 60} hours ${timeUsed % 60} minutes'),
            text('Money rent: $price k vnd'),
            text('Time Overdue: ${timeOverdue ~/ 60} hours ${timeOverdue % 60} minutes'),
            text('Money penalty: $penalty k vnd'),
            text('Total: ${price + penalty} k vnd')
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text('Time Used: ${timeUsed ~/ 60} hours ${timeUsed % 60} minutes'),
            text('Money rent: $price k vnd'),
          ],
        );
      }
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
                'Bill details'
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.event_note),
                onPressed: () => Get.toNamed(Routes.LISTBILLS),
              )
            ],
          ),
          body: controller.billInformation.value.isNullOrBlank ? Container() :
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    text('Name customer: ${controller.billInformation.value.nameUser}'),
                    text('Name parking lot: ${controller.billInformation.value.namePL}'),
                    text(controller.billInformation.value.addressPL),
                    text('Phone numbers of PL: ${controller.billInformation.value.phoneNumbersPL.toString()}'),
                    text('From: ${controller.rentedTime.value}'),
                    text('To: ${controller.returnTime.value}'),
                    typeBill(
                        controller.billInformation.value.deposit,
                        controller.billInformation.value.price,
                        controller.billInformation.value.penalty,
                        controller.billInformation.value.timeUsed,
                        controller.billInformation.value.timeOverdue
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
            callback: () => controller.getInformationBillDetails()
        ) : Container()
      ],
    ));
  }
}
