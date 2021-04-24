import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/data/firebase_constant/constant.dart';
import 'package:get/get_rx/src/rx_core/rx_impl.dart';

class RegisterController extends Controller {
  final email = Rx<String>();
  final emailError = Rx<String>();
  final password = Rx<String>();
  final passwordError = Rx<String>();
  final name = Rx<String>();
  final nameError = Rx<String>();
  final licensePlace = Rx<String>();
  final licensePlaceError = Rx<String>();
  final passwordCheck = Rx<String>();
  final passwordCheckError = Rx<String>();
  final numberPhone = Rx<String>();
  final numberPhoneError = Rx<String>();

  bool checkRegister() {
    if (name.toString() == 'null'){
      nameError('Name is empty');
      print('Name is empty');
      return false;
    } else {
      nameError('null');
    }
    if (email.toString() == 'null' || email.toString().isEmpty){
      emailError('Email is empty');
      print('Email is empty');
      return false;
    } else if (email.toString().endsWith('@gmail.com')){
      emailError('null');
    } else {
      emailError('The email address is badly formatted');
      print('Format is badly');
      return false;
    }
    if (password.toString().length<=6) {
      passwordError('Password too week');
      print('Password too week');
      return false;
    } else {
      passwordError('null');
    }
    if (passwordCheck.toString()!=password.toString()) {
      passwordCheckError('Password is not correct');
      return false;
    } else {
      passwordCheckError('null');
    }
    if (numberPhone.toString().isEmpty || numberPhone.toString() == 'null'){
      numberPhoneError('Number phone is empty');
      return false;
    } else {
      numberPhoneError('null');
    }
    if (licensePlace.toString().isEmpty || licensePlace.toString() == 'null'){
      licensePlaceError('License is empty');
      return false;
    } else {
      licensePlaceError('null');
    }
    return true;
  }

  Future<void> createUser({VoidCallback callback}) async {
    try {
      print('Email: $email  Password: $password');
      UserCredential userCredential = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      users
          .doc(user.currentUser.uid)
          .set({
        'name': name.toString(),
        'email': email.toString(),
        'password': password.toString(),
        'numberPhone': numberPhone.toString(),
        'licensePlate': licensePlace.toString(),
        'id': user.currentUser.uid.toString(),
      })
          .then((value) {
        print("User Added");
        callback?.call();
      })
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      print('Error FirebaseAuthException: $e');
      emailError('The email address is already in use by another account');
    } catch (e) {
      print('Error: $e');
    }
  }
}
