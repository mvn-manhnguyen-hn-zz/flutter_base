import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/domain/entities/profile_model.dart';
import 'package:flutter_base/domain/interfaces/proflie_interfaces.dart';
import 'package:get/get.dart';

class ProfileController extends Controller {
  ProfileController({@required this.profileInterface});
  final ProfileInterface profileInterface;
  final Rx<ProfileModel> information = Rx<ProfileModel>();
  final Rx<String> endBankAccount = Rx<String>();
  Future<void> fetchInformation({VoidCallback callback}) async {
    status(Status.loading);
    profileInterface.getInformation().then(
      (value) {
        final ProfileModel profileModel = information(value);
        final getEndBankAccount = profileModel.bankAccount.characters.getRange(
            profileModel.bankAccount.length - 9,
            profileModel.bankAccount.length);
        endBankAccount(getEndBankAccount.toString());
        status(Status.success);
        callback?.call();
      },
      onError: (err) {
        status(Status.error);
      },
    );
  }
}
