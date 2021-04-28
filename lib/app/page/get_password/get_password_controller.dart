import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_core/rx_impl.dart';

class GetPassWordController extends Controller{
  final email = Rx<String>();
  final emailError = Rx<String>();

  Future<void> checkEmail(BuildContext context) async {
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      FirebaseAuth.instance.sendPasswordResetEmail(email: email.toString()).then((value){
        status(Status.success);
        dialogAlert(
            'Please check your email to get new password',
            context,
            callback: () => Get.until((route) => Get.currentRoute == Routes.LOGIN)
        );
      }).catchError((e) => checkError(e.toString()));
    } else {
      showDialogAnnounce(
          content: 'Please check your internet!'
      );
    }
  }

  void checkError(String error) {
    status(Status.error);
    print(error);
    if (error == '[firebase_auth/invalid-email] The email address is badly formatted.') {
      emailError('The email address is badly formatted.');
    } else if (error == '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
      emailError('User not found');
    }
  }
}
