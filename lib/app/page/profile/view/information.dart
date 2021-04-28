import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/profile/profile_controller.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';

class Information extends View {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends ViewState<Information, ProfileController> {

  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Obx(() => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Information'),
      ),
      body: controller.userProfile.value.isNullOrBlank ? Container() :
      ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Name'),
                textFormField(
                    initialValue: controller.userProfile.value.name,
                    onChanged: (text) => controller.nameNew(text)
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text('Your number phone'),
                ),
                TextFormField(
                  initialValue: controller.userProfile.value.numberPhone,
                  onChanged: (number){
                    controller.numberPhoneNew(number);
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(fontSize: 21),
                  decoration: new InputDecoration(
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
                textFormField(
                    initialValue: controller.userProfile.value.licensePlate,
                    onChanged: (text) => controller.licensePlateNew(text)
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 80),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          color: Colors.green,
                          onPressed: () => controller.changeInformation(),
                          child: Text('Change'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
