
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:flutter_base/app/widgets/text_style.dart';
import 'package:flutter_base/domain/entities/profile_model.dart';
import 'package:get/get.dart';

void dialogYesNo(String title, BuildContext context, {Function() callback}) {
  showDialog<Null>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              Row(
                children: [
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text('Không', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Spacer(),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text('Có', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Get.back();

                      callback?.call();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

void dialogAlert(String title, BuildContext context, {Function() callback}) {
  showDialog<Null>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('Đóng', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Get.back();
                    callback?.call();
                  },
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

void dialogQuantities(String title, RxInt quantities, BuildContext context,
    {Function(int) callback, Function() remove}) {
  showDialog<Null>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Obx(() => Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 40,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            child: Text('-',
                                style: TextStyle(color: Colors.white)),
                            onPressed: quantities.value > 0
                                ? () {
                                    quantities(quantities.value - 1);
                                  }
                                : null,
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12.0),
                              child: Text(quantities.value.toString(),
                                  style: Style.article1TextStyle.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold)),
                            )),
                        SizedBox(
                          width: 40,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            child: Text('+',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              quantities(quantities.value + 1);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text('Xác nhận',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Get.back();
                        callback(quantities.value);
                      },
                    ),
                  )
                ],
              ),
            )),
      );
    },
  );
}

Widget loading({Status status, BuildContext context}) => Visibility(
      visible: status == Status.loading,
      child: Container(
        alignment: Alignment.center,
        color: Colors.black12,
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );

Widget textField(
    {String hintText,
    String helperText,
    String labelText,
    Widget prefixIcon,
    String prefixText,
    String suffixText,
    FocusNode focusNode,
    int maxLines = 1,
    bool readOnly = false,
    Function() onTap,
    double padding = 12,
    @required TextEditingController textEditingController}) {
  return Padding(
    padding: EdgeInsets.all(padding),
    child: TextField(
      maxLines: maxLines,
      focusNode: focusNode,
      onTap: onTap?.call(),
      readOnly: readOnly,
      controller: textEditingController,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
          helperText: helperText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          prefixText: prefixText,
          suffixText: suffixText),
    ),
  );
}
Widget showInformation({ProfileModel profileModel, BuildContext context}){
  final endBankAccount = profileModel.bankAccount.characters.getRange(
      profileModel.bankAccount.length-9,
      profileModel.bankAccount.length
  );
  print(endBankAccount);

  return ListView(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: boxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileModel.avatar),
                  radius: 50,
                ),
                row(textInformation('Name'), textInformation(profileModel.name)),
                row(textInformation('Số điện thoại'), textInformation(profileModel.phone)),
                row(
                  textInformation('nick name'),
                  listNickname(profileModel.nicknames, context)
                ),
                row(textInformation('Name'),
                    IconButton(
                        icon: Icon(Icons.link, color: Colors.blue),
                        onPressed: null
                    )
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: boxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                row(textInformation('Tên ngân hàng'), textInformation(profileModel.bankName)),
                row(textInformation('Chi nhánh ngân hàng'), textInformation(profileModel.branchName)),
                row(textInformation('Tên chủ tài khoản'), textInformation(profileModel.bankOwnerAccount)),
                row(
                  textInformation('Tài khoản'),
                  textInformation('***********${endBankAccount}')
                )
                //row('text1', text2)
              ],
            ),
          ),
        ),
      )
    ],
  );
}
BoxDecoration boxDecoration(){
  return BoxDecoration(
      border: Border.all(
          color: Colors.blue,
          width: 3.0
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(15)
      )
  );
}
Widget listNickname(List<String> list, BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: 150,
      height: 80,
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index){
            return Text(
                list[index],
              style: TextStyle(fontSize: 16, color: Colors.blue)
            );
          }
      ),
    ),
  );
}
Widget row(Widget text1, Widget text2){
  return Row(
    children: [
      SizedBox(
        width: 150,
        child: text1,
      ),
      SizedBox(
        width: 160,
        child: text2,
      )
    ],
  );
}
Widget textInformation(String text){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: TextStyle(fontSize: 16, color: Colors.blue),
    ),
  );
}

clearFocus(BuildContext context) {
  if (FocusScope.of(context).hasFocus) {
    FocusScope.of(context).unfocus();
  } else {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
