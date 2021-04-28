import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/data/firebase_constant/constant.dart';
import 'package:get/get.dart';

class LoginController extends Controller {
  final email = Rx<String>();
  final emailError = Rx<String>();
  final password = Rx<String>();
  final passwordError = Rx<String>();
  final visible = false.obs;

  void toggle() {
    visible(!visible.value);
  }

  Future<void> loginUser({VoidCallback callback}) async {
    if (connect.value == ConnectInternet.valid) {
      try {
        status(Status.loading);
        print('Email: $email Password: $password');
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.toString(),
            password: password.toString()
        ).then((value){
          users
              .doc(user.currentUser.uid)
              .update({
            'password' : password.toString()
          }).then((value){
            status(Status.success);
            callback();
          });
        })
            .catchError((e) => checkError(e.toString()));
      } on FirebaseAuthException catch (e) {
        print(e.code);
      }
    } else {
      showDialogAnnounce(
          content: 'Please check your internet!'
      );
    }
  }

  void checkError(String error) {
    status(Status.error);
    if (error == '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
      emailError('No user found for that email.');
      passwordError('null');
    } else if (error == '[firebase_auth/invalid-email] The email address is badly formatted.'){
      emailError('The email address is badly formatted.');
      passwordError('null');
    } else if (error == '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
      emailError('null');
      passwordError('Wrong password');
    } else if (error == '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.') {
      emailError('This account is blocked. Try again later.');
      passwordError('null');
    }
  }
}
