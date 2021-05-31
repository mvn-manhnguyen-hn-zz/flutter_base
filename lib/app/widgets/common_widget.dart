import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/controller.dart';
import 'package:get/get.dart';

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
                  child: Text('OK', style: TextStyle(color: Colors.white)),
                  onPressed: () {
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

Future<void> showDialogAnnounce({
  @required String content,
  Function onCancel
}) async {
  Get.defaultDialog(
      title: 'Announce',
      middleText: content,
      textCancel: 'ok',
      cancelTextColor: Colors.red,
      buttonColor: Colors.green,
      onCancel: onCancel
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

Widget textField({
  String errorText,
  VoidCallback onPressed,
  Function(String) onChange,
  IconButton suffixIcon,
  bool obscureText,
  VoidCallback onTap,
  TextEditingController controller
  }){
  return TextField(
    controller: controller,
    onTap: onTap,
    onChanged: onChange,
    obscureText: obscureText ?? false,
    style: TextStyle(fontSize: 21),
    decoration: InputDecoration(
        errorText: errorText == 'null' ? null : errorText,
        suffixIcon: suffixIcon,
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
  );
}

Widget text(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Text(
      text,
      style: TextStyle(fontSize: 21),
    ),
  );
}

Widget richText({
  String text1, text2
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: RichText(
      text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: text1, style: TextStyle(fontSize: 21, color: Colors.black)),
            TextSpan(text: text2, style: TextStyle(fontSize: 21, color: Colors.black)),
          ]
      ),
    ),
  );
}

Widget buttonError({VoidCallback callback}) {
  return Center(
    child: RaisedButton(
      onPressed: () => callback(),
      child: text('Reload'),
      color: Colors.blue,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
    ),
  );
}

Widget textFormField({
  String initialValue,
  Function(String) onChanged,
  String errorText
}) {
  return TextFormField(
    initialValue: initialValue,
    onChanged: onChanged,
    style: TextStyle(fontSize: 21),
    decoration: InputDecoration(
        errorText: errorText == 'null' ? null : errorText,
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
  );
}

Future<void> showDialogChoose({
  @required String content,
  Function onConfirm,
  String textCancel,
  String textConfirm
}) async {
  Get.defaultDialog(
    title: 'Announce',
    middleText: content,
    textCancel: textCancel,
    cancelTextColor: Colors.red,
    textConfirm: textConfirm,
    confirmTextColor: Colors.green,
    buttonColor: Colors.yellow,
    onConfirm: onConfirm,
  );
}
