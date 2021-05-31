import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/data/firebase_constant/constant.dart';
import 'package:flutter_base/data/model/user_model.dart';
import 'package:get/get.dart';

class ProfileController extends Controller {
  final selectedIndex = 0.obs;
  final userProfile = Rx<UserJson>();
  final nameNew = Rx<String>();
  final numberPhoneNew = Rx<String>();
  final licensePlateNew = Rx<String>();
  final emailNew = Rx<String>();
  final emailNewError = Rx<String>();
  final passwordNew = Rx<String>();
  final visiblePasswordNew = false.obs;
  final passwordNewError = Rx<String>();
  final passwordCheck = Rx<String>();
  final visiblePasswordCheck = false.obs;
  final passwordCheckError = Rx<String>();
  final passwordOld = Rx<String>();
  final visiblePasswordOld = false.obs;
  final passwordOldError = Rx<String>();

  void onItemTapped(int index) => selectedIndex(index);

  void getUserInformation() async {
    await checkInternet();
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      users
          .doc(user.currentUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot){
        userProfile(UserJson.fromJson(documentSnapshot.data()));
        status(Status.success);
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

  Future<void> changeInformation() async {
    await checkInternet();
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      users
          .doc(user.currentUser.uid)
          .update(
          UserJson(
            name: nameNew.value ?? userProfile.value.name,
            numberPhone: numberPhoneNew.value ?? userProfile.value.numberPhone,
            licensePlate: licensePlateNew.value ?? userProfile.value.licensePlate,
          ).toJson()
      )
          .then((value){
        status(Status.success);
        showDialogAnnounce(
          content: 'Changed successfully your information',
          onCancel: () => Get.until((route) => Get.currentRoute == Routes.HOME)
        );
      })
          .catchError((error){
        print("Failed to update user: $error");
        status(Status.error);
      });
    } else {
      status(Status.error);
      showDialogAnnounce(
          content: 'Please check your internet!'
      );
    }
  }

  bool checkEmailNew() {
    if (emailNew.value == userProfile.value.email) {
      emailNewError('The new email is the same the old email');
      return false;
    } else if (!emailNew.value.endsWith('@gmail.com')){
      emailNewError('The email address is badly formatted');
      return false;
    }
    emailNewError('null');
    return true;
  }

  void changeEmail() async {
    await checkInternet();
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      user.currentUser.updateEmail(emailNew.value)
      .then((value){
        users
        .doc(user.currentUser.uid)
            .update({
          'email' : emailNew.value
        }).then((_){
          status(Status.success);
          showDialogAnnounce(
              content: 'Your email changed\n'
                  'Please log in again to use your account',
              onCancel: (){
                user.signOut().then((_){
                  Get.until((route) => Get.currentRoute == Routes.LOGIN);
                });
              }
          );
        }).catchError((e){
          print('Error: $e');
          status(Status.error);
        });
      });
    } else {
      status(Status.error);
      showDialogAnnounce(
          content: 'Please check your internet!'
      );
    }
  }

  void togglePasswordOld() => visiblePasswordOld(!visiblePasswordOld.value);

  void togglePasswordNew() => visiblePasswordNew(!visiblePasswordNew.value);

  void togglePasswordCheck() => visiblePasswordCheck(!visiblePasswordCheck.value);

  bool checkPassword() {
    if (passwordOld.value != userProfile.value.password) {
      passwordCheckError('null');
      passwordNewError('null');
      passwordOldError('Old password is incorrect');
      return false;
    }
    if (passwordNew.value.length <= 6) {
      passwordCheckError('null');
      passwordNewError('New password is too week');
      passwordOldError('null');
      return false;
    }
    if (passwordCheck.value != passwordNew.value) {
      passwordCheckError('New password is incorrect');
      passwordNewError('null');
      passwordOldError('null');
      return false;
    }
    passwordCheckError('null');
    passwordNewError('null');
    passwordOldError('null');
    return true;
  }

  void changePassword() async {
    await checkInternet();
    if (connect.value == ConnectInternet.valid) {
      status(Status.loading);
      user.currentUser.updatePassword(passwordNew.value).then((_){
        users
            .doc(user.currentUser.uid)
            .update({
          'password' : passwordNew.value
        }).then((value){
          status(Status.success);
          showDialogAnnounce(
              content: 'Your information changed\n'
                  'Please log in again to use your account',
              onCancel: () {
                FirebaseAuth.instance.signOut().then((value){
                  Get.until((route) => Get.currentRoute == Routes.LOGIN);
                });
              }
          );
        });
      }).catchError((e){
        print('Error: $e');
        status(Status.error);
      });
    } else {
      status(Status.error);
      showDialogAnnounce(
          content: 'Please check your internet!'
      );
    }
  }
}
