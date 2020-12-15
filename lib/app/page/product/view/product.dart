import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/product/product_controller.dart';
import 'package:flutter_base/app/widgets/colors.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:flutter_base/domain/entities/product_model.dart';
import 'package:get/get.dart';

class ProductView extends View {
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends ViewState<ProductView, ProductController> {
  @override
  void initState() {
    super.initState();
    controller.fetchListProduct();
    controller.fetchListCategory();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    //controller.initListCheck(controller.listProduct.length);
    return Obx(() => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Get.back(result: controller.listSelected);
                    }),
                title: Text("Sản Phẩm"),
                centerTitle: true,
                backgroundColor: keyColor,
              ),
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Danh mục sản phẩm (${controller.listProduct.length})",
                          style: TextStyle(
                              fontSize: 18,
                              color: keyColor,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.filter_alt_outlined,
                            size: 30,
                          ),
                          color: keyColor,
                          onPressed: () {
                            //filter
                            print(controller.listCategory.toList());
                            showModalBottomSheet(
                                context: this.context,
                                builder: (BuildContext bc) {
                                  return Container();
                                });
                          },
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: controller.listProduct.length,
                    itemBuilder: (context, index) {
                      return ProductItem(
                        index: index,
                        listProduct: controller.listProduct,
                      );
                    },
                  ),
                ],
              ),
            ),
            loading(status: controller.status.value, context: context)
          ],
        ));
  }
}

class ProductItem extends StatefulWidget {
  final int index;
  final List<ProductModel> listProduct;

  ProductItem({@required this.index, @required this.listProduct});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  ProductController controller = Get.find();
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: check ? keyColor : Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(width: 1, color: keyColor)),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 10,
        ),
        child: ListTile(
            onTap: () {
              //selected
              if (controller.listSelected
                  .contains(widget.listProduct[widget.index])) {
                controller.listSelected.removeWhere(
                    (item) => item == widget.listProduct[widget.index]);
                print(controller.listSelected.length);
                setState(() {
                  check = false;
                });
              } else {
                controller.listSelected.add(widget.listProduct[widget.index]);
                print(controller.listSelected.length);
                setState(() {
                  check = true;
                });
              }
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.listProduct[widget.index].name,
                    style: TextStyle(
                      fontSize: 16,
                      color: check ? Colors.white : keyColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  widget.listProduct[widget.index].price.toString() + "đ",
                  style: TextStyle(
                    fontSize: 16,
                    color: check ? Colors.white : keyColor,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.info),
              color: check ? Colors.white : keyColor,
              iconSize: 25,
              onPressed: () {},
            )),
      ),
    );
  }
}
