import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/order/order_controller.dart';
import 'package:flutter_base/app/routes/app_routes.dart';
import 'package:flutter_base/app/widgets/colors.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/app/widgets/text_style.dart';
import 'package:flutter_base/domain/entities/product_model.dart';
import 'package:get/get.dart';

class OrderView extends View {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends ViewState<OrderView, OrderController> {

  @override
  void initState() {
    controller.fetchInformation();
    controller.fetchPaymentMethods();
    super.initState();
  }

  Widget item(ProductModel productModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: backgroundColor,
                width: 2),
            color: primaryColor,
            borderRadius: BorderRadius.circular(5)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 6, right: 6, top: 8, bottom: 8),
          child: Row(
            children: [
              Expanded(child: ListTile(
                title: Text(
                  productModel.name,
                  style: Style.article1TextStyle.copyWith(
                      color: backgroundColor
                  ),
                ),
                trailing: Text(
                  productModel.price.toString(),
                  style: Style.article1TextStyle.copyWith(
                      color:backgroundColor
                  ),
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                    Icons.info,
                    color: backgroundColor),
              )
            ],
          ),
        ),
      ),
    );
  }

  void dialogSuccess(){
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          content: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Text(
                    'Đặt hàng thành công',
                    style: Style.h7TextStyle.copyWith(color: primaryColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: RaisedButton(
                        color: primaryColor,
                        child: Text('Đóng', style: TextStyle(color: white)),
                        onPressed: () =>Get.until((route) => Get.currentRoute == Routes.HOME)
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Đặt hàng'),
      ),
      body: Obx(() => Column(
        children: [
          Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  listTitle(
                      title: 'Nick mua hàng',
                      onPressed: (){
                        controller.showAccount.value ?
                        controller.showAccount(false) :
                        controller.getWidget(
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
                        controller.getWidget(
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
                        controller.getWidget(
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
                        controller.getWidget(
                            list: controller.listPaymentMethods,
                            selectedValue: controller.selectedPaymentMethods,
                            show: controller.showPaymentMethod
                        );
                      }
                  )
                      : Container(),
                  listTitle(
                      title: 'Sản phẩm đã chọn',
                      onPressed: () async {
                        controller.totalMoney(0);
                        final result = await Get.toNamed(Routes.PRODUCT);
                        controller.listProductChose(result);
                        controller.listProductChose.forEach((element) {
                          final i = controller.totalMoney + element.price;
                          controller.totalMoney(i.toInt());
                        });
                      }
                  ),
                  Column(
                    children: controller.listProductChose.map((element) =>
                        item(element)).toList(),
                  ),
                  textField(labelText: 'Ghi chú')
                ],
              )),
          Column(
            children: [
              Container(
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
                        '${controller.totalMoney}',
                        style: Style.h7TextStyle.copyWith(color: cerulean),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  color: cerulean,
                  onPressed: () => dialogSuccess(),
                  child: Text(
                    'xác nhận',
                    style: Style.h7TextStyle.copyWith(
                        color: backgroundColor,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
