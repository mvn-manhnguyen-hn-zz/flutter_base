import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/colors.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/app/widgets/text_style.dart';
import 'package:get/get.dart';
import '../home_controller.dart';

class ShopView extends View {
  @override
  _ShopViewState createState() => _ShopViewState();
}

class _ShopViewState extends ViewState<ShopView, HomeController> {
  @override
  void initState() {
    controller.fetchListShop();
    super.initState();
  }
  @override
  Widget buildPage(BuildContext context) {
    // TODO: implement buildPage
    return Obx(() => Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Cửa hàng'),
            ),
            body: ListView.builder(
                itemCount: controller.listShop.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Icon(Icons.shopping_cart, color: cerulean),
                    title: Text(
                      controller.listShop[index].name,
                      style: Style.article3TextStyle.copyWith(color: cerulean),
                    ),
                    leading: Icon(Icons.storefront, color: cerulean),
                    onTap: (){
                      Get.toNamed(
                        Routes.ORDER,
                        arguments: controller.listShop[index].id
                      );
                    },
                  );
                })),
        loading(
            status: controller.status.value,
            context: context)
      ],
    ));
  }
}
