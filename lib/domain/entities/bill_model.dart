import 'package:cloud_firestore/cloud_firestore.dart';

class BillJson {
  String addressPL;
  String namePL;
  String nameUser;
  int phoneNumbersPL;
  String idUser;
  String idPoint;
  String idPL;
  int deposit;
  int price;
  int penalty;
  Timestamp rentedTime;
  Timestamp returnTime;
  String idBill;
  int timeUsed;
  int timeOverdue;

  BillJson(
      {this.addressPL,
        this.namePL,
        this.nameUser,
        this.phoneNumbersPL,
        this.idUser,
        this.idPoint,
        this.idPL,
        this.deposit,
        this.price,
        this.penalty,
        this.returnTime,
        this.rentedTime,
        this.idBill,
        this.timeUsed,
        this.timeOverdue
      });

  BillJson.fromJson(Map<String, dynamic> json) {
    addressPL = json['addressPL'];
    namePL = json['namePL'];
    nameUser = json['nameUser'];
    phoneNumbersPL = json['phoneNumbersPL'];
    idUser = json['idUser'];
    idPoint = json['idPoint'];
    idPL = json['idPL'];
    deposit = json['deposit'];
    price = json['price'];
    penalty = json['penalty'];
    rentedTime = json['rentedTime'];
    returnTime = json['returnTime'];
    idBill = json['idBill'];
    timeUsed = json['timeUsed'];
    timeOverdue = json['timeOverdue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressPL'] = this.addressPL;
    data['namePL'] = this.namePL;
    data['nameUser'] = this.nameUser;
    data['phoneNumbersPL'] = this.phoneNumbersPL;
    data['idUser'] = this.idUser;
    data['idPoint'] = this.idPoint;
    data['idPL'] = this.idPL;
    data['deposit'] = this.deposit;
    data['price'] = this.price;
    data['penalty'] = this.penalty;
    data['rentedTime'] = this.rentedTime;
    data['returnTime'] = this.returnTime;
    data['idBill'] = this.idBill;
    data['timeUsed'] = this.timeUsed;
    data['timeOverdue'] = this.timeOverdue;
    return data;
  }
}
