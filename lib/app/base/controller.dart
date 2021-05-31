import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/data/firebase_constant/constant.dart';
import 'package:flutter_base/data/model/parking_lot_model.dart';
import 'package:flutter_base/data/model/user_state_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

enum Status { loading, success, error }
enum ConnectInternet { valid, invalid}

abstract class Controller extends GetxController {
  StreamSubscription<ConnectivityResult> subscription;
  final status = Status.loading.obs;
  final connect = ConnectInternet.valid.obs;

  void listenConnectivityStatus() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
  }

  void cancelConnectivitySubscription() {
    subscription.cancel();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        connect(ConnectInternet.valid);
        printInfo(info: 'ConnectivityResult.wifi');
        break;

      case ConnectivityResult.mobile:
        connect(ConnectInternet.valid);
        printInfo(info: 'ConnectivityResult.mobile');
        break;

      case ConnectivityResult.none:
        connect(ConnectInternet.invalid);
        printInfo(info: 'ConnectivityResult.none');
        break;
    }
  }

  Future<void> checkInternet() async {
    const url = 'https://www.youtube.com/';
    await http.get(url).then((value) async {
      print('internet ok');
      connect(ConnectInternet.valid);
    })
        .catchError((e){
      connect(ConnectInternet.invalid);
      showDialogAnnounce(
          content: 'Please check your internet!'
      );
    });
    status(Status.success);
  }

  void addParkingLot(){
    parkingLot
        .doc('N010')
        .update(
        ParkingLotJson(
            id: 'N010',
            namePL: 'Bãi đỗ học viện an ninh',
            address: '125 Trần Phú, P. Văn Quán, Hà Đông, Hà Nội',
            location: GeoPoint(20.982111, 105.791551),
            price: 12,
            penalty: 250,
            deposit: 60,
            numberPhone: 1010101010,
            totalPoints: 13
        ).toJson()
    ); // Học viện an ninh
    parkingLot
        .doc('N009')
        .update(
        ParkingLotJson(
            id: 'N009',
            namePL: 'Bãi đỗ cao đẳng dược Hà Nội',
            address: 'Số 1 Hoàng Đạo Thúy, Nhân Chính, Thanh Xuân, Hà Nội',
            location: GeoPoint(21.005877, 105.803955),
            price: 17,
            penalty: 22,
            deposit: 130,
            numberPhone: 9999999999,
            totalPoints: 25
        ).toJson()
    ); // Cao đẳng dược Hà Nội
    parkingLot
        .doc('N008')
        .update(
        ParkingLotJson(
            id: 'N008',
            namePL: 'Bãi đỗ đại học công nghiệp',
            address: 'Đường Cầu Diễn, Minh Khai, Bắc Từ Liêm, Hà Nội, Việt Nam',
            location: GeoPoint(21.054660, 105.735153),
            price: 14,
            penalty: 150,
            deposit: 50,
            numberPhone: 8888888888,
            totalPoints: 17
        ).toJson()
    ); // Đại học công nghiệp
    parkingLot
        .doc('N007')
        .update(
        ParkingLotJson(
            id: 'N007',
            namePL: 'Bãi đỗ học viện ngoại giao',
            address: 'Số 69 Chùa Láng, Láng Thượng, Đống Đa, Hà Nội, Việt Nam',
            location: GeoPoint(21.023254, 105.806488),
            price: 15,
            penalty: 200,
            deposit: 50,
            numberPhone: 7777777777,
            totalPoints: 5
        ).toJson()
    ); // Học viện ngoại giao
    parkingLot
        .doc('N006')
        .update(
        ParkingLotJson(
            id: 'N006',
            namePL: 'Bãi đỗ kinh tế quốc dân',
            address: '207 Giải Phóng, Đồng Tâm, Hai Bà Trưng, Hà Nội, Việt Nam',
            location: GeoPoint(21.037313, 105.788925),
            price: 15,
            penalty: 45,
            deposit: 20,
            numberPhone: 6666666666,
            totalPoints: 7
        ).toJson()
    ); // Đại học kinh tế quốc dân
    parkingLot
        .doc('N005')
        .update(
        ParkingLotJson(
            id: 'N005',
            namePL: 'Bãi đỗ đại học thăng long',
            address: 'Số 12 Chùa Bộc, Quang Trung, Đống Đa, Hà Nội',
            location: GeoPoint(20.976086, 105.815529),
            price: 15,
            penalty: 30,
            deposit: 400,
            numberPhone: 5555555555,
            totalPoints: 20
        ).toJson()
    ); // Đại học Thăng Long
    parkingLot
        .doc('N004')
        .update(
        ParkingLotJson(
            id: 'N004',
            namePL: 'Bãi đỗ đại học Hà Nội',
            address: 'Km 9 Nguyễn Trãi, P. Văn Quán, Hà Đông, Hà Nội, Việt Nam',
            location: GeoPoint(20.989433, 105.795311),
            price: 15,
            penalty: 30,
            deposit: 20,
            numberPhone: 4444444444,
            totalPoints: 12
        ).toJson()
    ); // Đại học Hà Nội
    parkingLot
        .doc('N003')
        .update(
        ParkingLotJson(
            id: 'N003',
            namePL: 'Bãi đỗ học viện báo chí và tuyên truyền',
            address: '36 Xuân Thủy, Dịch Vọng Hậu, Cầu Giấy, Hà Nội, Việt Nam',
            location: GeoPoint(21.037313, 105.788925),
            price: 12,
            penalty: 50,
            deposit: 34,
            numberPhone: 3333333333,
            totalPoints: 17
        ).toJson()
    ); // Học viện báo chí và tuyên truyền
    parkingLot
        .doc('N002')
        .update(
        ParkingLotJson(
            id: 'N002',
            namePL: 'Bãi đỗ học viện ngân hàng',
            address: 'Số 12 Chùa Bộc, Quang Trung, Đống Đa, Hà Nội',
            location: GeoPoint(21.009023, 105.828590),
            price: 13,
            penalty: 30,
            deposit: 25,
            numberPhone: 2222222222,
            totalPoints: 23
        ).toJson()
    ); // Học viện ngân hàng
    parkingLot
        .doc('N001')
        .update(
        ParkingLotJson(
            id: 'N001',
            namePL: 'Bãi đỗ bách khoa',
            address: 'Số 1, Đại Cồ Việt, Hai bà Trưng, Hà Nội',
            location: GeoPoint(21.007235, 105.843125),
            price: 10,
            penalty: 30,
            deposit: 20,
            numberPhone: 111111111,
            totalPoints: 50
        ).toJson()
    ); // Bãi đỗ Bách Khoa
    addPointsUsed();
  }

  void addPointsUsed(){
    parkingLot
        .get()
        .then((value){
      value.docs.forEach((element) {
        if (element.data()['pointsUsed'] == null){
          parkingLot.doc(element.id).update(
              {'pointsUsed' : 0}
          );
        }
      });
    });
  }

  void checkCurrentState(){
    parkingLot
        .get()
        .then((value){
      value.docs.forEach((element) {
        final ParkingLotJson parkingLotJson = ParkingLotJson.fromJson(element.data());
        if (parkingLotJson.totalPoints > parkingLotJson.pointsUsed){
          parkingLot.doc(parkingLotJson.id).update({
            'statePL' : true
          });
        } else {
          parkingLot.doc(parkingLotJson.id).update({
            'statePL' : false
          });
        }
      });
    });
  }

  void checkReservation(){
    final DateTime _now = DateTime.now();
    userState
        .get()
        .then((value){
      value.docs.forEach((element) async {
        var _userState = UserStateJson.fromJson(element.data());
        if (
        (!_userState.notUsed) &&
            (!_userState.stateRent) &&
            (_now.isAfter(_userState.rentedTime.toDate().add(Duration(minutes: 15))))
        ){
          exceptPointPL(_userState.idPL);
          await userState.doc(element.id).update({'notUsed' : true});
        } else if (
        (_now.isAfter(_userState.returnTime.toDate().add(Duration(minutes: 10)))) &&
            (!_userState.notUsed) && (_userState.stateRent)
        ){
          exceptPointPL(_userState.idPL);
          await userState.doc(element.id).update({'notUsed' : true});
        }
      });
    });
  }

  void exceptPointPL(String idPL){
    parkingLot
        .doc(idPL)
        .get()
        .then((value){
      parkingLot.doc(idPL).update({
        'pointsUsed' : value.data()['pointsUsed'] - 1
      });
    });
  }

  void addPointPL(String idPL){
    parkingLot
        .doc(idPL)
        .get()
        .then((value){
      parkingLot.doc(idPL).update({
        'pointsUsed' : value.data()['pointsUsed'] + 1
      });
    });
  }
}
