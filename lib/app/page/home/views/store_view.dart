import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/home/home_controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:get/get.dart';

class StoreView extends View {
  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends ViewState<StoreView, HomeController> {
  @override
  void initState() {
    super.initState();
    controller.fetchListShop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildPage(context) {
    return Obx(() => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Cửa hàng'),
                backgroundColor: Color(0xff7C4DFF),
              ),
              body: ListView.builder(
                itemCount: controller.listShop.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.ORDER);
                    },
                    child: Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.storefront,
                          color: Color(0xff7C4DFF),
                        ),
                        title: Text(
                          controller.listShop[index].name,
                          style: TextStyle(
                            color: Color(0xff7C4DFF),
                          ),
                        ),
                        trailing: Icon(
                          Icons.add_shopping_cart,
                          color: Color(0xff7C4DFF),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
