import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/editProfile/edit_profile_controller.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/domain/entities/profile_model.dart';
import 'package:get/get.dart';

class EditProfileView extends View {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ViewState<EditProfileView, EditProfileController> {
  String bankName, branchName, bankOwnerAccount, bankAccount, phone, facebookNickname, nicknames;
  @override
  Widget buildPage(BuildContext context) {
    final ProfileModel profileModel = Get.arguments;
    final nicknamesUpdated = profileModel.nicknames.toString().characters.getRange(
        1, profileModel.nicknames.toString().length-1
    );
    // TODO: implement buildPage
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chỉnh sửa thông tin'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 55),
            child: ListView(
              children: [
                textFormField(
                    labelText: 'Tên ngân hàng',
                    initialValue: profileModel.bankName,
                    onChange: (text){
                      bankName = text;
                    }
                ),
                textFormField(
                    labelText: 'Chi nhánh ngân hàng',
                    initialValue: profileModel.branchName,
                    onChange: (text){
                      branchName = text;
                    }
                ),
                textFormField(
                    labelText: 'Tên chủ tài khoản',
                    initialValue: profileModel.bankOwnerAccount,
                    onChange: (text){
                      bankOwnerAccount = text;
                    }
                ),
                textFormField(
                    labelText: 'Tài khoản',
                    initialValue: profileModel.bankAccount,
                    onChange: (text){
                      bankAccount = text;
                    }
                ),
                textFormField(
                    labelText: 'Số điện thoại',
                    initialValue: profileModel.phone,
                    onChange: (text){
                      phone = text;
                    }
                ),
                textFormField(
                    labelText: 'Facebook Link',
                    initialValue: profileModel.facebookNickname,
                    onChange: (text){
                      facebookNickname = text;
                    }
                ),
                textFormField(
                    labelText: 'Danh sách mua hàng',
                    initialValue: profileModel.nicknames.toString(),
                    onChange: (text){
                      nicknames = text;
                    }
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () async {
                  await controller.editData(
                    bankName: bankName ?? profileModel.bankName,
                    branchName: branchName ?? profileModel.branchName,
                    bankOwnerAccount: bankOwnerAccount ?? profileModel.bankOwnerAccount,
                    bankAccount: bankAccount ?? profileModel.bankAccount,
                    phone: phone ?? profileModel.phone,
                    facebookNickname: facebookNickname ?? profileModel.facebookNickname,
                    nicknames: nicknames ?? nicknamesUpdated.toString(),
                  );
                  Get.back(
                    result: 'true'
                  );
                },
                child: Text('Xác nhận'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
