import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/profile/profile_controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ProfileView extends View {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends ViewState<ProfileView, ProfileController> {
  @override
  void initState() {
    controller.fetchInformation();
    super.initState();
  }


  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Cá nhân'),
            actions: [
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    final result = await Get.toNamed(
                        Routes.EDITPROFILE,
                        arguments: controller.information.value
                    );
                    if (result == 'true') controller.fetchInformation();
                  }
              )
            ],
          ),
          body: controller.information.value == null ?
              Container() :
              showInformation(
                profileModel: controller.information.value,
                context: context,
                endBankAccount: controller.endBankAccount.value
              )
        ),
        loading(
            status: controller.status.value,
            context: context)
      ],
    ));
  }
}
