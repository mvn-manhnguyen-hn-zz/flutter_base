import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/data/destination/destination_data.dart';
import 'package:flutter_base/data/firebase_constant/constant.dart';
import 'package:flutter_base/data/model/parking_lot_model.dart';
import 'package:flutter_base/data/model/user_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends Controller {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  final Completer<GoogleMapController> mapController = Completer();
  final visible = false.obs;
  final name = Rx<String>();
  final numberPhone = Rx<String>();
  final chooseDestination = Rx<String>();
  final allMarkers = List<Marker>();
  final parkingLotFull = Rx<BitmapDescriptor>();
  final parkingLotNotFull = Rx<BitmapDescriptor>();
  final myLocation = Rx<BitmapDescriptor>();
  final currentPosition = Rx<Position>();
  final textSearch = Rx<String>();
  final listSearch = List<String>();

  List<ParkingLotJson> listPL = [];

  Future<void> nextToHome({VoidCallback callback}) async {
    await checkCurrentState();
    await checkReservation();
    Future.delayed(
        Duration(milliseconds: 2000),
            () => callback()
    );
  }

  void toggle() => visible(!visible.value);

  void getInformation() {
    users
        .doc(user.currentUser.uid)
        .get()
        .then((value){
      var _user = UserJson.fromJson(value.data());
      name(_user.name);
      numberPhone(_user.numberPhone);
    });
    parkingLot
    .get()
    .then((value){
      value.docs.forEach((e) {
        listPL.add(ParkingLotJson.fromJson(e.data()));
      });
    });
  }

  void announceCancelPoint() {
    userState
        .where('idUser', isEqualTo: user.currentUser.uid)
        .where('notUsed', isEqualTo: true)
        .get()
        .then((value){
      if (value.docs.length > 0){
        showDialogAnnounce(content: 'Your state was deleted');
      }
    });
  }

  void getMarkers() async {
    parkingLot
        .get()
        .then((QuerySnapshot querySnapshot){
      querySnapshot.docs.forEach((doc) {
        var _parkingLot = ParkingLotJson.fromJson(doc.data());
        if(_parkingLot.location != null) {
          allMarkers.add(Marker(
            markerId: MarkerId(doc.id),
            icon: _parkingLot.statePL ? parkingLotNotFull.value : parkingLotFull.value,
            onTap: (){
              Get.toNamed(Routes.PARKINGLOT, arguments: doc.id);
            },
            position: LatLng(_parkingLot.location.latitude, _parkingLot.location.longitude),
            infoWindow: InfoWindow(
                title: _parkingLot.namePL,
                snippet: _parkingLot.address
            ),
          ));
        }
      });
    });
  }

  void getCurrentLocation() async {
    if (currentPosition.value == null){
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position){
        currentPosition(position);
        destinationData.forEach((element) {
          if (element.name == 'My location') {
            element.location = GeoPoint(position.latitude, position.longitude);
          }
        });
      });
    } else {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentPosition.value.latitude, currentPosition.value.longitude);
    }
  }

  void moveToMyLocation() async {
    final GoogleMapController controllerMap = await mapController.future;
    await getCurrentLocation();
    if (currentPosition.value != null){
      allMarkers.add(Marker(
        markerId: MarkerId('MyLocation'),
        icon: myLocation.value,
        position: LatLng(currentPosition.value.latitude, currentPosition.value.longitude),
        infoWindow: InfoWindow(
            title: 'My location'
        ),
      ));
      controllerMap.animateCamera(
        CameraUpdate.newLatLngZoom(
            LatLng(currentPosition.value.latitude, currentPosition.value.longitude),
            16
        ),
      );
    }
  }

  void createMarkerFull(context) {
    if (parkingLotFull.value == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/full.png')
          .then((icon) {
        parkingLotFull(icon);
      });
    }
  }

  void createMarkerNotFull(context){
    if (parkingLotNotFull.value == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/ok.png')
          .then((icon) {
        parkingLotNotFull(icon);
      });
    }
  }

  void createMarkerMyLocation(context){
    if (myLocation.value == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/my_location.png')
          .then((icon) {
        myLocation(icon);
      });
    }
  }

  void research(String text) {
    listSearch.clear();
    textSearch(text);
    if (!textSearch.isNullOrBlank && textSearch.value.length > 0) {
      listPL.forEach((element) {
        if (element.namePL.toUpperCase().contains(textSearch.value.toUpperCase())) {
          listSearch.add(element.namePL);
        }
      });
      destinationData.forEach((element) {
        if (element.name.toUpperCase().contains(textSearch.value.toUpperCase())) {
          listSearch.add(element.name);
        }
      });
    }
  }

  void queryDestination() async {
    status(Status.loading);
    final a = listPL.indexWhere((element) => element.namePL == textSearch.value);
    final b = destinationData.indexWhere((element) => element.name == textSearch.value);
    if (a + b == -2) {
      status(Status.success);
      showDialogAnnounce(content: 'Not found your destination.');
    } else {
      listPL.forEach((element) {
        if (element.namePL.toUpperCase() == textSearch.value.toUpperCase()) {
          status(Status.success);
          Get.toNamed(Routes.PARKINGLOT, arguments: element.id);
        }
      });
      destinationData.forEach((element) {
        if (element.name.toUpperCase() == textSearch.value.toUpperCase()) {
          chooseFivePL(element.location);
        }
      });
    }
  }

  Future<void> chooseFivePL(GeoPoint point2) async {
    status(Status.loading);
    if (connect.value == ConnectInternet.valid) {
      await getDistantPL(point2)
          .then((value) => value.sort((a,b) => a.distance.compareTo(b.distance)))
          .then((value){
        status(Status.success);
        Get.toNamed(Routes.FIVENEARESTPARKINGLOTS, arguments: listPL);
      });
    } else {
      status(Status.error);
      showDialogAnnounce(
          content: 'Please check your internet!'
      );
    }
  }

  Future<List<ParkingLotJson>> getDistantPL(GeoPoint point2) async {
    listPL.forEach((element) {
      countDistant(element.location, point2, element.id);
    });
    return listPL;
  }

  Future<void> countDistant(GeoPoint point1, GeoPoint point2, String id) async {
    final double distance = await Geolocator().distanceBetween(
        point1.latitude,
        point1.longitude,
        point2.latitude,
        point2.longitude
    );
    final int index = listPL.indexWhere((element) => element.id == id);
    listPL[index].distance = double.parse((distance/1000).toStringAsFixed(1));
  }

  Future<void> goToBill({VoidCallback callback}) async {
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      bill
          .where('idUser', isEqualTo: user.currentUser.uid)
          .get()
          .then((value) {
            status(Status.success);
        if (value.docs.length > 0){
          Get.back();
          Get.toNamed(Routes.LISTBILLS);
        } else {
          showDialogAnnounce(content: 'You do not have any bills');
        }
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

  Future<void> goToRent() async {
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      userState
          .where('stateRent', isEqualTo: true)
          .where('idUser', isEqualTo: user.currentUser.uid)
          .get()
          .then((value){
        status(Status.success);
        if (value.docs.length > 0) {
          Get.back();
          Get.toNamed(Routes.LISTRENTS);
        } else {
          showDialogAnnounce(content: 'You do not have any state rents');
        }
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

  Future<void> goToReservation() async {
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      userState
          .where('stateRent', isEqualTo: false)
          .where('idUser', isEqualTo: user.currentUser.uid)
          .get()
          .then((value){
        status(Status.success);
        if (value.docs.length > 0) {
          Get.back();
          Get.toNamed(Routes.LISTBOOKS);
        } else {
          showDialogAnnounce(content: 'You do not have any reservations');
        }
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

  Future<void> logOut() async {
    FirebaseAuth.instance.signOut().then((_){
      Get.until((route) => Get.currentRoute == Routes.LOGIN);
    });
  }
}
