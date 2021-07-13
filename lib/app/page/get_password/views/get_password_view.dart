import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/get_password/get_password_controller.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';

class GetPassword extends View {
  @override
  _GetPasswordState createState() => _GetPasswordState();
}

class _GetPasswordState extends ViewState<GetPassword, GetPassWordController> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
                'Forgot password'
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Enter your email',
                  ),
                  textField(
                      onChange: (email) {
                        controller.email(email);
                      },
                      errorText: controller.emailError.toString()
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Center(
                      child: RaisedButton(
                        color: Colors.green,
                        onPressed: () => controller.checkEmail(context),
                        child: Text(
                            'Get password'
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        loading(
            status: controller.status.value,
            context: context
        )
      ],
    ));
  }
}
