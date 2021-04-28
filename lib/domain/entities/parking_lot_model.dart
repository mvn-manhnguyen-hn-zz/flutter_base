import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingLotJson {
  bool statePL;
  String address;
  String namePL;
  int price;
  String id;
  int deposit;
  int numberPhone;
  int penalty;
  GeoPoint geoPoint;
  double distance;
  int totalPoints;
  int pointsUsed;

  ParkingLotJson(
      {this.statePL,
        this.address,
        this.namePL,
        this.price,
        this.id,
        this.deposit,
        this.numberPhone,
        this.penalty,
        this.geoPoint,
        this.distance,
        this.totalPoints,
        this.pointsUsed
      });

  ParkingLotJson.fromJson(Map<String, dynamic> json) {
    statePL = json['statePL'];
    address = json['address'];
    namePL = json['namePL'];
    price = json['price'];
    id = json['id'];
    deposit = json['deposit'];
    numberPhone = json['numberPhone'];
    penalty = json['penalty'];
    geoPoint = json['location'] != null
        ? json['location']
        : null;
    distance = json['distance'];
    totalPoints = json['totalPoints'];
    pointsUsed = json['pointsUsed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statePL'] = this.statePL;
    data['address'] = this.address;
    data['namePL'] = this.namePL;
    data['price'] = this.price;
    data['id'] = this.id;
    data['deposit'] = this.deposit;
    data['numberPhone'] = this.numberPhone;
    data['penalty'] = this.penalty;
    if (this.geoPoint != null) {
      data['location'] = this.geoPoint;
    }
    data['distance'] = this.distance;
    data['totalPoints'] = this.totalPoints;
    data['pointsUsed'] = this.pointsUsed;
    return data;
  }
}
