import 'package:flutter/cupertino.dart';

abstract class EditProfileInterface{
  Future updateProfile({
    @required String bankName,
    @required String branchName,
    @required String bankOwnerAccount,
    @required String bankAccount,
    @required String phone,
    @required String facebookNickname,
    @required String nicknames
});
}
