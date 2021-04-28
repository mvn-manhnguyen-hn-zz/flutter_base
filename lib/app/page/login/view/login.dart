import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/login/login_controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';

class Login extends View {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ViewState<Login, LoginController> {

  @override
  void initState() {
    controller.checkInternet();
    super.initState();
  }

  @override
  Widget buildPage(context) {
    return Obx(() => Stack(
      children: [
        Scaffold(
            resizeToAvoidBottomInset: false,
            body: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/cars.jpg'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 320,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email'),
                      textField(
                          onChange: (email) {
                            controller.email(email);
                          },
                          errorText: controller.emailError.toString(),
                          onTap: () => controller.emailError('null')
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Password'),
                      ),
                      textField(
                          onChange: (password) {
                            controller.password(password);
                          },
                          errorText: controller.passwordError.toString(),
                          suffixIcon: IconButton(
                            onPressed: () => controller.toggle(),
                            icon: Icon(controller.visible.value ? Icons.visibility : Icons.visibility_off, color: Colors.black),
                          ),
                          obscureText: !controller.visible.value,
                          onTap: () => controller.passwordError('null')
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: ()async{
                                final result = await Get.toNamed(Routes.REGISTER);
                                if (result != null) {
                                  Get.showSnackbar(
                                      GetBar(
                                        message: '$result.. Register successful!',
                                        duration: Duration(seconds: 3),
                                      )
                                  );
                                }
                              },
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text(
                                'Register',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: RaisedButton(
                                onPressed: () => controller.loginUser(
                                    callback: () => Get.toNamed(Routes.SPLASH)
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                color: Colors.green,
                                child: Text(
                                  'Log In',
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: GestureDetector(
                            onTap: (){
                              Get.toNamed(Routes.GETPASSWORD);
                            },
                            child: Center(
                              child: Text(
                                'Forgot the password?',
                                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                )
              ],
            )),
        loading(
          status: controller.status.value,
          context: context
        )
      ],
    ));
  }
}
