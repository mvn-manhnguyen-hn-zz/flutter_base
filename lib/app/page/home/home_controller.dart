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
  final destination = List<String>();
  final allMarkers = List<Marker>();
  final parkingLotFull = Rx<BitmapDescriptor>();
  final parkingLotNotFull = Rx<BitmapDescriptor>();
  final myLocation = Rx<BitmapDescriptor>();
  final currentPosition = Rx<Position>();
  final textSearch = Rx<String>();

  List<ParkingLotJson> listPL;

  Future<void> nextToHome({VoidCallback callback}) async {
    addParkingLot();
    addPointsUsed();
    checkCurrentState();
    checkReservation();
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
      });
    } else {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentPosition.value.latitude, currentPosition.value.longitude);
    }
  }

  void getDestination() {
    parkingLot
        .get()
        .then((value){
      value.docs.forEach((element) {
        destination.add(element.data()['namePL']);
      });
    });
    destination.add('My location');
    destinationData.forEach((element) {
      destination.add(element.name);
    });
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

  void query() async {
    if (chooseDestination.value == null) {
      showDialogAnnounce(content: 'please enter your destination');
    } else {
      parkingLot
          .where('namePL', isEqualTo: chooseDestination.value)
          .get()
          .then((value){
        value.docs.forEach((element) {
          if (chooseDestination.value.compareTo(element.data()['namePL']) == 0){
            // Get.to(DetailsPL(
            //     documentId: element.data()['id']
            // ));
          }
        });
      });
      // destination.forEach((element2) {
      //   if (_chooseDestination.compareTo(element2.name) == 0){
      //     _chooseFivePL(element2.location);
      //   }
      // });
      if (chooseDestination.value.compareTo('My location') == 0){
        if (currentPosition.value == null){
          getCurrentLocation();
        } else {
          GeoPoint _geo = GeoPoint(
              currentPosition.value.latitude,
              currentPosition.value.longitude);
          chooseFivePL(_geo);
        }
      }
    }
  }

  void chooseFivePL(GeoPoint point2) async {
    await parkingLot
        .get()
        .then((value) {
      value.docs.forEach((element) {
        countDistant(element.data()['location'], point2, element.data()['id']);
      });
    });
    //Get.toNamed(Routers.FIVENEARSTPL);
  }

  Future<void> countDistant(GeoPoint point1, GeoPoint point2, String id) async {
    final double distance = await Geolocator().distanceBetween(
        point1.latitude,
        point1.longitude,
        point2.latitude,
        point2.longitude
    );
    parkingLot.doc(id)
        .update({
      'distance' : double.parse((distance/1000).toStringAsFixed(1))
    });
  }

  Future<void> goToBill({VoidCallback callback}) async {
    await checkInternet();
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
    await checkInternet();
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
    await checkInternet();
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
