import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/register/register_controller.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';

class RegisterView extends View {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends ViewState<RegisterView, RegisterController> {

  @override
  void initState() {
    controller.checkInternet();
    super.initState();
  }

  void submit(){
    if (controller.checkRegister()){
      controller.createUser(
          callback:() => Get.back(result: controller.name.toString())
      );
    }
  }

  String errorTextNumberPhone(String error) {
    if (error.isEmpty || error == 'null'){
      return null;
    }
    return error;
  }

  @override
  Widget buildPage(BuildContext context) {
    return Obx(() => Stack(
      children: [
        Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.blue[300],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.blue[300],
              title: Text(
                'Enter your information',
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Your name'),
                      textField(
                          onChange: (name) {
                            controller.name(name);
                          },
                          errorText: controller.nameError.toString(),
                          onTap: () => controller.nameError('null')
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Your email'),
                      ),
                      textField(
                          onChange: (email){
                            controller.email(email);
                          },
                          errorText: controller.emailError.toString(),
                          onTap: () => controller.emailError('null')
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Your password'),
                      ),
                      textField(
                          onChange: (password){
                            controller.password(password);
                          },
                          errorText: controller.passwordError.toString(),
                          onTap: () => controller.passwordError('null')
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Enter your password again'),
                      ),
                      textField(
                          onChange: (password){
                            controller.passwordCheck(password);
                          },
                          errorText: controller.passwordCheckError.toString(),
                          onTap: () => controller.passwordCheckError('null')
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Number Phone'),
                      ),
                      TextField(
                        onTap: () => controller.numberPhoneError('null'),
                        onChanged: (number){
                          controller.numberPhone(number);
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        style: TextStyle(fontSize: 21),
                        decoration: new InputDecoration(
                            errorText: errorTextNumberPhone(controller.numberPhoneError.toString()),
                            contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20)
                                )
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20)
                              ),
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Your license plate'),
                      ),
                      textField(
                          onChange: (license){
                            controller.licensePlace(license);
                          },
                          errorText: controller.licensePlaceError.toString()
                      ),
                      Center(
                        child: RaisedButton(
                          color: Colors.green,
                          onPressed: () => submit(),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
        ),
        loading(
            status: controller.status.value,
            context: context
        )
      ],
    ));
  }
}
