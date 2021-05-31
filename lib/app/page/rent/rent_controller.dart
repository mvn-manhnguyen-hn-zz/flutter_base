import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/data/firebase_constant/constant.dart';
import 'package:flutter_base/data/model/bill_model.dart';
import 'package:flutter_base/data/model/parking_lot_model.dart';
import 'package:flutter_base/data/model/user_state_model.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class RentController extends Controller {
  final idRentState = Rx<String>();
  final userStateInformation = Rx<UserStateJson>();
  final parkingLotInformation = Rx<ParkingLotJson>();
  final rentedTime = Rx<String>();
  final returnTime = Rx<String>();
  final price = Rx<int>();
  final returnTimeNew = Rx<DateTime>();
  final listRents = List<UserStateJson>();

  void getInformationStateRent() async {
    await checkInternet();
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      userState
          .doc(idRentState.value)
          .get()
          .then((DocumentSnapshot documentSnapshot){
        userStateInformation(UserStateJson.fromJson(documentSnapshot.data()));
        rentedTime(DateFormat('kk:mm  dd-MM-yyyy').format(userStateInformation.value.rentedTime.toDate()));
        returnTime(DateFormat('kk:mm  dd-MM-yyyy').format(userStateInformation.value.returnTime.toDate()));
        getInformationPL(userStateInformation.value.idPL);
        status(Status.success);
      }).catchError((e){
        status(Status.error);
        print('Error: $e');
      });
    } else {
      status(Status.error);
      showDialogAnnounce(
          content: 'Please check your internet!'
      );
    }
  }

  void getInformationPL(String idPL){
    parkingLot
        .doc(idPL)
        .get()
        .then((value){
      parkingLotInformation(ParkingLotJson.fromJson(value.data()));
    });
  }

  void getBill() async {
    await checkInternet();
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      final DateTime _now = DateTime.now();
      bill.add(
          BillJson(
            nameUser: userStateInformation.value.nameUser,
            idUser: userStateInformation.value.idUser,
            namePL: userStateInformation.value.namePL,
            addressPL: userStateInformation.value.addressPL,
            idPL: userStateInformation.value.idPL,
            rentedTime: userStateInformation.value.rentedTime,
            returnTime: Timestamp.fromDate(_now),
            phoneNumbersPL: userStateInformation.value.phoneNumbersPL,
          ).toJson()
      ).then((value2) async {
        await exceptPointPL(userStateInformation.value.idPL);
        await updateBill(userStateInformation.value.rentedTime, userStateInformation.value.returnTime, value2.id);
        await userState.doc(idRentState.value).delete().then((value3) => print('deleted'));
        status(Status.success);
        Get.offNamed(
            Routes.BILLDETAILS,
            arguments: value2.id
        );
      });
    } else {
      status(Status.error);
      showDialogAnnounce(
          content: 'Please check your internet!'
      );
    }
  }

  void updateBill(Timestamp rentTime, Timestamp returnTime, String idBill) async {
    await checkInternet();
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      final DateTime _now = DateTime.now();
      if (_now.isBefore(returnTime.toDate().add(Duration(minutes: 10)))){
        final _differentTime = _now.difference(rentTime.toDate());
        price(_differentTime.inHours*parkingLotInformation.value.price
            + ((_differentTime.inMinutes - _differentTime.inHours*60) > 10 ? 1 : 0)*parkingLotInformation.value.price);
        bill.doc(idBill).update(
            BillJson(
                idBill: idBill,
                price: price.value,
                timeUsed: _differentTime.inMinutes
            ).toJson()
        );
      } else {
        final _differentTime = returnTime.toDate().difference(rentTime.toDate());
        price(_differentTime.inHours*parkingLotInformation.value.price
            + ((_differentTime.inMinutes - _differentTime.inHours*60) > 10 ? 1 : 0)*parkingLotInformation.value.price);
        bill.doc(idBill).update(BillJson(
            idBill: idBill,
            price: price.value,
            penalty: parkingLotInformation.value.penalty,
            timeUsed: _differentTime.inMinutes,
            timeOverdue: _now.difference(returnTime.toDate()).inMinutes
        ).toJson());
      }
    } else {
      status(Status.error);
      showDialogAnnounce(
          content: 'Please check your internet!'
      );
    }
  }

  checkAddTime(context) {
    final DateTime _now = DateTime.now();
    if (_now.isBefore(userStateInformation.value.returnTime.toDate().subtract(Duration(minutes: 30)))){
      showMyDialog(context);
    } else {
      showDialogAnnounce(content: 'You must renew 30 minutes before the overdue');
    }
  }

  Future<void> showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter your end time'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
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
              onPressed: () => checkTimeChoose(),
            ),
          ],
        );
      },
    );
  }

  void checkTimeChoose() {
    if (returnTimeNew.value.isAfter(userStateInformation.value.returnTime.toDate().add(Duration(hours: 1)))){
      updateTime();
    } else {
      showDialogAnnounce(content: 'Rental time is at least 1 hour');
    }
  }

  void updateTime() async {
    await checkInternet();
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      userState
          .doc(idRentState.value)
          .update({
        'returnTime' : returnTimeNew.value
      }).then((value){
        Get.back();
        getInformationStateRent();
        status(Status.success);
      }).catchError((e){
        status(Status.error);
        print('Error: $e');
      });
    } else {
      status(Status.error);
      showDialogAnnounce(
          content: 'Please check your internet!'
      );
    }
  }

  Widget dateTimeFieldReturn() {
    return DateTimeField(
      format: DateFormat("dd-MM-yyyy HH:mm"),
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime:
            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          returnTimeNew(DateTimeField.combine(date, time));
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
    );
  }

  void getListRents() async {
    listRents.clear();
    await checkInternet();
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      userState
          .where('idUser', isEqualTo: user.currentUser.uid)
          .where('stateRent', isEqualTo: true)
          .get()
          .then((value){
        value.docs.forEach((e){
          listRents.add(UserStateJson.fromJson(e.data()));
        });
        status(Status.success);
      }).catchError((e){
        status(Status.error);
        print('Error: $e');
      });
    } else {
      status(Status.error);
      showDialogAnnounce(
          content: 'Please check your internet!'
      );
    }
  }
}
