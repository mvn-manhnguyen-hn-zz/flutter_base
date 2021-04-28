import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/profile/profile_controller.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';

class Email extends View {
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends ViewState<Email, ProfileController> {

  void changeEmail() {
    if (controller.checkEmailNew()){
      controller.changeEmail();
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Obx(() => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Change email'),
      ),
      body: controller.userProfile.value.isNullOrBlank ? Container() :
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              controller.userProfile.value.email,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text('If you want to change your email, please enter your new email below',
                style: TextStyle(fontSize: 18),
              ),
            ),
            textField(
                onChange: (text) => controller.emailNew(text),
                errorText: controller.emailNewError.value,
                onTap: () => controller.emailNewError('null')
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: RaisedButton(
                color: Colors.green,
                onPressed: () => changeEmail(),
                child: Text(
                    'change email'
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
