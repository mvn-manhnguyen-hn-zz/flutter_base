import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/order/order_controller.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class OrderView extends View {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends ViewState<OrderView, OrderController> {
  TextEditingController _controller;
  TextEditingController _controllerSetting;
  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController();
    _controllerSetting = new TextEditingController();
    controller.fetchProfileCustomer();
    controller.getSetting();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget buildPage(context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text("Đặt hàng"),
              centerTitle: true,
              leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.close)),
              backgroundColor: Color(0xff7C4DFF),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text(
                      'Nick mua hàng',
                      style: TextStyle(color: Color(0xff7C4DFF)),
                    ),
                    trailing: GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Obx(() => Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: controller
                                          .listProfileCustomer[0].nicknames
                                          .map((text) => RadioListTile(
                                                groupValue: controller
                                                    .radioGroupValue.value,
                                                title: Text("$text"),
                                                value: text,
                                                onChanged: (val) {
                                                  controller
                                                      .setRadioGroupValue(val);
                                                  _controller.text = "$val";
                                                  controller
                                                      .isVisibleTextfieldNick(
                                                          true);
                                                },
                                              ))
                                          .toList(),
                                    ));
                              });
                        },
                        child:
                            Icon(Icons.playlist_add, color: Color(0xff7C4DFF))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Visibility(
                    visible: controller.isVisibleTextfieldNick.value,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff7C4DFF),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: _controller,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Phương thức thanh toán',
                        style: TextStyle(color: Color(0xff7C4DFF))),
                    trailing: GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Obx(() => SingleChildScrollView(
                                      child: Column(
                                        children: controller.listSetting
                                            .map((text) => RadioListTile(
                                                  groupValue: controller
                                                      .radioGroupValue.value,
                                                  title: Text("$text"),
                                                  value: text,
                                                  onChanged: (val) {
                                                    controller
                                                        .setRadioGroupValue(
                                                            val);
                                                    _controllerSetting.text =
                                                        "$val";
                                                    controller
                                                        .isVisibleTextfieldSetting(
                                                            true);
                                                  },
                                                ))
                                            .toList(),
                                      ),
                                    ));
                              });
                        },
                        child:
                            Icon(Icons.playlist_add, color: Color(0xff7C4DFF))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Visibility(
                    visible: controller.isVisibleTextfieldSetting.value,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff7C4DFF),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: _controllerSetting,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Sản phẩm đã chọn (sosp)',
                        style: TextStyle(color: Color(0xff7C4DFF))),
                    trailing: Icon(
                      Icons.playlist_add,
                      color: Color(0xff7C4DFF),
                    ),
                  ),
                ),
                Card(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Ghi chú',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            bottomSheet: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Text('Tổng tiền: '), Text('soTien đ')],
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    color: Color(0xff7C4DFF),
                    child: Center(
                        child: Text(
                      'Xác nhận',
                      style: TextStyle(color: Colors.white),
                    )),
                  )
                ],
              ),
            ),
          ),
          loading(status: controller.status.value, context: context)
        ],
      ),
    );
    //loading(status: controller.status.value, context: context)
  }
}
