import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/data/firebase_constant/constant.dart';
import 'package:flutter_base/data/model/bill_model.dart';
import 'package:get/get_rx/src/rx_core/rx_impl.dart';
import 'package:intl/intl.dart';

class BillController extends Controller {
  final idBill = Rx<String>();
  final billInformation = Rx<BillJson>();
  final rentedTime = Rx<String>();
  final returnTime = Rx<String>();
  final listBills = List<BillJson>();

  void getInformationBillDetails() {
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      bill
          .doc(idBill.value)
          .get()
          .then((DocumentSnapshot documentSnapshot){
        billInformation(BillJson.fromJson(documentSnapshot.data()));
        rentedTime(DateFormat('kk:mm  dd-MM-yyyy').format(billInformation.value.rentedTime.toDate()));
        returnTime(DateFormat('kk:mm  dd-MM-yyyy').format(billInformation.value.returnTime.toDate()));
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

  void getListBills() async {
    listBills.clear();
    await checkInternet();
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      bill
          .where('idUser', isEqualTo: user.currentUser.uid)
          .get()
          .then((value){
        value.docs.forEach((e){
          listBills.add(BillJson.fromJson(e.data()));
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
