import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/domain/entities/profile_model.dart';
import 'package:flutter_base/domain/interfaces/edit_profile_interface.dart';
import 'package:get/get.dart';

class EditProfileController extends Controller{
  EditProfileController({this.editProfileInterface});
  final EditProfileInterface editProfileInterface;
  final Rx<String> bankName = Rx<String>();
  final Rx<String> branchName = Rx<String>();
  final Rx<String> bankOwnerAccount = Rx<String>();
  final Rx<String> bankAccount = Rx<String>();
  final Rx<String> phone = Rx<String>();
  final Rx<String> facebookNickname = Rx<String>();
  final Rx<String> nicknames = Rx<String>();
  final Rx<ProfileModel> profileModel = Rx<ProfileModel>();
  final Rx<String> nicknamesUpdated = Rx<String>();
  getData(ProfileModel data) {
    profileModel(data);
    final nicknamesUpdated1 = profileModel.value.nicknames.toString().characters.getRange(
        1, profileModel.value.nicknames.toString().length-1
    );
    nicknamesUpdated(nicknamesUpdated1.toString());
  }
  editData() async {
    await editProfileInterface.updateProfile(
        bankName: bankName.value ?? profileModel.value.bankName,
        branchName: branchName.value ?? profileModel.value.branchName,
        bankOwnerAccount: bankOwnerAccount.value ?? profileModel.value.bankOwnerAccount,
        bankAccount: bankAccount.value ?? profileModel.value.bankAccount,
        phone: phone.value ?? profileModel.value.phone,
        facebookNickname: facebookNickname.value ?? profileModel.value.facebookNickname,
        nicknames: nicknames.value ?? nicknamesUpdated.value
    );
  }
}
