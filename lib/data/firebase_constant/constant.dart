import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth user = FirebaseAuth.instance;
final CollectionReference users = FirebaseFirestore.instance.collection('users');
final CollectionReference parkingLot = FirebaseFirestore.instance.collection('parkingLot');
final CollectionReference userState = FirebaseFirestore.instance.collection('userState');
final CollectionReference bill = FirebaseFirestore.instance.collection('bill');
