import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/product/product_controller.dart';
import 'package:flutter_base/app/widgets/colors.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/app/widgets/text_style.dart';
import 'package:get/get.dart';
import 'category_view.dart';

class ProductView extends View {
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends ViewState<ProductView, ProductController> {

  @override
  void initState() {
    controller.fetchListProduct();
    controller.fetchListCategory();
    super.initState();
  }

  void showListCategory(){
    Get.bottomSheet(
      ListCategory()
    );
  }

  Widget item(int index, bool isChose) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: (){
          if (isChose){
            controller.listProductChose.removeWhere(
                    (element) => element == controller.listProduct[index]);
          } else {
            controller.listProductChose.add(controller.listProduct[index]);
          }
          setState(() {
            isChose = !isChose;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: isChose ? backgroundColor : primaryColor,
                  width: 2),
              color: isChose ? primaryColor : backgroundColor,
              borderRadius: BorderRadius.circular(5)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 6, right: 6, top: 8, bottom: 8),
            child: Row(
              children: [
                Expanded(child: ListTile(
                  title: Text(
                    controller.listProduct[index].name,
                    style: Style.article1TextStyle.copyWith(
                        color: isChose ? backgroundColor : primaryColor
                    ),
                  ),
                  trailing: Text(
                    controller.listProduct[index].price.toString(),
                    style: Style.article1TextStyle.copyWith(
                        color: isChose ? backgroundColor : primaryColor
                    ),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                      Icons.info,
                      color: isChose ? backgroundColor : primaryColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listProduct({List listProduct, List listProductChose}){
    return Expanded(
        child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: listProduct.length,
        itemBuilder: (context, index) {
          final bool choseProduct = controller.listProductChose.contains(listProduct[index]);
          return item(index, choseProduct);
        }
    )
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Sản phẩm'),
            centerTitle: true,
            leading: IconButton(
              onPressed: (){
                Get.back(
                  result: controller.listProductChose
                );
              },
              icon: Icon(Icons.close),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Danh mục sản phẩm (${controller.listProductFilter.isEmpty ? controller.listProduct.length : controller.listProductFilter.length})',
                      style: Style.h7TextStyle.copyWith(
                        color: primaryColor
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.filter_alt_outlined, color: primaryColor, size: 30),
                        onPressed: () => showListCategory()
                    )
                  ],
                ),
              ),
              controller.listProductFilter.isEmpty ?
                  listProduct(listProduct: controller.listProduct) :
                  listProduct(listProduct: controller.listProductFilter)
            ],
          ),
        ),
        loading(
          context: context,
          status: controller.status.value
        ),
      ],
    ));
  }
}

