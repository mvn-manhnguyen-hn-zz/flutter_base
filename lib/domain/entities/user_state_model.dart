import 'package:cloud_firestore/cloud_firestore.dart';

class UserStateJson {
  String addressPL;
  String namePL;
  String nameUser;
  String idUser;
  String idPL;
  Timestamp rentedTime;
  Timestamp returnTime;
  int phoneNumbersPL;
  String idPoint;
  int deposit;
  int price;
  int penalty;
  String idUserState;
  bool notUsed;
  bool stateRent;

  UserStateJson(
      {this.addressPL,
        this.namePL,
        this.nameUser,
        this.idUser,
        this.idPL,
        this.returnTime,
        this.rentedTime,
        this.phoneNumbersPL,
        this.idPoint,
        this.deposit,
        this.price,
        this.penalty,
        this.idUserState,
        this.notUsed,
        this.stateRent
      });

  UserStateJson.fromJson(Map<String, dynamic> json) {
    addressPL = json['addressPL'];
    namePL = json['namePL'];
    nameUser = json['nameUser'];
    idUser = json['idUser'];
    idPL = json['idPL'];
    rentedTime = json['rentedTime'];
    returnTime = json['returnTime'];
    phoneNumbersPL = json['phoneNumbersPL'];
    idPoint = json['idPoint'];
    deposit = json['deposit'];
    price = json['price'];
    penalty = json['penalty'];
    idUserState = json['idUserState'];
    notUsed = json['notUsed'];
    stateRent = json['stateRent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressPL'] = this.addressPL;
    data['namePL'] = this.namePL;
    data['nameUser'] = this.nameUser;
    data['idUser'] = this.idUser;
    data['idPL'] = this.idPL;
    data['rentedTime'] = this.rentedTime;
    data['returnTime'] = this.returnTime;
    data['phoneNumbersPL'] = this.phoneNumbersPL;
    data['idPoint'] = this.idPoint;
    data['deposit'] = this.deposit;
    data['price'] = this.price;
    data['penalty'] = this.penalty;
    data['idUserState'] = this.idUserState;
    data['notUsed'] = this.notUsed;
    data['stateRent'] = this.stateRent;
    return data;
  }
}
