import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/data/firebase_constant/constant.dart';
import 'package:flutter_base/data/model/parking_lot_model.dart';
import 'package:flutter_base/data/model/user_model.dart';
import 'package:flutter_base/data/model/user_state_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ParkingLotController extends Controller {
  final idPL = Rx<String>();
  final parkingLotInformation = Rx<ParkingLotJson>();
  final rentedTime = Rx<DateTime>();
  final returnTime = Rx<DateTime>();
  final format = DateFormat("dd-MM-yyyy HH:mm").obs;
  final userInformation = Rx<UserJson>();
  final pointsUsed = 0.obs;
  final listPLArranged = List<ParkingLotJson>();

  Future<void> getListPLArranged() async {
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      try {
        await parkingLot
            .orderBy('distance')
            .get()
            .then((value) {
          value.docs.forEach((element) {
            listPLArranged.add(ParkingLotJson.fromJson(element.data()));
          });
        }).then((value) => status(Status.success));
      } catch (error) {
        print('error: $error');
        status(Status.error);
        throw(error);
      }
    } else {
      status(Status.error);
      showDialogAnnounce(
          content: 'Please check your internet!'
      );
    }
  }

  void getInformationPL() async {
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      parkingLot
      .doc(idPL.toString())
      .get()
          .then((DocumentSnapshot documentSnapshot){
            parkingLotInformation(ParkingLotJson.fromJson(documentSnapshot.data()));
            getInformationUser();
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

  void getInformationUser() {
    users
        .doc(user.currentUser.uid)
        .get()
        .then((value){
      userInformation(UserJson.fromJson(value.data()));
    });
  }

  checkTimeChoose() async {
    pointsUsed(0);
    final DateTime _now = DateTime.now();
    if (rentedTime.value != null && rentedTime.value != null){
      if (rentedTime.value.isBefore(_now.subtract(Duration(minutes: 5)))){
        showDialogAnnounce(
            content: 'You have hire the time after now'
        );
      } else {
        if (returnTime.value.isBefore(rentedTime.value.add(Duration(hours: 1)))){
          showDialogAnnounce(
              content: 'You have hired at least one hours'
          );
        } else {
          makeArgument();
        }
      }
    } else {
      showDialogAnnounce(
          content: 'You have choose your time'
      );
    }
  }

  Future<void> makeArgument() async {
    Get.back();
    await userState
        .where('idPL', isEqualTo: idPL.toString())
        .get()
        .then((value){
      value.docs.forEach((element) {
        final UserStateJson userStateJson = UserStateJson.fromJson(element.data());
        if (rentedTime.value.isAfter(userStateJson.rentedTime.toDate().add(Duration(minutes: 20))) ||
            returnTime.value.isBefore(userStateJson.rentedTime.toDate().subtract(Duration(minutes: 20)))
        ){
          /// don't do anything :))
        } else {
          pointsUsed(pointsUsed.value + 1);
        }
      });
    });
    Get.toNamed(Routes.STATEPL);
  }

  void checkBooking() {
    if (parkingLotInformation.value.totalPoints == pointsUsed.value){
      showDialogAnnounce(
          content: 'Sorry, there aren\'t not any empty points'
      );
    } else {
      updateBooking();
    }
  }

  Future<void> updateBooking() async {
    status(Status.loading);
    await userState
        .add(
        UserStateJson(
            nameUser: userInformation.value.name,
            idUser: user.currentUser.uid,
            namePL: parkingLotInformation.value.namePL,
            addressPL: parkingLotInformation.value.address,
            idPL: idPL.value,
            rentedTime: Timestamp.fromDate(rentedTime.value),
            returnTime: Timestamp.fromDate(returnTime.value),
            phoneNumbersPL: parkingLotInformation.value.numberPhone,
            deposit: parkingLotInformation.value.deposit,
            price: parkingLotInformation.value.price,
            penalty: parkingLotInformation.value.penalty,
            stateRent: false,
            notUsed: false
        ).toJson()
    ).then((value) async {
      await userState.doc(value.id).update({'idUserState' : value.id});
      status(Status.success);
      Get.offNamed(
          Routes.BOOKDETAILS,
          arguments: value.id
      );
    });
  }
}
