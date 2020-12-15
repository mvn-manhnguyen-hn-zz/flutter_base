import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/domain/interfaces/edit_profile_interface.dart';
import '../api_constant.dart';

class EditProfileRepository extends EditProfileInterface{
  final Dio dio;
  EditProfileRepository({this.dio});

  @override
  Future updateProfile({
    @required String bankName,
    @required String branchName,
    @required String bankOwnerAccount,
    @required String bankAccount,
    @required String phone,
    @required String facebookNickname,
    @required String nicknames
}) async {
    dio.put(
      ApiConstant.EDITPROFILE,
      options: await HeaderNetWorkConstant.getOptionsWithToken(),
      queryParameters: ({
        'bank_name' : bankName,
        'branch_name' : branchName,
        'bank_owner_account' : bankOwnerAccount,
        'bank_account' : bankAccount,
        'phone' : phone,
        'facebook_nickname' : facebookNickname,
        'nicknames' : nicknames
      }),
    );
    return;
  }
}
