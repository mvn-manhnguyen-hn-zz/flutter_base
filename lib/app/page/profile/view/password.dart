import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/profile/profile_controller.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';

class Password extends View {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends ViewState <Password, ProfileController> {

  void checkPassword() {
    if (controller.checkPassword()) {
      controller.changePassword();
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Obx(() => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Change password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Enter your old password'
            ),
            textField(
                onChange: (passwordOld) => controller.passwordOld(passwordOld),
                errorText: controller.passwordOldError.toString(),
                suffixIcon: IconButton(
                  onPressed: () => controller.togglePasswordOld(),
                  icon: Icon(controller.visiblePasswordOld.value ?  Icons.visibility : Icons.visibility_off, color: Colors.black),
                ),
                obscureText: !controller.visiblePasswordOld.value,
                onTap: () => controller.passwordOldError('null')
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                  'Enter your new password'
              ),
            ),
            textField(
                onChange: (passwordNew) => controller.passwordNew(passwordNew),
                errorText: controller.passwordNewError.toString(),
                suffixIcon: IconButton(
                  onPressed: () => controller.togglePasswordNew(),
                  icon: Icon(controller.visiblePasswordNew.value ? Icons.visibility : Icons.visibility_off, color: Colors.black),
                ),
                obscureText: !controller.visiblePasswordNew.value,
                onTap: () => controller.passwordNewError('null')
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                  'Enter your new password again'
              ),
            ),
            textField(
                onChange: (passwordCheck) => controller.passwordCheck(passwordCheck),
                errorText: controller.passwordCheckError.toString(),
                suffixIcon: IconButton(
                  onPressed: () => controller.togglePasswordCheck(),
                  icon: Icon(controller.visiblePasswordCheck.value ? Icons.visibility : Icons.visibility_off, color: Colors.black),
                ),
                obscureText: !controller.visiblePasswordCheck.value,
                onTap: () => controller.passwordCheckError('null')
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Center(
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: () => checkPassword(),
                  child: Text('Change'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
