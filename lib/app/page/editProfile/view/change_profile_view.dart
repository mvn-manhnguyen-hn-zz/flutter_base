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
  @override
  void initState() {
    controller.getData(Get.arguments);
    super.initState();
  }
  @override
  Widget buildPage(BuildContext context) {
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
                    initialValue: controller.profileModel.value.bankName,
                    onChange: (text){
                      controller.bankName(text);
                      print(controller.bankName.value);
                    }
                ),
                textFormField(
                    labelText: 'Chi nhánh ngân hàng',
                    initialValue: controller.profileModel.value.branchName,
                    onChange: (text){
                      controller.branchName(text);
                    }
                ),
                textFormField(
                    labelText: 'Tên chủ tài khoản',
                    initialValue: controller.profileModel.value.bankOwnerAccount,
                    onChange: (text){
                      controller.bankOwnerAccount(text);
                    }
                ),
                textFormField(
                    labelText: 'Tài khoản',
                    initialValue: controller.profileModel.value.bankAccount,
                    onChange: (text){
                      controller.bankAccount(text);
                    }
                ),
                textFormField(
                    labelText: 'Số điện thoại',
                    initialValue: controller.profileModel.value.phone,
                    onChange: (text){
                      controller.phone(text);
                    }
                ),
                textFormField(
                    labelText: 'Facebook Link',
                    initialValue: controller.profileModel.value.facebookNickname,
                    onChange: (text){
                      controller.facebookNickname(text);
                    }
                ),
                textFormField(
                    labelText: 'Danh sách mua hàng',
                    initialValue: controller.nicknamesUpdated.value,
                    onChange: (text){
                      controller.nicknames(text);
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
                  await controller.editData();
                  Get.back(
                    result: true
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
