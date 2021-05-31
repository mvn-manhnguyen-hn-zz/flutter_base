import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/data/firebase_constant/constant.dart';
import 'package:flutter_base/data/model/bill_model.dart';
import 'package:flutter_base/data/model/user_state_model.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_core/rx_impl.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class BookController extends Controller{
  final idBookState = Rx<String>();
  final userStateInformation = Rx<UserStateJson>();
  final rentedTime = Rx<String>();
  final returnTime = Rx<String>();
  final listBooks = List<UserStateJson>();

  void getInformationStateBooking() async {
    await checkInternet();
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      userState
          .doc(idBookState.value)
          .get()
          .then((DocumentSnapshot documentSnapshot){
        userStateInformation(UserStateJson.fromJson(documentSnapshot.data()));
        rentedTime(DateFormat('kk:mm  dd-MM-yyyy').format(userStateInformation.value.rentedTime.toDate()));
        returnTime(DateFormat('kk:mm  dd-MM-yyyy').format(userStateInformation.value.returnTime.toDate()));
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

  void checkConditionCancel() {
    final DateTime _now = DateTime.now();
    userState
        .doc(idBookState.value)
        .get()
        .then((value){
      UserStateJson _userState = UserStateJson.fromJson(value.data());
      if (_now.isAfter(_userState.rentedTime.toDate().add(Duration(minutes: 10)))){
        showDialogAnnounce(
            content: 'Your reservation has been canceled. You have to pay a deposit',
            onCancel: () => cancelPointWithDeposit()
        );
      } else {
        showDialogChoose(
            content: 'Are you sure to cancel this point?',
            textCancel: 'No',
            textConfirm: 'Yes',
            onConfirm: () => cancelPoint()
        );
      }
    });
  }

  void cancelPointWithDeposit() {
    exceptPointPL(userStateInformation.value.idPL);
    bill.add(
        BillJson(
            nameUser: userStateInformation.value.nameUser,
            idUser: userStateInformation.value.idUser,
            namePL: userStateInformation.value.namePL,
            addressPL: userStateInformation.value.addressPL,
            idPL: userStateInformation.value.idPL,
            rentedTime: userStateInformation.value.rentedTime,
            returnTime: userStateInformation.value.returnTime,
            phoneNumbersPL: userStateInformation.value.phoneNumbersPL,
            deposit: userStateInformation.value.deposit
        ).toJson()
    ).then((value2) async {
      await bill.doc(value2.id).update({
        'idBill' : value2.id
      });
      Get.back();
      await userState.doc(idBookState.value).delete().then((value3) => print('deleted'));
      // Get.offNamed(
      //     Routers.BILLDETAILS,
      //     arguments: value2.id
      // );
    });
  }

  void cancelPoint() async {
    await userState
        .doc(idBookState.value)
        .delete().then((value){
          Get.until((route) => Get.currentRoute == Routes.HOME);
    });
  }

  void rent() {
    final DateTime _now = DateTime.now();
    if (checkBookState(userStateInformation.value.rentedTime, _now)){
      userState
          .doc(idBookState.value)
          .update(
          UserStateJson(
              stateRent: true,
              rentedTime: Timestamp.fromDate(_now)
          ).toJson()
      ).then((value) async {
        await addPointPL(userStateInformation.value.idPL);
        Get.offNamed(
            Routes.RENTDETAILS,
            arguments: idBookState.value
        );
      });
    } else {
      if(compareTime(userStateInformation.value.rentedTime, _now)){
        showDialogAnnounce(
            content: 'You can\'t get this point too early'
        );
      } else {
        showDialogAnnounce(
            content: 'Your reservation has been canceled. You have to pay a deposit',
            onCancel: () => cancelPointWithDeposit()
        );
      }
    }
  }

  bool checkBookState(Timestamp rentedTime, DateTime now){
    if (now.isBefore(rentedTime.toDate().subtract(Duration(minutes: 10))) ||
        now.isAfter(rentedTime.toDate().add(Duration(minutes: 15)))){
      return false;
    } else {
      return true;
    }
  }

  bool compareTime(Timestamp rentedTime, DateTime now){
    if (now.isBefore(rentedTime.toDate().subtract(Duration(minutes: 10)))){
      return true;
    } else {
      return false;
    }
  }

  void getListBooks() async {
    listBooks.clear();
    await checkInternet();
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      userState
          .where('idUser', isEqualTo: user.currentUser.uid)
          .where('stateRent', isEqualTo: false)
          .get()
          .then((value){
        value.docs.forEach((e){
          listBooks.add(UserStateJson.fromJson(e.data()));
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
