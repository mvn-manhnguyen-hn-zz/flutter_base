import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/order/order_controller.dart';
import 'package:flutter_base/app/widgets/colors.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/app/widgets/text_style.dart';
import 'package:get/get.dart';

class OrderView extends View {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends ViewState<OrderView, OrderController> {
  void getWidget({
    @required List<String> list,
    @required RxString selectedValue,
    @required RxBool show
}){
    Get.bottomSheet(
        Container(
          width: double.infinity,
          color: white,
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index){
                return Obx(() => radioListTitle(
                    value: list[index],
                    groupValue: selectedValue.value,
                    onChange: (value) {
                      selectedValue(value);
                      show(true);
                      Get.back();
                    }
                ));
              }
          ),
        )
    );
  }
  @override
  void initState() {
    controller.fetchInformation();
    controller.fetchPaymentMethods();
    super.initState();
  }
  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Đặt hàng'),
        actions: [
          IconButton(
              icon: Icon(Icons.local_convenience_store),
              onPressed: () {
                print(controller.listPaymentMethods);
              }
          )
        ],
      ),
      body: Stack(
        children: [
          Obx(() => ListView(
            children: [
              listTitle(
                  title: 'Nick mua hàng',
                  onPressed: (){
                    controller.showAccount.value ?
                    controller.showAccount(false) :
                    getWidget(
                        list: controller.nicknames.value,
                        selectedValue: controller.selectedAccount,
                        show: controller.showAccount
                    );
                  }
              ),
              controller.showAccount.value ?
              textFormField(
                  initialValue: controller.selectedAccount.value,
                  onTap: () {
                    controller.showAccount(false);
                    getWidget(
                        list: controller.nicknames.value,
                        selectedValue: controller.selectedAccount,
                        show: controller.showAccount
                    );
                  }
              )
                  : Container(),
              listTitle(
                title: 'Phương thức thanh toán',
                onPressed: (){
                  controller.showPaymentMethod.value ?
                  controller.showPaymentMethod(false) :
                  getWidget(
                      list: controller.listPaymentMethods,
                      selectedValue: controller.selectedPaymentMethods,
                      show: controller.showPaymentMethod
                  );
                }
              ),
              controller.showPaymentMethod.value ?
              textFormField(
                  initialValue: controller.selectedPaymentMethods.value,
                  onTap: () {
                    controller.showPaymentMethod(false);
                    getWidget(
                        list: controller.listPaymentMethods,
                        selectedValue: controller.selectedPaymentMethods,
                        show: controller.showPaymentMethod
                    );
                  }
              )
                  : Container(),
              listTitle(title: 'Sản phẩm đã chọn'),
              textField(labelText: 'Ghi chú')
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black,blurRadius: 3)
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng tiền',
                        style: Style.h7TextStyle.copyWith(color: cerulean),
                      ),
                      Text(
                        '0đ',
                        style: Style.h7TextStyle.copyWith(color: cerulean),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: RaisedButton(
                color: cerulean,
                onPressed: (){},
                child: Text(
                  'xác nhận',
                  style: Style.h7TextStyle.copyWith(
                      color: backgroundColor,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
