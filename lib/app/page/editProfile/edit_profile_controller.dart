import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/domain/interfaces/edit_profile_interface.dart';

class EditProfileController extends Controller{
  EditProfileController({this.editProfileInterface});
  final EditProfileInterface editProfileInterface;

  editData({
    @required String bankName,
    @required String branchName,
    @required String bankOwnerAccount,
    @required String bankAccount,
    @required String phone,
    @required String facebookNickname,
    @required String nicknames
}){
    editProfileInterface.updateProfile(
        bankName: bankName,
        branchName: branchName,
        bankOwnerAccount: bankOwnerAccount,
        bankAccount: bankAccount,
        phone: phone,
        facebookNickname: facebookNickname,
        nicknames: nicknames
    );
  }
}
